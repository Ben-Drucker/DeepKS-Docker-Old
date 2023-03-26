export UN=$(whoami) 
source /home/$UN/python_env/bin/activate
export PS1="%n@%m [%3~] ▷ "
export CUBLAS_WORKSPACE_CONFIG=:4096:8\n
export greeting="\n\u001b[36mWelcome to the DeepKS docker image! \n\nConsider running\n\u001b[34m\\\`git pull && cd ..\\\`\n \u001b[36mto update DeepKS to the latest version.\n\n To use the development branch of DeepKS, run \u001b[34m\n\\\`cd DeepKS && git switch dev && cd ..\\\` \n\n"

printf $greeting