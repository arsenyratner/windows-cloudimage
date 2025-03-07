#Удаляем приложения которые мешают запечатать ОС
# Get-AppxPackage -all AD2F1837.HPPrinterControl | Remove-AppxPackage -AllUsers
& powercfg.exe /x -hibernate-timeout-ac 0
& powercfg.exe /x -hibernate-timeout-dc 0
& powercfg.exe /x -disk-timeout-ac 0
& powercfg.exe /x -disk-timeout-dc 0
& powercfg.exe /x -monitor-timeout-ac 0
& powercfg.exe /x -monitor-timeout-dc 0
& Powercfg.exe /x -standby-timeout-ac 0
& powercfg.exe /x -standby-timeout-dc 0
& powercfg.exe /hibernate off
