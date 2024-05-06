import axios, { AxiosError, AxiosRequestConfig, AxiosResponse, AxiosResponseHeaders,
  RawAxiosResponseHeaders } from '@ohos/axios';

const instance = axios.create();

instance.defaults.headers.put["Content-Type"] = ""

interface ObsError {
  statusCode?: number,
  RequestId?: string,
  ResponseHeaders?: RawAxiosResponseHeaders | AxiosResponseHeaders,
  Status?: string,
  Code?: string,
  Message?: string,
  Resource?: string,
  HostId?: string
}

interface ObsResult {
  statusCode: number,
  RequestId?: string,
  ResponseHeaders?: RawAxiosResponseHeaders | AxiosResponseHeaders,
}

function request(options: AxiosRequestConfig): Promise<ObsResult> {
  return new Promise(async (resolve: (result: ObsResult) => void, reject: (reason: ObsError) => void) => {
    await instance
      .request(options)
      .then((response: AxiosResponse<string, string>) => {
        const obsResult: ObsResult = {
          statusCode: response?.status,
          ResponseHeaders: response?.headers,
          RequestId: response?.headers["x-obs-request-id"]
        }
        resolve(obsResult)
      }).catch((error: AxiosError) => {
        const obsError: ObsError = {
          statusCode: error.response?.status,
          ResponseHeaders: error.response?.headers,
          Message: error.message,
          Code: error.code,
          RequestId: error.response?.headers["x-obs-request-id"]
        }
        reject(obsError)
      })
  })
}

export {
  request,
  ObsError,
  ObsResult
}