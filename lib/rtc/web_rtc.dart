part of rtc;

/// To setup webrtc first setup its requirements
/// from here https://pub.dev/packages/flutter_webrtc
/// 
/// A webrtc class for P2P connection
/// Step 1: Create offer/answer
/// Step 2: Create datachannel/Stream
/// step 3: Accept answer
class WebRTC {
  List<RTCDataChannel> _dataChannels = [];
  get dataChannel => _dataChannels;

  late RTCPeerConnection _peerConnection;
  get peerConnection => _peerConnection;

  late RTCSessionDescription _sdp;
  get sdp => _sdp;

  final Map<String, dynamic> _connectionConfig = {
    'iceServers': [
      {'url': 'stun:stun.l.google.com:19302'},
      {'url': 'stun1.l.google.com:19302'},
      {'url': 'stun2.l.google.com:19302'},
      {'url': 'stun3.l.google.com:19302'},
      {'url': 'stun4.l.google.com:19302'},
    ]
  };

  late Map<String, dynamic> _constraints;

  WebRTC();

  /// Initialises the webrtc
  /// more on https://w3c.github.io/mediacapture-main/getusermedia.html#the-model-sources-sinks-constraints-and-settings
  /// By default it will only initialize with DataChannel only
  init({
    bool offerToReceiveAudio = false,
    bool offerToReceiveVideo = false,
  }) async {
    _constraints = {
      "mandatory": {
        "OfferToReceiveAudio": offerToReceiveAudio,
        "OfferToReceiveVideo": offerToReceiveVideo,
      },
      "optional": [],
    };
  }

  /// Asks user to open camera and mic
  /// as per the provided media constraints
  Future<MediaStream> getUserMedia({
    bool enableAudio = true,
    VideoFacingMode cameraMode = VideoFacingMode.front,
  }) async {
    Map<String, dynamic> mediaConstraints = {
      'audio': enableAudio,
      'video': {
        'facingMode': cameraMode.value,
      }
    };

    return await navigator.mediaDevices.getUserMedia(mediaConstraints);
  }

  /// Offers a webrtc connection
  Future<String?> offerConnection({
    Function(RTCIceCandidate)? onIceCandidate,
    required String channalName,
    Function(MediaStream)? onAddStream,
  }) async {
    // First create peer connection
    _peerConnection = await createPeerConnection(_connectionConfig);
    // this peer connection will generate Ice condidates
    _peerConnection.onIceCandidate = onIceCandidate;

    var offer = await _peerConnection.createOffer(_constraints);
    await _peerConnection.setLocalDescription(offer);

    _peerConnection.onAddStream = onAddStream;

    var sdp = await _peerConnection.getLocalDescription();

    if (sdp != null) {
      return sdp.sdp;
    }
    return null;
  }

  Future<String?> answerConnection(
    RTCSessionDescription offer, {
    Function(RTCIceCandidate)? onIceCandidate,
    required String channalName,
    Function(MediaStream)? onAddStream,
  }) async {
    _peerConnection = await createPeerConnection(_connectionConfig);
    _peerConnection.onIceCandidate = onIceCandidate;

    _peerConnection.onAddStream = onAddStream;

    await _peerConnection.setRemoteDescription(offer);

    final answer = await _peerConnection.createAnswer(_constraints);
    await _peerConnection.setLocalDescription(answer);

    var sdp = await _peerConnection.getLocalDescription();

    if (sdp != null) {
      return sdp.sdp;
    }
    return null;
  }

  /// It will create a new data channel
  createDataChannel({
    required String channalName,
    Function(RTCDataChannelMessage)? onMessage,
    Function(RTCDataChannelState)? onDataChannelState,
  }) async {
    await _peerConnection.createDataChannel(channalName, RTCDataChannelInit());

    // Recieve messages through onMessage Function
    _dataChannels
        .where((channel) => channel.label == channalName)
        .first
        .onMessage = onMessage;
    // Data channel state
    _dataChannels
        .where((channel) => channel.label == channalName)
        .first
        .onDataChannelState = onDataChannelState;
  }

  Future<void> acceptAnswer(RTCSessionDescription answer) async {
    await _peerConnection.setRemoteDescription(answer);
  }

  /// Send a message to this datachannel.
  /// To send a text message, use the default constructor to instantiate a text [RTCDataChannelMessage]
  /// for the [message] parameter. To send a binary message, pass a binary [RTCDataChannelMessage]
  /// constructed with [RTCDataChannelMessage.fromBinary]
  Future<void> sendMessage({
    required String message,
    required String channalName,
  }) async {
    await _dataChannels
        .where((channel) => channel.label == channalName)
        .first
        .send(RTCDataChannelMessage(message));
  }
}

/// Type of facing mode camera a user want or ask
enum VideoFacingMode {
  front("user"),
  rear("environment"),
  left("left"),
  right("right");

  const VideoFacingMode(this.value);
  final String value;
}
