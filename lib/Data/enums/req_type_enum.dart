// ignore_for_file: constant_identifier_names

/// This enum represent the type of the request
///
/// [ReqTypeEnum]
///
/// * [GET] : to get data
/// * [POST] : to create new data
/// * [PUT] : to update whole data
/// * [PATCH] : to update part of the data
/// * [DELETE] : to delete data
enum ReqTypeEnum {
  /// to get data
  GET,

  /// to create new data
  POST,

  /// to update whole data
  PUT,

  /// to update part of the data
  PATCH,

  /// to delete data
  DELETE,
}
