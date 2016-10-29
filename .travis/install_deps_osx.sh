#!/usr/bin/env sh

set -ev

brew update
# brew tap homebrew/science
# brew tap homebrew/x11

for pkg in cmake
do
	echo $pkg
	brew install $pkg ##|| brew upgrade $pkg
done
