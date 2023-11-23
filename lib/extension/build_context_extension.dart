part of extension;

extension ContextHepler on BuildContext {
  // mediaquery height & width
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  // brightness
  bool get isDarkModeEnabled => Brightness.dark == Theme.of(this).brightness;
}
