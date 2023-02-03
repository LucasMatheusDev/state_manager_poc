class Response<S,F extends Exception> {
  final bool success;
  final S? data;
  final F? error;

  Response({
    required this.success,
    this.data,
    this.error,
  });
}
