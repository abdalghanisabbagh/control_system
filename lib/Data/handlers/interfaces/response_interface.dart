abstract class ResponseInterface<T> {
  T fromJson(Map<String, dynamic> json);
}

mixin ResponseInterfaceMixin<T> on ResponseInterface<T> {
  Map<String, dynamic> toJson(T model);
}
