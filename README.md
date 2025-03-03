# Подготовка образов Windows для KVM (zvirt, proxmox)
Используем инструменты
https://github.com/cloudbase/windows-imaging-tools
windows-imaging-tools в свою очередь использует ещё два репозитория:
https://github.com/cloudbase/windows-curtin-hooks # нужно для MAAS, кажется.
https://github.com/cloudbase/WindowsUpdateCLI # Ставит обновления

Что он делает?
Создаёт vhdx диск, разворачивает туда installl.wim, 
копирует скрипты и утилиты подготовки образа, 
создаёт ВМ с этим диском, 
запускает ВМ с автозапуском скрипта C:\UnattendResources\Logon.ps1, который запустит все остальные скрипты, 
после того как сприпты выполнятся, 
ОС запечатывается с выключением. 
ВМ удаляется, диск конвертируется в указанный формат.

## Перед тем как использовать, надо получить репозитории submodule

```shell
git submodule init
git submodule update
```

## Отдельный скрипт подготовки для каждой ОС
в файлах tmp-OSNMAE-OSVERSION.ps1 скрипты которые готовят config.ini для windows-imagin-tool
