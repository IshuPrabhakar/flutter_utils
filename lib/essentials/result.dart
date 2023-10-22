part of essentials;

class Result<T>{
 late bool _isSuccess;
  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;

  Error? _error;
  Error? get error => _error;

  T? _value;
  T? get value =>_value;

  Result.failure([this._error]) {
    _isSuccess = false;
  }

  Result.success([T? value]) {
    _value = value;
    _isSuccess = true;
  }
}