part of essentials;

class Error {
  String? errorCode;
  ErrorType? errorType;
  String? errorSubType;
  String? errorDescription;
  String? errorMessage;
  String? stackTrace;
  Error({
    this.errorCode,
    this.errorType,
    this.errorSubType,
    this.errorDescription,
    this.stackTrace,
    this.errorMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'errorType': errorType?.value,
      'errorSubType': errorSubType,
      'errorDescription': errorDescription,
      'errorMessage': errorMessage,
      'stackTrace': stackTrace,
    };
  }

  factory Error.fromMap(Map<String, dynamic> map) {
    return Error(
      errorCode: map['errorCode'] as String?,
      errorType: ErrorType.values.byName(map['errorType']),
      errorMessage: map['errorMessage'] as String?,
      errorSubType: map['errorSubType'] as String?,
      errorDescription: map['errorDescription'] as String?,
      stackTrace: map['stackTrace'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Error.fromJson(String source) =>
      Error.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Error(errorCode: $errorCode, errorType: $errorType, errorSubType: $errorSubType, errorDescription: $errorDescription, errorMessage: $errorMessage stackTrace: $stackTrace)';
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

class NetworkConnectionError extends Error {
  NetworkConnectionError();
}

class InternalServerError extends Error {
  InternalServerError();
}

class UnauthorizedError extends Error {
  UnauthorizedError();
}

class ForbidError extends Error {
  ForbidError();
}

class NotFoundError extends Error {
  NotFoundError();
}
