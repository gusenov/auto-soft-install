PACKAGE_NAME="XnViewMP-linux-x64.tgz"
PACKAGE_URL="https://www.xnview.com/download.php?file=$PACKAGE_NAME"
PACKAGE_FILE="/tmp/$PACKAGE_NAME"

function download()
{
    # Флаг -L заставляет curl автоматически следовать HTTP-редиректам (коды 3xx), 
    # пока не дойдет до итогового URL.
    curl -o "$PACKAGE_FILE" -L "$PACKAGE_URL"
}

function extract()
{
    # -x — (extract) распаковать архив
    # -v — (verbose) показывать процесс распаковки (список файлов)
    # -f — (file) указывает, что далее следует имя архива (например, tar -xvf archive.tar)
    # -C в команде tar указывает, в какую директорию перейти перед выполнением действия
    tar -xvf "$PACKAGE_FILE" -C /opt/
}

download
extract
