# BiliFavoritesDownloader

## 注意

此脚本为自用脚本`deepin/ubuntu`，不保证其他机子能正常运行

原作者指路:https://github.com/Left024/BiliFavoritesDownloader

我只改了改下载

## 功能

- [x] telegram 通知，实时下载进度查看
- [x] 最高清晰度下载（需要大会员）
- [x] 邮件通知
- [x] 封面图下载
- [x] xml 转 ass
- [x] 下载完成上传 OneDrive

## 更新日志

### 2022/8/02

修改原版的[you-get下载](https://github.com/soimort/you-get)为[lux下载](https://github.com/iawia002/lux/),因为`you-get`默认下载视频格式为`h265/hevc`格式,~~导致谷歌浏览器在线播放不了,~~所以替换为`lux`可默认下`h264`格式.

2024/1/12 谷歌浏览器早就可以解码`hevc`了，不过还是用`lux`吧，毕竟安装简单，`you-get`还得安装`python`



增加一个`bilidown-lux-run.sh`脚本用来传递参数，每行可以对应不同的用户和收藏夹。（看注释就明白了。）

### 2021/12/02

[#2](https://github.com/Left024/BiliFavoritesDownloader/issues/2)

### 2021/11/21

修复视频最高清晰度为「1080P 高帧率」或「1080P 60帧」时仍然下载「1080P」的问题

### 2021/11/10

新增 ```Cookies``` 检查，默认情况下当 ```Cookies``` 不可用将不会开始下载

![](https://raw.githubusercontent.com/left916/images/main/2021/10/20211110134148.png)

## 使用

看博客吧，较详细。

https://hechuan.me/bilidown

```shell
#root用户登陆

#安装ffmpeg
apt install ffmpeg

#安装lux
wget https://github.com/iawia002/lux/releases/download/v0.15.0/lux_0.15.0_Linux_64-bit.tar.gz
tar -zxvf lux*.tar.gz
chmod 0777 lux
cp lux /usr/local/bin/
rm -rf lux*

#命令行输入lux -v
有提示:lux: version xxxx, A fast and simple video downloader.证明安装成功


# 这里有一点注意，如果你的机器不是amd64/x86的话，记得把下载链接改下。
```

运行前记得给文件一下权限,`chmod +x`，放进`root`目录就行



### 原理

是每分钟检查 RSS，然后通过 [lux](https://github.com/iawia002/lux/) 进行下载（需要额外安装 ffmpeg，否则无法合并下载完的视频且不会自动下载最高画质）

https://docs.rsshub.app/social-media.html#bilibili

### 建议

建议用别人的rsshub服务或者自己用docker建一个,官方设置的缓存时间太长了,导致B站已经点了收藏rsshub这里却还没刷新.

如何建自己的rsshub服务,官方已经给了教程了:https://docs.rsshub.app/install/#docker-jing-xiang

或者看博客去：https://hechuan.me/bilidown

### 必要

脚本中注释已经写的很明白了，必须要修改的是bilidown-lux.sh文件中的```RSS地址```

与bilidown-lux-run.sh文件中，你要下载的up主的id和昵称

可选修改：```视频存放地址```
默认的```视频存放地址```为```/root/BiliFavoritesDownloader/bili-down/```目录

邮件通知使用的是 ```mailutils``` ，不是所有 VPS 都能用，自行测试

### 必要2

如果是你的大会员

记得把bilidown-lux.sh文件的61行.`if [[ $quality =~ "1080P" ]]; then`改成`4K`

不是大会员就不用改了

### 电报通知

telegram bot 的 token 和 chat_id 自行搜索获取方法
[点我谷歌一下](https://www.google.com/search?q=%E7%94%B5%E6%8A%A5%E6%9C%BA%E5%99%A8%E4%BA%BA%E6%95%99%E7%A8%8B)

### cookies

高画质下载需要设置```cookies.txt```，默认存放在```/root/BiliFavoritesDownloader/bili-cookies/```

Chrome 可以安装 [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg) 插件，将```导出格式```设置为```Netscape HTTP Cookies File```然后导出粘贴在```cookies.txt```中即可



**2024/1/12**: `cookies`经常失效，这个确实不知道为什么。但是通过浏览器的无痕窗口/隐身模式来获取`cookies`后，貌似时间会长很多。

下图为如何在无痕模式下打开浏览器插件。

![](https://raw.githubusercontent.com/hechuan4/CDN/main/cdn/bilidown6.png)

### 弹幕转化

xml转ass使用的是[DanmakuFactory](https://github.com/hihkm/DanmakuFactory)，这里提供了已编译好的可执行文件，在`/root/BiliFavoritesDownloader/bili-cookies/`目录下,一般不需要动了。无法转换的话可能是权限问题，给下权限：`chmod 0777 DanmakuFactory ` 

### 上传云盘

OneDrive 使用的是[rclone](https://github.com/rclone/rclone)，需要自行配置

137行,自行修改

百度云 使用的是[BaiduPCS-Go](https://github.com/qjfoidnh/BaiduPCS-Go)，需要自行配置

### 设置定时任务

配置完成后设置```crontab```定时任务即可使用,默认十分钟循环一次

```shell
*/10 * * * * /bin/bash /root/BiliFavoritesDownloader/bilidown-lux-run.sh >/dev/null 2>&1
```

不会crontab的可以看：https://www.runoob.com/linux/linux-comm-crontab.html

在线测试工具看看你写的定时任务对不对：https://tool.lu/crontab/

在线生成定时任务的工具：https://www.bejson.com/othertools/cron/

## 效果

点击某一视频的收藏后开始下载

![点击收藏](https://raw.githubusercontent.com/left916/images/main/picgo/picgo20210913230146.png)

下载完成后通知

![](https://raw.githubusercontent.com/hechuan4/CDN/main/cdn/bidown4.png)

下载完成后的文件目录

（默认不会自动删除，想上传完就删除本地的话，

看bilidown-lux.sh文件的63行`#rm -rf "$videoLocation"*`把注释取消就行）

![](https://raw.githubusercontent.com/hechuan4/CDN/main/cdn/bidown1.png)

搭配onedrive云盘和[alist](https://github.com/alist-org/alist)

![](https://raw.githubusercontent.com/hechuan4/CDN/main/cdn/bidown2.png)



下载弹幕与字幕（如果有的话）

![](https://raw.githubusercontent.com/hechuan4/CDN/main/cdn/bilidown3.png)



![](https://raw.githubusercontent.com/hechuan4/CDN/main/cdn/bilidown5.png)

## 感谢

[BiliFavoritesDownloader](https://github.com/Left024/BiliFavoritesDownloader)

[lux](https://github.com/iawia002/lux/)

[you-get](https://github.com/soimort/you-get)

[FFmpeg](https://github.com/FFmpeg/FFmpeg)

[DanmakuFactory](https://github.com/hihkm/DanmakuFactory)

[rclone](https://github.com/rclone/rclone)

[BaiduPCS-Go](https://github.com/qjfoidnh/BaiduPCS-Go)

[RSShub](https://github.com/DIYgod/RSSHub)
