pushd ..
docker run -dp 8000:8000 -w /src -v "$(pwd):/src" tinker-town sh -c "elm reactor"
popd