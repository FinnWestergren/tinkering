Push-Location $PSScriptRoot\..\frontend
docker run -dp 8080:8080 tinker-town
Pop-Location