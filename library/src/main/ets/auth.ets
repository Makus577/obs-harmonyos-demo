import CryptoJS from '@ohos/crypto-js';
import { Method, RequestHeaders, RequestParams } from './type';


const doAuth = (method: Method, bucketName: string, objectKey: string, query: string, ak: string, sk: string,
                headers: RequestHeaders, params: RequestParams): string => {
  const stringToSign = getStringToSign(method, bucketName, objectKey, headers, params);
  return getSignature(ak, sk, stringToSign)
}

function getStringToSign(method: Method, bucketName: string, objectKey: string, headers: RequestHeaders, params: RequestParams): string {
  // stringToSign是签名的关键，https://support.huaweicloud.com/api-obs/obs_04_0010.html
  // TODO 这里如果有多个头域，需要进行排序后再拼接，参考文档的 CanonicalizedHeaders 介绍
  const contentType = headers.ContentType !== "" ? headers.ContentType : ""
  const headerWithPrefix = headers.HeaderWithPrefix
  const sortedHeaders = Array.from(headerWithPrefix.keys())
  sortedHeaders.sort((key1, key2) => key1.toLowerCase() < key2.toLowerCase() ? -1 : 1)
  const canonicalizedHeaders = sortedHeaders.map((key: string) => `${key}:${headerWithPrefix.get(key)}`).join("\n");
  const canonicalizedResource = `/${bucketName}/${objectKey}`;
  const date = params.RequestDate;
  const contentMD5 = "";
  return [method, contentMD5, contentType, date, canonicalizedHeaders, canonicalizedResource].join("\n")
}

function getHmacSha1(sk: string, stringToSign: string): string {
  let hash: CryptoJS.lib.WordArray = CryptoJS.HmacSHA1(stringToSign, sk)
  return CryptoJS.enc.Base64.stringify(hash)
}

function getSignature(ak: string, sk: string, stringToSign: string): string {
  console.log(stringToSign)
  return `OBS ${ak}:${getHmacSha1(sk, stringToSign)}`
}

export {
  RequestParams
}
export default doAuth