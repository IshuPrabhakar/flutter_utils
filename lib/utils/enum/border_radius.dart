part of utils;

enum BorderRadiusType {
  rect(0),
  rect_10(10),
  rect_15(15),
  rect_20(20),
  rect_25(25),
  rect_30(30),
  circle(100);

  const BorderRadiusType(this.value);
  final double value;
}
