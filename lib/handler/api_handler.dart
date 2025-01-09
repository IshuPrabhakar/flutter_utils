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

  void addCustomHeaders(Map<String, String> headers) {
    _headers.addAll(headers);
  }

  Future<Response<T>> get<T>({
    required String url,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
  }) async {
    try {
      var response = await http.get(Uri.parse(url), headers: _headers);
      _updateCookie(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Response.success(onSuccess!(response));
      } else {
        var error = onError == null ? null : onError(response);
        return error != null
            ? Response.failure(error)
            : failureFromResponse<T>(response);
      }
    } catch (e) {
      return Response.failure(NetworkConnectionError());
    }
  }

  Future<Response<T>> post<T, M>({
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
        return Response.success(onSuccess!(response));
      } else {
        var error = onError == null ? null : onError(response);
        return error != null
            ? Response.failure(error)
            : failureFromResponse<T>(response);
      }
    } catch (e) {
      return Response.failure(NetworkConnectionError());
    }
  }

  Future<Response<T>> put<T, M>({
    required String url,
    M? model,
    String? stringifiedJson,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
    String? sessionToken,
  }) async {
    try {
      var response = await http.put(
        Uri.parse(url),
        headers: _headers,
        body: model != null ? json.encode(model) : stringifiedJson,
      );
      _updateCookie(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Response.success(onSuccess!(response));
      } else {
        var error = onError == null ? null : onError(response);
        return error != null
            ? Response.failure(error)
            : failureFromResponse<T>(response);
      }
    } catch (e) {
      return Response.failure(NetworkConnectionError());
    }
  }

  Future<Response<T>> delete<T>({
    required String url,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
  }) async {
    try {
      var response = await http.delete(Uri.parse(url), headers: _headers);
      _updateCookie(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Response.success(onSuccess!(response));
      } else {
        return Response.failure(NetworkConnectionError());
      }
    } catch (e) {
      return Response.failure(NetworkConnectionError());
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

  Response<T> failureFromResponse<T>(http.Response response) {
    if (response.statusCode == 400) {
      return Response.failure(Error.fromMap(jsonDecode(response.body)));
    } else if (response.statusCode == 401) {
      return Response.failure(UnauthorizedError());
    } else if (response.statusCode == 403) {
      return Response.failure(ForbidError());
    } else if (response.statusCode == 404) {
      return Response.failure(NotFoundError());
    } else {
      return Response.failure(InternalServerError());
    }
  }
}
