part of handler;

class ApiHandler {
  final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };

  void updateAuthorizationHeader(String accessToken,
      {String schema = "Bearer"}) {
    _headers[HttpHeaders.authorizationHeader] = "$schema $accessToken";
  }

  String? getSessionHeader() {
    return _headers['cookie'];
  }

  void updateSessionHeader(String sessionId) {
    _headers['cookie'] = sessionId;
  }

  void updateAcceptLanguageHeader(Locale locale) {
    _headers[HttpHeaders.acceptLanguageHeader] = locale.toLanguageTag();
  }

  Future<Result<T>> get<T>({
    required String url,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
  }) async {
    try {
      var response = await http.get(Uri.parse(url), headers: _headers);
      _updateCookie(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        var error = onError == null ? null : onError(response);
        return error != null
            ? Result.failure(error)
            : failureFromResponse<T>(response);
      }
    } on SocketException {
      return Result.failure(NetworkConnectionError());
    }
  }

  Future<Result<T>> post<T, M>({
    required String url,
    M? model,
    String? stringifiedJson,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
    String? sessionToken,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: _headers,
        body: model != null ? jsonEncode(model) : stringifiedJson,
      );
      _updateCookie(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        var error = onError == null ? null : onError(response);
        return error != null
            ? Result.failure(error)
            : failureFromResponse<T>(response);
      }
    } on SocketException {
      return Result.failure(NetworkConnectionError());
    }
  }

  Future<Result<T>> put<T, M>({
    required String url,
    M? model,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
    String? sessionToken,
  }) async {
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: _headers,
        body: model != null ? json.encode(model) : null,
      );
      _updateCookie(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        var error = onError == null ? null : onError(response);
        return error != null
            ? Result.failure(error)
            : failureFromResponse<T>(response);
      }
    } on SocketException {
      return Result.failure(NetworkConnectionError());
    }
  }

  Future<Result<T>> delete<T>({
    required String url,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
  }) async {
    try {
      var response = await http.delete(Uri.parse(url), headers: _headers);
      _updateCookie(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        return Result.failure(NetworkConnectionError());
      }
    } on SocketException {
      return Result.failure(NetworkConnectionError());
    }
  }

  void _updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      _headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }

  Result<T> failureFromResponse<T>(http.Response response) {
    if (response.statusCode == 400) {
    } else if (response.statusCode == 401) {
      return Result.failure(UnauthorizedError());
    } else if (response.statusCode == 403) {
      return Result.failure(ForbidError());
    } else if (response.statusCode == 404) {
      return Result.failure(NotFoundError());
    } else {
      return Result.failure(InternalServerError());
    }
    return Result.failure(NotFoundError());
  }
}
