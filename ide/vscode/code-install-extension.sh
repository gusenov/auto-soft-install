is_extension_installed() {
    code --list-extensions | grep "$1"
}

EXTENSIONS=(
    "GitHub.copilot"
    "GitHub.copilot-chat"
    
    "ms-python.python"
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-hub"
    
    "ms-vscode.cpptools"
    "ms-vscode.cpptools-extension-pack"

    "ms-vscode.hexeditor"
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
