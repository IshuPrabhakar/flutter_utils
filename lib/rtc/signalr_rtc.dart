part of rtc;

class SignalR {
  /// Hub connection object
  late HubConnection _hubConnection;

  /// The location of the SignalR Server.
  String? _serverUrl;

  /// Automatic retry after delay.
  static const List<int> _delays = [3000, 7000, 10000, 15000];

  /// Loggertype
  String? _loggerType;

  /// HttpOptions
  HttpConnectionOptions? _httpOptions;

  /// Message headers useful for authentication purpose
  MessageHeaders? _defaultHeaders;

  /// Transport type is to use
  HttpTransportType? _transportType;

  /// Message Protocol:
  /// JsonHubProtocol or MessagePackHubProtocol
  IHubProtocol? _hubProtocol;

  /// If authentication is enabled at server side
  /// If you need to authorize the Hub connection than provide a an async callback function that returns
  /// the token string
  /// ```dart
  /// accessTokenFactory: () async => Future.value('JWT_TOKEN')
  /// ```
  Future<String> Function()? _accessTokenFactory;

  SignalR();

  /// Initializes a SignalR connection with hub url
  init({
    required String url,
    String? loggerType,
    MessageHeaders? msgheaders,
    HttpTransportType? transportType,
    IHubProtocol? hubProtocol,
    Future<String> Function()? accessTokenFactory,
  }) async {

    _serverUrl = url;

    _loggerType = loggerType ?? LoggerType.transportProtLogger;
    _defaultHeaders = msgheaders;
    _transportType = transportType;
    _hubProtocol = hubProtocol ?? JsonHubProtocol();
    _accessTokenFactory = accessTokenFactory;

    _httpOptions = HttpConnectionOptions(
      logger: Logger(_loggerType!),
      headers: _defaultHeaders,
      transport: _transportType,
      httpClient: WebSupportingHttpClient(
        Logger(_loggerType!),
      ),
      accessTokenFactory: _accessTokenFactory,
    );

    _hubConnection = HubConnectionBuilder()
        .withAutomaticReconnect(retryDelays: _delays)
        .withUrl(
          _serverUrl!,
          options: _httpOptions,
        )
        .withHubProtocol(_hubProtocol!)
        .configureLogging(Logger(_loggerType!))
        .build();

    if (_hubConnection.state == HubConnectionState.Disconnected) {
      _hubConnection.start();
    }
  }

  dispose() async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection.stop();
    }
  }

  /// If you have selected jsonhubprotocol viz default then pass json-string or string only
  send({
    required String methodName,
    required List<Object>? args,
  }) async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection.invoke(methodName, args: args);
    }
  }
  
  /// Register your methods at startups
  /// If you have selected jsonhubprotocol viz default then decode it as json-string or string only
  recieve({
    required String methodName,
    required Function(List<Object?>? parameters) onDataRecieve,
  }) async {
    _hubConnection.on(methodName, onDataRecieve);
  }
}

/// Logger type:
/// If you want only to log out the message for the higer level hub protocol:
/// "SignalR - hub"
/// If youn want to also to log out transport messages:
/// "SignalR - transport"
abstract class LoggerType {
  static const String _hubProtLogger = "SignalR - hub";
  static get hubProtLogger => _hubProtLogger;

  static const String _transportProtLogger = "SignalR - transport";
  static get transportProtLogger => _transportProtLogger;
}
