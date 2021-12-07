#!/bin/sh

echo " ======================= "
echo " Updating master branch"
echo " ======================= "

if git diff-index --quiet HEAD --; then
    rm -rf public
    rm -rf .public

    hugo
    mv public .public

    git co main

    rm -rf *
    mv .public/* .
    rm -rf .public

    echo " ======================== "
    echo "            WIN          "
    echo " ======================== "
    echo " Please check the updated site and checkin ..."
else
    echo " ======================== "
    echo "            FAIL          "
    echo " ======================== "
    echo "You have changes not checked-in - cannot automatically update main"
fi
