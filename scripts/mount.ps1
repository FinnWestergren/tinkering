Push-Location $PSScriptRoot\..\frontend
docker run -dp 8000:8000 -w /src -v "$(Get-Location):/src" tinker-town sh -c "elm reactor"
popd