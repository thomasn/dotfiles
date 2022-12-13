# Write-Host "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Write-Host "--- $PSCommandPath ---"
# nv is a PowerShell builtin
Remove-Alias -Force -Name nv
Set-Alias -Name nv -Value nvim
Set-Alias -Name e -Value nvim
Set-Alias -Name xe -Value nvim
Write-Host "Optionally: crash PowerShell with ~\dotfiles\esc-caps-swap.ps1"
