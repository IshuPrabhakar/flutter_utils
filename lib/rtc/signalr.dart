part of rtc;

class SignalR {
  /// Hub connection object
  late HubConnection _hubConnection;
  bool _isActive = false;
  bool get isActive => _isActive;

  final List<String> _listeners = [];

  void init({
    required String url,
    String? accessToken,
    Map<String, String>? headers,
  }) {
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          url,
          HttpConnectionOptions(
            client: IOClient(
                HttpClient()..badCertificateCallback = (x, y, z) => true),
            logging: (level, message) => debugPrint(message),
            withCredentials: true,
            accessTokenFactory: () => Future.value(accessToken),
            customHeaders: headers,
          ),
        )
        .withAutomaticReconnect()
        .build();
  }

  /// Starts the SignalR Connection
  Future<void> start() async {
    if (!_isActive) {
      await _hubConnection.start();
      _isActive = true;
    }
  }

  /// Stops the SignalR Connection
  Future<void> stop() async {
    if (_isActive) {
      for (var listener in _listeners) {
        off(listener);
      }
      await _hubConnection.stop();
      _isActive = false;
    }
  }

  /// Invokes the `method` of SignalR hub with list of `args`.
  Future<void> invoke({
    required String method,
    required List<Object>? args,
  }) async {
    if (!_isActive) {
      throw Exception("`invoke` can not be used when connection is inactive.");
    }
    await waitForConnectedState();
    await _hubConnection.invoke(method, args: args);
  }

  Future<void> waitForConnectedState() async {
    while (_hubConnection.state != HubConnectionState.connected) {
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }

  /// Registers recieving `method` of the SignalR with `callback`. `callback` would be called whenever SignalR hub server calls the `method.`
  /// `callback` would pass list of arguments that server passed in the `method` arguments.
  void on(
    String method,
    void Function(List<Object?>? args) callback,
  ) {
    _hubConnection.on(method, callback);
    _listeners.add(method);
  }

  /// Deregisters recieving `method` of the SignalR with `callback`. `callback` would be called whenever SignalR hub server calls the `method.`
  /// `callback` would pass list of arguments that server passed in the `method` arguments.
  void off(
    String method,
  ) {
    _hubConnection.off(method);
    _listeners.remove(method);
  }
}
