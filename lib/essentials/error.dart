part of essentials;

class Error {
  late String errorCode;
  late ErrorType errorType;
  late String? errorSubType;
  late String errorDescription;
  late String stackTrace;
  Error({
    required this.errorCode,
    required this.errorType,
    this.errorSubType,
    required this.errorDescription,
    required this.stackTrace,
  });

  Error copyWith({
    String? errorCode,
    ErrorType? errorType,
    String? errorSubType,
    String? errorDescription,
    String? stackTrace,
  }) {
    return Error(
      errorCode: errorCode ?? this.errorCode,
      errorType: errorType ?? this.errorType,
      errorSubType: errorSubType ?? this.errorSubType,
      errorDescription: errorDescription ?? this.errorDescription,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorCode': errorCode,
      'errorType': errorType,
      'errorSubType': errorSubType,
      'errorDescription': errorDescription,
      'stackTrace': stackTrace,
    };
  }

  Error.fromMap(Map<String, dynamic> map) {
    errorCode = map['errorCode'];
    errorSubType = map['errorSubType'];
    errorDescription = map['errorDescription'];
    stackTrace = map['stackTrace'];
    errorType = map['errorType'];
  }

  @override
  String toString() {
    return '''
    +-------------------+
     ERROR: $errorType 
    +-------------------+
     errorCode: $errorCode, 
     errorType: $errorType, 
     errorSubType: $errorSubType, 
     errorDescription: $errorDescription, 
     stackTrace: $stackTrace
    ''';
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
