part of essentials;

class Response<T> {
  final bool _isSuccess;
  final T? _value;
  final Error? _error;

  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;
  T? get value => _value;
  Error? get error => _error;

  Response.success([T? value])
      : _isSuccess = true,
        _value = value,
        _error = null;

  Response.failure(Error error)
      : _isSuccess = false,
        _error = error,
        _value = null;

  R when<R>({
    required R Function(T? value) success,
    required R Function(Error error) failure,
  }) {
    if (_isSuccess) {
      return success(_value);
    } else {
      return failure(_error ?? Error(errorMessage: 'Unknown error'));
    }
  }
}
