Push-Location $PSScriptRoot
.\build-image.ps1
.\tag-image.ps1
.\push-image.ps1
.\docker-compose.ps1
Pop-Location