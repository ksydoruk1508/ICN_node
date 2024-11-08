#!/bin/bash

# Цвета текста
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # Нет цвета (сброс цвета)

# Проверка наличия curl и установка, если не установлен
if ! command -v curl &> /dev/null; then
    sudo apt update
    sudo apt install curl -y
fi
sleep 1

echo -e "${GREEN}"
cat << "EOF"
██ ███    ███ ██████   ██████  ███████ ███████ ██ ██████  ██      ███████      ██████ ██       ██████  ██    ██ ██████  
██ ████  ████ ██   ██ ██    ██ ██      ██      ██ ██   ██ ██      ██          ██      ██      ██    ██ ██    ██ ██   ██ 
██ ██ ████ ██ ██████  ██    ██ ███████ ███████ ██ ██████  ██      █████       ██      ██      ██    ██ ██    ██ ██   ██ 
██ ██  ██  ██ ██      ██    ██      ██      ██ ██ ██   ██ ██      ██          ██      ██      ██    ██ ██    ██ ██   ██ 
██ ██      ██ ██       ██████  ███████ ███████ ██ ██████  ███████ ███████      ██████ ███████  ██████   ██████  ██████  
                                                                                                                        
                                                                                                                        
                        ███    ██ ███████ ████████ ██     ██  ██████  ██████  ██   ██                                   
                        ████   ██ ██         ██    ██     ██ ██    ██ ██   ██ ██  ██                                    
                        ██ ██  ██ █████      ██    ██  █  ██ ██    ██ ██████  █████                                     
                        ██  ██ ██ ██         ██    ██ ███ ██ ██    ██ ██   ██ ██  ██                                    
                        ██   ████ ███████    ██     ███ ███   ██████  ██   ██ ██   ██  
                                    
________________________________________________________________________________________________________________________________________


███████  ██████  ██████      ██   ██ ███████ ███████ ██████      ██ ████████     ████████ ██████   █████  ██████  ██ ███    ██  ██████  
██      ██    ██ ██   ██     ██  ██  ██      ██      ██   ██     ██    ██           ██    ██   ██ ██   ██ ██   ██ ██ ████   ██ ██       
█████   ██    ██ ██████      █████   █████   █████   ██████      ██    ██           ██    ██████  ███████ ██   ██ ██ ██ ██  ██ ██   ███ 
██      ██    ██ ██   ██     ██  ██  ██      ██      ██          ██    ██           ██    ██   ██ ██   ██ ██   ██ ██ ██  ██ ██ ██    ██ 
██       ██████  ██   ██     ██   ██ ███████ ███████ ██          ██    ██           ██    ██   ██ ██   ██ ██████  ██ ██   ████  ██████  
                                                                                                                                         
                                                                                                                                         
 ██  ██████  ██       █████  ███    ██ ██████   █████  ███    ██ ████████ ███████                                                         
██  ██        ██     ██   ██ ████   ██ ██   ██ ██   ██ ████   ██    ██    ██                                                             
██  ██        ██     ███████ ██ ██  ██ ██   ██ ███████ ██ ██  ██    ██    █████                                                          
██  ██        ██     ██   ██ ██  ██ ██ ██   ██ ██   ██ ██  ██ ██    ██    ██                                                             
 ██  ██████  ██      ██   ██ ██   ████ ██████  ██   ██ ██   ████    ██    ███████

Donate: 0x0004230c13c3890F34Bb9C9683b91f539E809000
EOF
echo -e "${NC}"

function install_node {
    echo -e "${BLUE}Обновляем сервер...${NC}"
    sudo apt-get update -y && sudo apt upgrade -y && sudo apt-get install make curl -y

    echo -e "${YELLOW}Введите private_key вашего EVM (без 0x):${NC}"
    read private_key_ICN

    echo -e "${BLUE}Скачиваем и запускаем установочный скрипт ICN...${NC}"
    nohup bash -c "curl -o- https://console.icn.global/downloads/install/start.sh | bash -s -- -p ${private_key_ICN}" > icn_install.log 2>&1 &

    echo -e "${GREEN}Установка ноды ICN запущена в фоновом режиме. Логи установки находятся в файле icn_install.log.${NC}"
}

function view_logs {
    echo -e "${YELLOW}Просмотр логов установки (выход из логов CTRL+C)...${NC}"
    tail -f icn_install.log
}

function remove_node {
    echo -e "${BLUE}Удаляем ноду ICN...${NC}"
    pkill -f "curl -o- https://console.icn.global/downloads/install/start.sh"
    echo -e "${GREEN}Процесс удаления ноды ICN завершен.${NC}"
}

function main_menu {
    while true; do
        echo -e "${YELLOW}Выберите действие:${NC}"
        echo -e "${CYAN}1. Установка ноды${NC}"
        echo -e "${CYAN}2. Просмотр логов${NC}"
        echo -e "${CYAN}3. Удаление ноды${NC}"
        echo -e "${CYAN}4. Выход${NC}"
       
        echo -e "${YELLOW}Введите номер действия:${NC} "
        read choice
        case $choice in
            1) install_node ;;
            2) view_logs ;;
            3) remove_node ;;
            4) break ;;
            *) echo -e "${RED}Неверный выбор, попробуйте снова.${NC}" ;;
        esac
    done
}

main_menu
