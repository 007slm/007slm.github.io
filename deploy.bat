#!/bin/bash
copy .\jane_modify\comments.html .\themes\jane\layouts\partials\ /Y
set SITE_SOURCE="g:/hugo/blog"
set PUBLIC_DIR="g:/hugo/blog/public"
cd %SITE_SOURCE%
hugo -t jane
git add .
git commit -m "add blog"
git pull
git push
cd %PUBLIC_DIR%
git add .
git commit -m "update public files"
git push origin master --force