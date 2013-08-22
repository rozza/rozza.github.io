#!/bin/sh

echo " ======================= "
echo " Updating master branch"
echo " ======================= "

if git diff-index --quiet HEAD --; then
    rm -rf public
    rm -rf .pubic

    hugo
    mv public .public

    git co master

    rm -rf *
    mv .public/* .
    rm -rf .public

    echo " Please check the updated site and checkin ..."
else
    echo "You have changes not checked-in - cannot automatically update master"
fi
