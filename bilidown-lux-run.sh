#!/bin/bash
/root/BiliFavoritesDownloader/bilidown-lux.sh "fav" "B站id" "收藏夹id" "下载的文件夹"
/root/BiliFavoritesDownloader/bilidown-lux.sh "user/video" "1458409749" "0" "汤圆的汤圆儿"


#例1 如果是收藏夹的话: /root/BiliFavoritesDownloader/bilidown-lux.sh "fav" "你的B站id" "收藏夹id" "你的收藏夹名字"
# 如: /root/BiliFavoritesDownloader/bilidown-lux.sh "fav" "B站id" "收藏夹id" "下载的文件夹"

#例2 如果是某个up主的更新稿件的话: /root/BiliFavoritesDownloader/bilidown-lux.sh "user/video" "up主id" "0" "up主名字",每行可以对应不同的用户和收藏夹
# 如: /root/BiliFavoritesDownloader/bilidown-lux.sh "user/video" "1458409749" "0" "汤圆的汤圆儿"
# 但是现在不行了，因为B站的反爬，但可以通过up主动态来绕过。
#详看：https://docs.rsshub.app/zh/routes/social-media#bilibili-up-zhu-tou-gao
#https://github.com/hechuan4/BiliFavoritesDownloader/issues/5


#rsshub教程详看:https://docs.rsshub.app/social-media.html#bilibili