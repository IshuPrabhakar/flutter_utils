part of extension;

extension ContextHepler on BuildContext {
  // mediaquery height & width
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  // brightness
  bool get isDarkModeEnabled => Brightness.dark == Theme.of(this).brightness;

  // Navigation
  Future<T?> navigateTo<T extends Object?>(Route<T> route) =>
      Navigator.of(this).push(route);

  Future<T?> navigateToReplacement<T extends Object?, TO extends Object?>(
          Route<T> newRoute,
          {TO? result}) =>
      Navigator.of(this).pushReplacement(newRoute, result: result);

  void navigateBack<T extends Object?>([T? result]) =>
      Navigator.of(this).pop(result);

  // Text styles
  TextTheme get textStyle => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);
}
