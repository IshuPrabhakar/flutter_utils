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
    this.canExpand = false,
    this.splashColor,
    this.borderColor,
    this.isDisabled = false,
  });

  final BorderRadiusType? borderRadiusType;
  final bool? isDisabled;
  final Color? color;
  final Color? borderColor;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Widget? child;
  final bool? canExpand;
  final Color? splashColor;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
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
    _controller.dispose();
    super.dispose();
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
      onTap: widget.isDisabled ?? false
          ? null
          : () {
              Future.delayed(
                const Duration(milliseconds: 100),
                () {
                  widget.onTap?.call();
                  _tapUpCancel();
                },
              );
              _tapDown();
            },
      onTapDown: (_) => widget.isDisabled ?? false ? null : _tapDown(),
      onTapCancel: widget.isDisabled ?? false ? null : _tapUpCancel,
      child: Transform.scale(
        scale: _scale,
        child: AnimatedContainer(
          height: widget.canExpand == true ? null : widget.height ?? 50,
          width: widget.canExpand == true ? null : widget.width ?? 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.borderRadiusType!.value),
            ),
            color: widget.color ?? Colors.white,
            border: Border.all(color: widget.borderColor ?? Colors.transparent),
          ),
          duration: const Duration(milliseconds: 300),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
