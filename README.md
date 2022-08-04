# BiliFavoritesDownloader

## 注意

此脚本为自用脚本`deepin/ubuntu`，不保证其他机子能正常运行

## 功能

- [x] telegram 通知，实时下载进度查看
- [x] 最高清晰度下载（需要大会员）
- [x] 邮件通知
- [x] 封面图下载
- [x] xml 转 ass
- [x] 下载完成上传 OneDrive
- [ ] 一键脚本完成初始化设置
- [ ] 初次使用下载收藏夹以前的所有视频

## 更新日志

### 2022/8/02

修改原版的[you-get](https://github.com/soimort/you-get)为[lux](https://github.com/soimort/you-get),因为`you-get`默认下载视频格式为`h265/hevc`格式,导致谷歌浏览器在线播放不了,所以替换为`lux`可默认下`h264`格式.

增加一个`bilidown-lux-run.sh`脚本用来传递参数，每行可以对应不同的用户和收藏夹

### 2021/12/02

[#2](https://github.com/Left024/BiliFavoritesDownloader/issues/2)

### 2021/11/21

修复视频最高清晰度为「1080P 高帧率」或「1080P 60帧」时仍然下载「1080P」的问题

### 2021/11/10

新增 ```Cookies``` 检查，默认情况下当 ```Cookies``` 不可用将不会开始下载

![](https://raw.githubusercontent.com/left916/images/main/2021/10/20211110134148.png)

## 使用

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

```



脚本原理是每分钟检查 RSS，然后通过 [lux](https://github.com/iawia002/lux/) 进行下载（需要额外安装 ffmpeg，否则无法合并下载完的视频且不会自动下载最高画质）

https://docs.rsshub.app/social-media.html#bilibili

建议用别人的rsshub服务或者自己用docker建一个,官方设置的缓存时间太长了,导致B站已经点了收藏rsshun这里却还没刷新.

如何建自己的rsshub服务,官方已经给了教程了:https://docs.rsshub.app/install/#docker-jing-xiang



脚本中注释已经写的很明白了，必须要修改的是```RSS地址```和```邮箱地址```，可选修改地址为```脚本存放地址```和```视频存放地址```

默认```脚本存放地址```为```/root/bilidown/bili-cookies/```
默认```视频存放地址```为```/root/bilidown/bili-down/$4/```

邮件通知使用的是 ```mailutils``` ，不是所有 VPS 都能用，自行测试

telegram bot 的 token 和 chat_id 自行搜索获取方法

最高画质下载需要设置```cookies.txt```，默认存放在```/root/bilidown/bili-cookies/```

Chrome 可以安装 [EditThisCookie](https://chrome.google.com/webstore/detail/editthiscookie/fngmhnnpilhplaeedifhccceomclgfbg) 插件，将```导出格式```设置为```Netscape HTTP Cookies File```然后导出粘贴在```cookies.txt```中即可

xml转ass使用的是[DanmakuFactory](https://github.com/hihkm/DanmakuFactory)，这里提供了已编译好的可执行文件，移动到`/root/bilidown/bili-cookies/`下,

OneDrive 使用的是[rclone](https://github.com/rclone/rclone)，需要自行配置

百度云 使用的是[BaiduPCS-Go](https://github.com/qjfoidnh/BaiduPCS-Go)，需要自行配置

配置完成后设置```crontab```即可使用,默认十分钟循环一次.

```shell
*/10 * * * * /bin/bash /root/bilidown/bilidown-lux-run.sh >/dev/null 2>&1
```

## 效果

点击某一视频的收藏后开始下载

![点击收藏](https://raw.githubusercontent.com/left916/images/main/picgo/picgo20210913230146.png)

telegram 通知（实时下载进度）

![telegram 通知开始下载](https://raw.githubusercontent.com/left916/images/main/picgo/20211004113050.png)

下载完成后通知

![telegram 通知](https://raw.githubusercontent.com/left916/images/main/picgo/20211004113146.png)

下载完成后的文件目录

![文件目录](https://raw.githubusercontent.com/left916/images/main/picgo/picgo20210913230035.png)

## 感谢

[lux](https://github.com/iawia002/lux/)

[you-get](https://github.com/soimort/you-get)

[FFmpeg](https://github.com/FFmpeg/FFmpeg)

[DanmakuFactory](https://github.com/hihkm/DanmakuFactory)

[rclone](https://github.com/rclone/rclone)

[BaiduPCS-Go](https://github.com/qjfoidnh/BaiduPCS-Go)

[RSShub](https://github.com/DIYgod/RSSHub)
