import ObsClient from '@ohos/esdk-obs-harmony'
import mime from 'mime';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State ak: string = ''
  @State sk: string = ''
  @State securityToken: string = ""
  @State endpoint: string = 'obs.cn-north-4.myhuaweicloud.com'

  @State bucketName: string = 'obs-harmony'
  @State ObjectKey: string = 'test'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button("测试")
          .width("80%")
          .fontSize(20)
          .onClick(async () => {
            const obsClient: ObsClient = new ObsClient({
              accessKeyId: this.ak,
              secretAccessKey: this.sk,
              securityToken: this.securityToken,
              server: this.endpoint
            })

            const result2 = await obsClient.putObject({
              Bucket: this.bucketName,
              Key: this.ObjectKey,
              Body: "Hello Harmony SDK",
              ContentType: mime.getType(this.ObjectKey)
            })
            if (result2.statusCode > 300) {
              console.log(`put object fail.`)
              console.log(`request: ${result2.RequestId}`)
              return
            }
            console.log(`put object successful.`)
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

