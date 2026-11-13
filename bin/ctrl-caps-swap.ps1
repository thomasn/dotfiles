# echo **** NOT TESTED ****
# echo **** See Microsoft.PowerShell_profile.ps1 for use of uncap.exe
#
# # From https://www.mavjs.org/post/swap-ctrl-and-capslock-on-windows/
# The key is not present on a standard Win 10 install - delete it to reset.
# Needs elevated privs - use `Start-Process pwsh -Verb runAs`
$hexified = "00,00,00,00,00,00,00,00,03,00,00,00,1d,00,3a,00,3a,00,1d,00,00,00,00,00".Split(",") | % { "0x$_"};

$kbLayout = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout';

New-ItemProperty -Path $kbLayout -Name "Scancode Map" -PropertyType Binary -Value ([byte[]]$hexified)

