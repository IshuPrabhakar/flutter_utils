part of handler;

class FileHandler {
  /// Image picker
  ///
  /// NOTE: You have to handle permission by your own
  ///
  ///
  /// Picks an image from the provided source. Defaults to [ImageSource.gallery]
  /// To select multiple image set `selectMultiple = true`
  /// ### Returns
  /// List<XFile> when multiple image is picked
  // Future<List<XFile>> pickImage({
  //   ImageSource source = ImageSource.gallery,
  //   int imageQualtiy = 100,
  //   CameraDevice preferredCameraDevice = CameraDevice.front,
  //   bool selectMultiple = false,
  // }) async {
  //   // check for permission

  //   final imagepicker = ImagePicker();
  //   if (selectMultiple) {
  //     return await imagepicker.pickMultiImage(imageQuality: imageQualtiy);
  //   }
  //   final file = await imagepicker.pickImage(
  //     source: source,
  //     imageQuality: imageQualtiy,
  //     preferredCameraDevice: preferredCameraDevice,
  //   );
  //   if (file != null) return [file];
  //   return [];
  // }

  /// Picks a video from the provided source
  ///
  ///
  /// NOTE: You have to handle permission by your own
  ///
  ///
  // Future<XFile?> pickVideo({
  //   required Duration maxDuration,
  //   ImageSource source = ImageSource.gallery,
  //   int imageQualtiy = 100,
  //   CameraDevice preferredCameraDevice = CameraDevice.front,
  // }) async {
  //   // check for permission

  //   final imagepicker = ImagePicker();
  //   var video = await imagepicker.pickVideo(
  //     source: source,
  //     preferredCameraDevice: preferredCameraDevice,
  //     maxDuration: maxDuration,
  //   );
  //   return video;
  // }

  /// ImageCropper
  ///
  /// NOTE: You have to handle permission by your own
  ///
  ///
  /// ### Android
  /// Add UCropActivity into your AndroidManifest.xml
  ///
  /// `<activity
  ///     android:name="com.yalantis.ucrop.UCropActivity"
  ///     android:screenOrientation="portrait"
  ///     android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
  /// `
  /// ### Note:
  /// From v1.2.0, you need to migrate your android project to v2 embedding (detail)

  /// ### iOS
  /// No configuration required
  // Future<File?> cropImage({
  //   XFile? imageFile,
  //   String? sourcePath,
  //   CropAspectRatio? cropAspectRatio,
  //   int compressQuality = 100,
  //   CropStyle cropStyle = CropStyle.circle,
  //   int? maxWidth,
  //   int? maxHeight,
  //   List<PlatformUiSettings>? uiSettings,
  // }) async {
  //   final imageCropper = ImageCropper();
  //   assert(imageFile == null && sourcePath == null);

  //   CroppedFile? croppedImage = await imageCropper.cropImage(
  //     sourcePath: imageFile != null ? imageFile.path : sourcePath!,
  //     compressQuality: compressQuality,
  //     cropStyle: cropStyle,
  //     aspectRatio: cropAspectRatio,
  //     maxHeight: maxHeight,
  //     maxWidth: maxWidth,
  //     uiSettings: uiSettings,
  //   );
  //   if (croppedImage == null) return null;
  //   return File(croppedImage.path);
  // }

  /// `
  ///  body: Center(
  ///       child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
  ///           ? FutureBuilder<void>(
  ///               future: retrieveLostData(),
  ///               builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
  ///                 switch (snapshot.connectionState) {
  ///                   case ConnectionState.none:
  ///                   case ConnectionState.waiting:
  ///                     return const Text(
  ///                       'You have not yet picked an image.',
  ///                       textAlign: TextAlign.center,
  ///                     );
  ///                   case ConnectionState.done:
  ///                     return _handlePreview();
  ///                   case ConnectionState.active:
  ///                     if (snapshot.hasError) {
  ///                       return Text(
  ///                         'Pick image/video error: ${snapshot.error}}',
  ///                         textAlign: TextAlign.center,
  ///                       );
  ///                     } else {
  ///                       return const Text(
  ///                         'You have not yet picked an image.',
  ///                         textAlign: TextAlign.center,
  ///                       );
  ///                     }
  ///                 }
  ///               },
  ///             )
  ///           : _handlePreview(),
  ///     ),
  /// `
  // Future<List<XFile>?> retrieveLostData() async {
  //   // check for permission
  //   final imagepicker = ImagePicker();

  //   final LostDataResponse response = await imagepicker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return null;
  //   }
  //   if (response.files != null) {
  //     return response.files;
  //   } else {
  //     return null;
  //   }
  // }

  /// Media file handler
  /// `
  /// type: FileType.custom,
  /// allowedExtensions: ['jpg', 'pdf', 'doc'],
  /// `
  // Future<List<File>?> pickMediaFiles({
  //   String? dialogTitle,
  //   String? initialDirectory,
  //   FileType type = FileType.any,
  //   List<String>? allowedExtensions,
  //   dynamic Function(FilePickerStatus)? onFileLoading,
  //   bool allowMultiple = false,
  //   bool withData = false,
  // }) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     dialogTitle: dialogTitle,
  //     initialDirectory: initialDirectory,
  //     type: type,
  //     onFileLoading: onFileLoading,
  //     allowMultiple: allowMultiple,
  //     allowedExtensions: allowedExtensions,
  //   );

  //   if (result != null) {
  //     return result.paths.map((e) => File(e!)).toList();
  //   } else {
  //     // User canceled the picker
  //     return null;
  //   }
  // }

  // Future<String?> pickDirectory() async =>
  //     await FilePicker.platform.getDirectoryPath();

  // Future<String?> saveFile({
  //   String? dialogTitle = 'Please select an output file:',
  //   String fileName = 'output-file.pdf',
  //   String? initialDirectory,
  //   FileType type = FileType.any,
  //   List<String>? allowedExtensions,
  // }) async =>
  //     await FilePicker.platform.saveFile(
  //       dialogTitle: dialogTitle,
  //       fileName: fileName,
  //       initialDirectory: initialDirectory,
  //       type: type,
  //       allowedExtensions: allowedExtensions,
  //     );
}
