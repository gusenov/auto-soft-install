is_extension_installed() {
    code --list-extensions | grep --ignore-case "$1"
}

EXTENSIONS=(
    "GitHub.copilot"
     # "GitHub.copilot-chat"
    "GitHub.vscode-github-actions"
    "GitHub.github-vscode-theme"
    
    "ms-python.python"
     # "ms-python.vscode-pylance"
     # "ms-python.debugpy"
     # "ms-python.vscode-python-envs"

    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-hub"
    
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"

    "ms-vscode.hexeditor"

    "ms-vscode-remote.remote-ssh"
     # "ms-vscode-remote.remote-ssh-edit"
     # "ms-vscode.remote-explorer"

    "Dart-Code.flutter"
)

for EXTENSION in ${EXTENSIONS[@]}; do

    # &> /dev/null — это способ полностью скрыть вывод команды, чтобы он нигде не отображался.
    # &> — это оператор оболочки, который говорит: «отправить всё (и stdout, и stderr)».

    if is_extension_installed "$EXTENSION" &> /dev/null; then
        :  # встроенная команда Bash для “ничего не делать”
        # echo "$EXTENSION installed"
    else
        # echo "$EXTENSION is not installed"
        echo "code --install-extension $EXTENSION"
    fi
done
