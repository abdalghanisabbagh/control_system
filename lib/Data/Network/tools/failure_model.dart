/// Failure Model to handle errors in API responses
class Failure {
  /// The HTTP status code, e.g. 200, 201, 400, 303, 500, etc.
  final int code;

  /// The error message, e.g. "error", "success", etc.
  final String message;

  /// Constructor to create a Failure object
  ///
  /// [code] is the HTTP status code
  /// [message] is the error message
  const Failure(this.code, this.message);
}

