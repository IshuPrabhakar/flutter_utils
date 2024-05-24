part of handler;

class Response<T> {
  late bool _isSuccess;
  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;

  Error? _error;
  Error? get error => _error;

  T? _value;
  T? get value => _value;

  Response.failure(this._error) {
    _isSuccess = false;
  }

  Response.success([T? value]) {
    _value = value;
    _isSuccess = true;
  }
}
