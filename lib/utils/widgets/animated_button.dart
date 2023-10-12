part of utils;

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    super.key,
    this.borderRadiusType = BorderRadiusType.rect_10,
    this.color,
    this.height,
    this.width,
    this.onTap,
    this.child,
    this.canExpand = false, this.splashColor,
  });

  final BorderRadiusType? borderRadiusType;
  final Color? color;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Widget? child;
  final bool? canExpand;
  final Color? splashColor;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 150,
      ),
      lowerBound: 0.0,
      upperBound: 0.05,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _tapDown() {
    _controller.forward();
  }

  void _tapUpCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return InkWell(
      borderRadius: BorderRadius.circular(widget.borderRadiusType!.value),
      splashColor: widget.splashColor,
      onTap: () {
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            widget.onTap?.call();
            _tapUpCancel();
          },
        );
        _tapDown();
      },
      onTapDown: (_) => _tapDown(),
      onTapCancel: _tapUpCancel,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: widget.canExpand == true ? null : widget.height ?? 50,
          width: widget.canExpand == true ? null : widget.width ?? 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadiusType!.value),
            ),
            color: widget.color ?? Colors.white,
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}