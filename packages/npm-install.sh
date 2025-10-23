PACKAGES=(
    "@google/gemini-cli"
    "@openai/codex"
)

for PACKAGE in ${PACKAGES[@]}; do

    if npm list -g --depth=0 | grep -q "$PACKAGE"; then
        # echo "$PACKAGE installed"
        :  # встроенная команда Bash для “ничего не делать”
    else
        # echo "$PACKAGE is not installed"
        echo "npm i -g $PACKAGE"
        # i — короткая запись для install, то есть «установить».
        # -g (или --global) — флаг, указывающий на глобальную установку, а не локальную (в папке проекта).
    fi

done
