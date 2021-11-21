#!/usr/bin/env bash

declare -a urls=(
  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.idx'
  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso'
  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso.gpg'

  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso.md5'
  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso.md5.gpg'

  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso.sha3'
  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso.sha3.gpg'

  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso.sha512'
  'https://mirrors.kernel.org/mageia/iso/8/Mageia-8-i586/Mageia-8-i586.iso.sha512.gpg'
)

function get_files()
{
  if [ -n "$urls" ]; then
    for url in "${urls[@]}"; do
      wget --continue --tries=1 "$url"
    done
  fi
}

function verify_by_gpg()
{
  local signature_file="$1"

  # get the public key ID from GPG
  local keyid=$(gpg --list-packets $signature_file | grep keyid | grep -o -P '(?<=keyid )[A-Z0-9]+')
  echo "keyid=$keyid"

  # LANG=en gpg --keyserver keyserver.ubuntu.com --search-keys 835E41F4EDCA7A90

  # only download a key from a keyserver
  local temporary_directory=$(mktemp -d)
  echo "$temporary_directory"

  # retrieve the key
  GNUPGHOME=$temporary_directory LANG=en gpg --keyserver keyserver.ubuntu.com --recv-keys $keyid
  # When you close the terminal window the gnupg home directory will revert to the default ~/.gnupg.

  # display the info for the imported key
  GNUPGHOME=$temporary_directory LANG=en gpg -k $keyid

  # Exporting a public key
  GNUPGHOME=$temporary_directory LANG=en gpg --output $temporary_directory/$keyid.gpg --export $keyid

  # export the ascii-armored key file
  GNUPGHOME=$temporary_directory LANG=en gpg --armor --output $temporary_directory/$keyid.asc --export $keyid

  # ls $temporary_directory

  local filename="$2"

  # echo "GNUPGHOME=$temporary_directory LANG=en gpg --verify \"$signature_file\" \"$filename\""
  # GNUPGHOME=$temporary_directory LANG=en gpg --verify "$signature_file" "$filename"

  echo "LANG=en gpg --no-default-keyring --keyring \"$temporary_directory/$keyid.gpg\" --verify \"$signature_file\" \"$filename\""
  LANG=en gpg --no-default-keyring --keyring "$temporary_directory/$keyid.gpg" --verify "$signature_file" "$filename"

  return $?  # to exit the function with the same exit code as gpg
}

# Integrity Check
function verify_files()
{
  for f in * ; do
    local extension="${f##*.}"
    local filename="${f%.*}"

    case $extension in
      "md5")    echo "md5sum    --check $f" ; LANG=en md5sum    --quiet --check "$f" ;;
      "sha3")   echo "sha3sum   --check $f" ; sha3sum           --quiet --check "$f" ;;
      "sha512") echo "sha512sum --check $f" ; LANG=en sha512sum --quiet --check "$f" ;;
      "gpg")
        echo "gpg --verify \"$f\" \"$filename\""
        verify_by_gpg "$f" "$filename"    > /dev/null 2>&1  # prevent output from called bash function in subshell
        ;;
      *) continue ;;
    esac

    if [ $? -eq 0 ]
    then
        echo "Successful $filename verification with $f."
    else
        echo "Problem with $f."
        exit 1
    fi

    echo ""

  done
}

function delete_files()
{
  rm ./Mageia-8-i586*
}

function main()
{
  for i in "$@"; do
    case $i in
      --download)
        get_files
        shift # past argument with no value
        ;;
      --verify)
        verify_files
        shift # past argument with no value
        ;;
      --clean)
        delete_files
        shift # past argument with no value
        ;;
      *)
        # unknown option
        ;;
    esac
  done
}

main "$@"
