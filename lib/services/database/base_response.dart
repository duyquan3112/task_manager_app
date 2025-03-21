class BaseResponse<T> {
  final bool status;
  final T? result;

  BaseResponse({
    this.status = false,
    this.result,
  });
}
