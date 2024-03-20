## 说明
这是一个linux下只需要安装curl/wget就能使用的 寰创Giwifi 自动登录脚本

由于openwrt自带wget,所以可以不需要安装任何依赖就能用wget实现认证

适用于小闪存的路由器比如8mb 的K2 不需要安装20mb起步的python或者nodejs

可用于: 河南理工大学 HPU
       岭南师范学院 LNU

使用前提: 临时放行接口开放可用

校园网可访问workers，否则需要自定义域名访问
## 部署&使用
将worker.js用wrangler 的方式部署到cloudflare worker

安装 Wrangler
```
npm install -g wrangler
```
登录cloudflare
```
wrangler login
```
从此 Worker 初始化新项目
```
wrangler init --from-dash <yourworker-name>
```
```
wrangler init --from-dash giwifi-encrypt
```
依赖
```
npm i cheerio
npm i crypto-js
npm i cloudflare-worker-request-data
```

替换src/worker.js的代码

将您的项目部署到 Cloudflare 的全球网络：
```
wrangler deploy
```

## 使用


edit shell.sh#config 

```
bash shell.sh
```

## 开发
```
wrangler dev
```
```
serverurl='http://127.0.0.1:8787'
```

## 其他实现
nodejs
- [Giraffele/Auto-Giwifi](https://github.com/GiraffeLe/Auto-Giwifi)

python
- [mcitem/auth-giwifi-python](https://github.com/mcitem/auto-giwifi-python)
