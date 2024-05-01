part of handler;

class NetworkHandler {
  /// Check if internet is available or not
  Future<bool> isInternetConnected() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com/'));
      if (result.statusCode == 200) {
        return Future.value(true);
      } else {}
    } catch (_) {
      return Future.value(false);
    }
    return Future.value(false);
  }

  /// Check if server is available or not
  Future<bool> isServerReachable(String url) async {
    try {
      final result = await http.get(Uri.parse(url));
      if (result.statusCode == 200) {
        return Future.value(true);
      }
    } catch (_) {
      return Future.value(false);
    }
    return Future.value(false);
  }

  Stream<ConnectivityResult> get connectivityStream async* {
    final c = Connectivity();
    yield await c.checkConnectivity();
    yield* c.onConnectivityChanged;
  }
}
