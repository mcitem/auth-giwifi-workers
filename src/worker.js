import { RequestData } from 'cloudflare-worker-request-data';
const CryptoJS = require('crypto-js');
const cheerio = require('cheerio');

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);
    const data = await RequestData(request);
    console.log(url.pathname)
    if(url.pathname=='/unicodejson'){
      return new Response(JSON.stringify(JSON.parse(data)))
    }
    if (data==''){return new Response('null')}
    try{
      
      let params = data.split("|");
      if (params.length<3) {return new Response('null params')}
      let username = params[params.length - 2];
      let password = params[params.length - 1];
      if (username=='' || password==''){return new Response('undefined params')}

      const $ = cheerio.load(params[0]);
      let iv = $("#iv").val();
      let sign = decodeURIComponent($("input[name='sign']").val());
      let getStr = $("#frmLogin").serialize();
      let strArr = getStr.split("&");
    
      strArr[3] = strArr[3] + ' '
      strArr[10] = strArr[10] + username
      strArr[11] = strArr[11] + password
      let oriData = strArr.join("&");

      let cryptoData = cryptoEncode(oriData, iv);
      
      let rs = Math.round(Math.random() * 1000) + '|' + encodeURIComponent(iv) + '|' + sign + '|' + encodeURIComponent(cryptoData) + '|' + oriData
      return new Response(rs)

    }catch(e){
      return new Response(e)
    }
  }
};

function cryptoEncode(oriData, iv) {

  var key = CryptoJS.enc.Utf8.parse('1234567887654321');
  var ivv = CryptoJS.enc.Utf8.parse(iv);
  var encrypted = CryptoJS.AES.encrypt(oriData, key, {
      iv: ivv,
      mode: CryptoJS.mode.CBC,
      padding: CryptoJS.pad.ZeroPadding
  });
  let cryptoData = encrypted.toString();
  return cryptoData;
}
