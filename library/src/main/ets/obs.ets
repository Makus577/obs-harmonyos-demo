import { AclType, OBS_SECURITY_TOKEN, StorageClassType, AUTHORIZATION, CONTENT_TYPE, DATE } from './enums';
import { request } from './request'
import { AxiosHeaders } from '@ohos/axios';
import doAuth, { RequestParams } from './auth';
import { Method, RequestHeaders } from './type';

interface ObsClientParams {
  accessKeyId: string,
  secretAccessKey: string,
  securityToken?: string,
  server: string
}

interface PutObjectParams extends RequestParams {
  Bucket: string,
  Key: string,
  Body?: string
  Acl?: AclType,
  StorageClass?: StorageClassType,
  ContentType?: string
}

class ObsClient {
  public ak: string = "";
  public sk: string = "";
  public securityToken: string = ""
  public server: string = "";

  constructor(params: ObsClientParams) {
    this.ak = params.accessKeyId
    this.sk = params.secretAccessKey
    this.securityToken = params.securityToken || ""
    this.server = params.server

    if (!this.server) {
      throw new Error('Server is not set');
    }
    this.server = String(this.server).trim();
  }
  async putObject(params: PutObjectParams) {
    const bucketName = params.Bucket
    const headers = covertPutObjectHeaders(params)
    if (this.securityToken !== "") {
      headers.HeaderWithPrefix.set(OBS_SECURITY_TOKEN, this.securityToken)
    }
    // auth
    headers.Authorization = doAuth(Method.PUT, params.Bucket, params.Key, "", this.ak, this.sk, headers, params)
    return await request({
      method: "PUT",
      url: `${bucketName}.${this.server}/${params.Key}`,
      headers: covertRequestHeaders(headers),
      data: params.Body
    })
  }
}

const covertRequestHeaders = (headers: RequestHeaders) => {
  const axiosHeaders = new AxiosHeaders();

  if (headers.Authorization) {
    axiosHeaders.set(AUTHORIZATION, headers.Authorization)
  }

  if (headers.ContentType) {
    axiosHeaders.set(CONTENT_TYPE,headers.ContentType)
  }
  if (headers.Date) {
    axiosHeaders.set(DATE, headers.Date)
  }
  for (let key of headers.HeaderWithPrefix.keys()) {
    axiosHeaders.set(key.toLowerCase(), headers.HeaderWithPrefix.get(key))
  }
  return axiosHeaders
}

const covertPutObjectHeaders = (params: PutObjectParams) => {
  const headers: RequestHeaders = {
    Authorization: "",
    HeaderWithPrefix: new Map()
  }
  if (params.Acl) {
    headers.HeaderWithPrefix.set("x-obs-acl", params.Acl)
  }
  if (params.StorageClass) {
    headers.HeaderWithPrefix.set("x-obs-storage-class", params.StorageClass)
  }
  if (!params.RequestDate) {
    params.RequestDate = new Date().toUTCString()
  }
  headers.Date = params.RequestDate

  if (params.ContentType) {
    headers.ContentType = params.ContentType
  }
  return headers
}

export default ObsClient;


