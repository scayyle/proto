#!/usr/bin/env sh
version=$(git describe --tags --long | sed 's/\([^-]*-g\)/r\1/;s/-/./g')
tag=$(git describe --tags --abbrev=0)

major=$(echo "${tag}" | head -c2)

if [ $major = "v2" ]; then
  # Update this check always to the next major version.
  echo You have to alter the pipeline and proto-go repo to confirm with Go version. e.g. V2 subpackage
  exit 1
fi

PATH=$GOPATH/bin:$PATH

git config --global user.email "dev@suncraft-server.de"
git config --global user.name "devscayle"

git clone "$1" proto-go

go get google.golang.org/protobuf/cmd/protoc-gen-go google.golang.org/grpc/cmd/protoc-gen-go-grpc

go generate ./go
cp -R go/* proto-go/
rm proto-go/generate.go
cd proto-go
git add *
git commit -m "$version"
git push
git tag "$tag"
git push --tags