class Failure {
  Failure(this.code, this.message);

  int code; // 200, 201, 400, 303..500 and so on
  String message; // error , success
}
