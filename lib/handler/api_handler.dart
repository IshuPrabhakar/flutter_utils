// part of handler;

// class ApiHandler {
//   late Dio _dio;

//   ApiHandler(
//       {String? baseUrl,
//       String? accessToken,
//       String schema = "Bearer",
//       Map<String, dynamic>? headers,
//       Map<String, dynamic>? queryParameters}) {
//     if (baseUrl != null) {
//       var _headers = <String, dynamic>{};
//       _headers[HttpHeaders.authorizationHeader] = "$schema $accessToken";

//       BaseOptions options = BaseOptions(
//         baseUrl: baseUrl,
//         connectTimeout: const Duration(seconds: 5),
//         receiveTimeout: const Duration(seconds: 5),
//         headers: headers,
//         queryParameters: queryParameters,
//         contentType: 'application/json; charset=utf-8',
//         responseType: ResponseType.json,
//       );
//     }
//   }

//   final Map<String, String> _headers = {
//     HttpHeaders.contentTypeHeader: "application/json",
//   };

//   void updateAuthorizationHeader(String accessToken,
//       {String schema = "Bearer"}) {
//     _headers[HttpHeaders.authorizationHeader] = "$schema $accessToken";
//   }

//   Future<Result<T>> get<T>(
//       {required String url,
//       T Function(http.Response response)? onSuccess,
//       Error? Function(http.Response response)? onErrorzzzz}) async {
//     try {
//       var response = await http.get(Uri.parse(url), headers: _headers);
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         return Result.success(onSuccess!(response));
//       } else {
//         var error = onError == null ? null : onError(response);
//         return error != null
//             ? Result.failure(error)
//             : failureFromResponse<T>(response);
//       }
//     } on SocketException {
//       return Result.failure(InternetConnectionError());
//     }
//   }
// }
