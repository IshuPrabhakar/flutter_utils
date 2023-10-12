part of extension;

extension ContextHepler on BuildContext {
  // mediaquery height & width
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // brightness
  bool get isDarkModeEnabled => Brightness.dark == Theme.of(this).brightness;
}
