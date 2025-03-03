
# Подготовка образов Windows для KVM (zvirt, proxmox)

Используем инструменты
https://github.com/cloudbase/windows-imaging-tools
windows-imaging-tools в свою очередь использует ещё два репозитория:
https://github.com/cloudbase/windows-curtin-hooks # нужно для MAAS, кажется.
https://github.com/cloudbase/WindowsUpdateCLI # Ставит обновления

Что windows-imaging-tools делает?
Создаёт vhdx диск, разворачивает туда installl.wim, 
копирует скрипты и утилиты для подготовки образа, 
создаёт ВМ с этим диском, 
запускает ВМ с автозапуском скрипта C:\UnattendResources\Logon.ps1, который запустит все остальные скрипты, 
после того как сприпты выполнятся, 
ОС запечатывается с выключением. 
ВМ удаляется, диск конвертируется в указанный формат.

## Перед тем как использовать, надо получить репозитории submodule

```shell
git clone https://gitlab.croc.ru/croc_dit/GR_sys_ing/personal-groups/aratner/windows-cloudimage.git
cd windows-cloudimage
git submodule update --init --recursive

cd w2022
# перед запуском отредактировать файл или сделать свой
.\tmp-w2022-22h1.ps1

```

## Создание образа

Надо запустить скрипт вида: tmp-OSNMAE-OSVERSION.ps1. Эти скрипты готовят config.ini для windows-imagin-tool

### Параметры в этих скриптах

```powershell
# путь до папке где лежат модули windows-imaging-tools
$scriptPath = (Get-Item $PSScriptRoot).parent.FullName + '\windows-imaging-tools'
# имя операционной системы
$osname = 'w11pro'
# версия операционной системы
$osver = '24h2'
# имя финального файла образа
$image_path = "C:\vm\tmp-$($osname)-$($osver).qcow2"
# имя свича hyper-v в котором есть dhcp и доступ в интернет (для установки обновлений)
$switchName = 'VM'
# путь до файла install.wim этой ОС
$wim_file_path = "D:\Users\Public\iso\Microsoft\w11-24h2-202411-install.wim"
# Номер образа для установки, список образов можно посмотреть командой
# Get-WindowsImage -imagepath $wim_file_path
$wim_ImageIndex = 5
# Путь до ISO файла с драйверами и qemu агентом
$virtIOISOPath = "D:\Users\Public\iso\virtio-win-0.1.266.iso"
# Можно настроить так что ISO каждый раз будет скачиваться
$virtIODownloadLink = "https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.266-1/virtio-win-0.1.266.iso"
# В образ будут добавлены драйвера из указанной папки (например рейд контроллер для железного сервера)
$extraDriversPath = "D:\git\drivers\$osname"
# Папка содержимое которой будет скопировано в образ и удалено перед sysprep
$UnattendResourcesPath = ($PSScriptRoot + '\UnattendResources')
# Папка содержимое которой будет скопировано в образ и удалено перед sysprep
$custom_resources_path = ($UnattendResourcesPath + '\CustomResources')
# Папка в которой будут искать кастомные скрипты RunBeforeWindowsUpdates.ps1, RunAfterWindowsUpdates.ps1, RunBeforeCloudbaseInitInstall.ps1, RunAfterCloudbaseInitInstall.ps1, RunBeforeSysprep.ps1, RunAfterSysprep.ps1.
$custom_scripts_path = ($UnattendResourcesPath + '\CustomScripts')
# В этой папке должны лежать конфиги для cloudbase-init
$cloudbase_init_path = (Get-Item $PSScriptRoot).parent.FullName + '\cloudbase'
# Путь до MSI пакета cloudbase-init
$cloudbase_init_msi_path = "D:\pub\Install\freesoft\cloudbase\CloudbaseInitSetup_1_1_6_x64.msi"
```
