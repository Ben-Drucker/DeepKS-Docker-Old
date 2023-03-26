# Setup
FROM --platform=arm64 dkscd

# Install VSCode for tunnelling
COPY "vscode_script.sh" "vscode_script.sh"
RUN chmod +x vscode_script.sh
RUN ./vscode_script.sh

ARG UN=dockeruser
WORKDIR /home/$UN/docker-build

## Potentially install more dependencies after this point
COPY "additional-pip-packages.txt" "additional-pip-packages.txt"
RUN ["/bin/zsh", "-c", "source /home/$UN/python_env/bin/activate && pip install -r additional-pip-packages.txt"]
RUN ["/bin/zsh", "-c", "source /home/$UN/python_env/bin/activate && pip install \"MarkupSafe>=2.0\" && pip install torch --index-url https://download.pytorch.org/whl/cu118"]
COPY "additional-apt-packages.txt" "additional-apt-packages.txt"
RUN apt-get update && apt-get install -y $(cat "additional-apt-packages.txt")
USER $UN
RUN cd /home/$UN/DeepKS && git lfs pull && cd -
USER root

# COPY "cuda_script.sh" "cuda_script.sh"
# RUN chmod +x "cuda_script.sh"
# RUN ./cuda_script.sh
# COPY "additional-R-packages.R" "additional-R-packages.R"
# RUN Rscript additional-R-packages.R

# Install cuda-related items
# COPY "cuda_script.sh" "cuda_script.sh"
# RUN chmod +x cuda_script.sh
# RUN ./cuda_script.sh

# Final Setup
RUN ln -s ~/DeepKS /DeepKS
RUN echo 'dockeruser:dockeruser' | chpasswd 

USER $UN
WORKDIR /home/$UN
COPY "dockeruser-rc.zshrc" /home/$UN/.zshrc
CMD /bin/zsh