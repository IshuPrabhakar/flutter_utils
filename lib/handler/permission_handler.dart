part of handler;

/// Class related to permissions
class PermissionHandler {
  
  Future<PermissionStatus> requestCameraUsage() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
      return await Permission.camera.status;
    }
    return await Permission.camera.status;
  }

  Future<PermissionStatus> requestMicrophoneUsage() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      await Permission.microphone.request();
      return await Permission.microphone.status;
    }
    return await Permission.microphone.status;
  }

  Future<PermissionStatus> requestExternalStorageUsage() async {
    var status = await Permission.manageExternalStorage.status;
    if (status.isDenied) {
      await Permission.manageExternalStorage.request();
      return await Permission.manageExternalStorage.status;
    }
    return await Permission.manageExternalStorage.status;
  }

  Future<PermissionStatus> requestContactUsage() async {
    var status = await Permission.contacts.status;
    if (status.isDenied) {
      await Permission.contacts.request();
      return await Permission.contacts.status;
    }
    return await Permission.contacts.status;
  }
}
