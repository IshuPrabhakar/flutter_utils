part of handler;

class ApiHandler {
  final Map<String, String> _headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };
  Map<String, String> _cookies = {};

  void updateAuthorizationHeader(String accessToken,
      {String schema = "Bearer"}) {
    _headers[HttpHeaders.authorizationHeader] = "$schema $accessToken";
  }

  String? getSessionHeader() {
    return _headers['cookie'];
  }

  String? getRfTkn() {
    return _cookies['rf'];
  }

  String? getTkn() {
    return _cookies['tkn'];
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
      _cookies = extractCookies(response.headers.toString());

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        return Result.failure();
      }
    } on SocketException {
      return Result.failure();
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
      for (var element in response.headers.entries) {
        debugPrint(element.value);
      }
      _cookies = extractCookies(response.headers.toString());
      debugPrint(_cookies.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        return Result.failure();
      }
    } on SocketException {
      return Result.failure();
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
      _cookies = extractCookies(response.headers.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        return Result.failure();
      }
    } on SocketException {
      return Result.failure();
    }
  }

  Future<Result<T>> delete<T>({
    required String url,
    required T Function(http.Response response)? onSuccess,
    Error? Function(http.Response response)? onError,
  }) async {
    try {
      var response = await http.delete(Uri.parse(url), headers: _headers);
      _cookies = extractCookies(response.headers.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(onSuccess!(response));
      } else {
        return Result.failure();
      }
    } on SocketException {
      return Result.failure();
    }
  }

  // void _updateCookie(http.Response response) {
  //   String? rawCookie = response.headers['set-cookie'];
  //   if (rawCookie != null) {
  //     int index = rawCookie.indexOf(';');
  //     _headers['cookie'] =
  //         (index == -1) ? rawCookie : rawCookie.substring(0, index);
  //   }
  // }

  Map<String, String> extractCookies(String header) {
    Map<String, String> cookies = {};

    // Split the header string by commas
    List<String> headerParts = header.split(',');

    // Iterate over the header parts to find cookies
    for (String part in headerParts) {
      if (part.contains('set-cookie')) {
        // Extract the cookie part
        String cookiePart = part.split(';')[1];

        // Split the cookie part to get individual cookies
        List<String> cookiePairs = cookiePart.split(',');

        // Iterate over the cookie pairs to extract key-value pairs
        for (String pair in cookiePairs) {
          List<String> keyValue = pair.trim().split('=');
          String key = keyValue[0].trim();
          String value = keyValue[1].trim();
          cookies[key] = value;
          debugPrint(value);
        }
      }
    }

    return cookies;
  }
}
