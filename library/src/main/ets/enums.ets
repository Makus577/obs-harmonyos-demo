enum AclType {
  PRIVATE = 'private',
  PUBLIC_READ = 'public-read',
  PUBLIC_READ_WRITE = 'public-read-write',
  PUBLIC_READ_DELIVERED = 'public-read-delivered',
  PUBLIC_READ_WRITE_DELIVERED = 'public-read-write-delivered',
  AUTHENTICATED_READ = 'authenticated-read',
  BUCKET_OWNER_READ = 'bucket-owner-read',
  BUCKET_OWNER_FULL_CONTROL = 'bucket-owner-full-control',
  LOG_DELIVERY_WRITE = 'log-delivery-write',
}

enum StorageClassType {
  STANDARD = 'STANDARD',
  WARM = 'WARM',
  COLD = 'COLD',
  DEEP_ARCHIVE = 'DEEP_ARCHIVE',
}

enum PermissionType {
  READ = 'READ',
  WRITE = 'WRITE',
  READ_ACP = 'READ_ACP',
  WRITE_ACP = 'WRITE_ACP',
  FULL_CONTROL = 'FULL_CONTROL',
}

enum RestoreType {
  EXPEDITED = 'Expedited',
  STANDARD = 'Standard',
  BULK = 'Bulk',
}

enum Ali {
  CONTENT_MD5 = 'Content-MD5',
  CONTENT_SHA256 = 'Content-SHA256',
}

const OBS_SECURITY_TOKEN = "x-obs-security-token"
const CONTENT_TYPE = "Content-Type"
const DATE = "Date"
const AUTHORIZATION = "Authorization"

export {
  AclType,
  StorageClassType,
  RestoreType,
  PermissionType,
  OBS_SECURITY_TOKEN,
  CONTENT_TYPE,
  AUTHORIZATION,
  DATE
}