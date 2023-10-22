part of essentials;

class Error {
  String errorCode;
  ErrorType errorType;
  String? errorSubType;
  String errorDescription;
  String stackTrace;
  Error({
    required this.errorCode,
    required this.errorType,
    this.errorSubType,
    required this.errorDescription,
    required this.stackTrace,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'errorType': errorType.value,
      'errorSubType': errorSubType,
      'errorDescription': errorDescription,
      'stackTrace': stackTrace,
    };
  }

  factory Error.fromMap(Map<String, dynamic> map) {
    return Error(
      errorCode: map['errorCode'] as String,
      errorType: map['errorType'] as ErrorType, // TODO:
      errorSubType:
          map['errorSubType'] != null ? map['errorSubType'] as String : null,
      errorDescription: map['errorDescription'] as String,
      stackTrace: map['stackTrace'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Error.fromJson(String source) =>
      Error.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Error(errorCode: $errorCode, errorType: $errorType, errorSubType: $errorSubType, errorDescription: $errorDescription, stackTrace: $stackTrace)';
  }
}

enum ErrorType {
  networkError("Network Error."),
  unAuthorizedError("UnAuthorized Error."),
  jsonParseError("Json Parse Error."),
  validationError("Validation Error."),
  serverError("Server error.");

  const ErrorType(this.value);
  final String value;
}
