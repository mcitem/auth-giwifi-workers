#!/bin/bash


# config
baseIP='192.168.99.120'
serverurl=''
username=''
password=''

# 临时放行
wget --post-data 'wlanuserip=10.13.96.102&wlanacname=LNSF2&type=2&interval=120' -q -O - http://as.gwifi.com.cn/gportal/web/sendPassby
# serverurl='http://127.0.0.1:8787' #debug

baseURL='http://'$baseIP 
wget --user-agent="Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36 Edg/122.0.0.0" --output-document=login.html --quiet "$baseURL/gportal/web/login"
Gstart='<!--用户登录开始-->'
Gend='<!--用户登录结束-->'
sed -n "/$Gstart/,/$Gend/p" login.html > frmLogin.html
echo "|$username|$password" >> frmLogin.html
sleep 2s
res=$(wget --post-file=frmLogin.html --header="Content-Type: application/text" --output-document=- $serverurl)
IFS='|' read -ra ADDR <<< "$res"
#debug
# echo "round: ${ADDR[0]}"
# echo "iv: ${ADDR[1]}"
# echo "sign: ${ADDR[2]}"
# echo "cryptoData: ${ADDR[3]}"
# echo "oridata: ${ADDR[4]}"
echo ''
dj='data='${ADDR[3]}'&iv='${ADDR[1]}
res=$(wget --header="Content-Type: application/x-www-form-urlencoded;" --header="User-Agent: Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36 Edg/122.0.0.0" --post-data="$dj" --quiet --output-document=- "$baseURL/gportal/web/authLogin?round=${ADDR[0]}")

wget --header="Content-Type: application/text" --post-data="$res" -q -O - "$serverurl/unicodejson"
