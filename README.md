# 说明
本项目适用于 河南理工大学HPU和广东某不知名学校 校园网giwifi自动认证登录
本项目利用cloudflare worker进行认证时的远程、html解析、AES加密，并将结果以curl提交到认证服务器实现自动认证

# 使用
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
## 部署
```
npm i cheerio
npm i crypto-js
npm i cloudflare-worker-request-data
```

替换src/worker.js的代码

发布您的 Wrangler 项目
将您的项目部署到 Cloudflare 的全球网络：
```
wrangler deploy
```

## 使用
edit shell.sh#config 
```
bash shell.sh
```

# 开发
```
wrangler dev
```
```
serverurl='http://127.0.0.1:8787'
```
