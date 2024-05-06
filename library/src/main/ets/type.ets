import { RawAxiosRequestHeaders } from '@ohos/axios'
import { StorageClassType } from './enums'

interface RequestParams {
  RequestDate?: string
}

interface RequestHeaders  {
  Authorization: string,
  ContentType?: string,
  Date?: string,
  HeaderWithPrefix: Map<string, string>
}

enum Method {
  GET= "GET",
  POST= "POST",
  PUT= "PUT",
  DELETE= "DELETE",
  HEAD= "HEAD",
}

export {
  RequestParams,
  RequestHeaders,
  Method
}