

Status() {
  if [ "$1" -ne 0 ]; then
    echo -e "\e[1;31m ${2} - Failure\e[0m"
    exit 1
    else
    echo -e "\e[1;32m ${2} - Success\e[0m"
  fi
}
Log_file=/tmp/roboshop.log
rm -r "${Log_file}"



