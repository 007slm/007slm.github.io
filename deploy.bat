#!/bin/bash
copy .\jane_modify\comments.html .\themes\jane\layouts\partials\ /Y
cd /d %~dp0
hugo -t jane
git add .
git commit -m "add blog"
git pull
git push
cd public
git add .
git commit -m "update public files"
git push origin master --force