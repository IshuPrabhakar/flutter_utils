part of handler;

class Result<T> {
  late final bool _isSuccess;
  get isSuccess => _isSuccess;

  final T? _value;
  T? get value => _value;

  Result.failure([T? value])
      : _value = value,
        _isSuccess = false;

  Result.success([T? value])
      : _value = value,
        _isSuccess = true;
}
