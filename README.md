这个工作流可以帮助你自动拉取指定的Docker镜像，并根据情况打包成离线包，特别适合需要离线部署或备份镜像的场景。整个流程简单高效，能够自动处理各种不同需求。

以下是该工作流的运行逻辑:

1.在运行工作流时，你可以输入一个或多个镜像名称，工作流会自动拉取。如果你不提供发布标签，默认会使用当天日期。

2.工作流自动配置支持多架构镜像（比如amd64、arm64等），确保你可以拉取并打包不同平台的镜像。

3.在镜像拉取后，系统会智能判断，如果是单个镜像就直接保存为`.tar`文件。如果是多个镜像就打包成一个`.tar.gz`压缩包，方便传输和管理。

4.工作流会自动检查文件大小，文件较小则直接上传到GitHub Release。如果文件较大，则通过工件上传，确保你能顺利下载。

5.在完成后打包后，系统会清理生成的中间文件，节省空间。

通过这个工作流，Docker镜像打包的整个过程都能自动化处理，支持多架构、多镜像组合，无论你是要备份还是离线部署都非常方便。

### 如何使用
下载后，使用下面的命令导入：
```bash
# 假设镜像名字是 xxx.tar
docker load -i xxx.tar

# youshandefeiyang/allinone
docker run -d --restart unless-stopped --net=host --privileged=true -p 35455:35455 --name allinone youshandefeiyang/allinone
# 播放源地址：http://内网ip:35456/tv.php?h={allinoneIP}&p={allinonePort}&m=1&t=0

# xiaoya
docker create --privileged -p 5678:80 -p 2345:2345 -p 2346:2346 -p 2347:2347 -v /etc/xiaoya:/data -v /etc/xiaoya/data:/www/data --restart=always --name=xiaoya xiaoyaliu/alist:latest
```
