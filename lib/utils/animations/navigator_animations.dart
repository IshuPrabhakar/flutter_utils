part of utils;

class OpenContainerAnimationNavigator extends StatelessWidget {
  const OpenContainerAnimationNavigator({
    super.key,
    required this.navigateTo,
    required this.animationDuration,
    required this.transitionType,
    required this.onTap,
  });

  final Widget navigateTo;
  final Duration animationDuration;
  final ContainerTransitionType transitionType;
  final Widget Function(BuildContext context, void Function() openContainer) onTap;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      middleColor: Colors.transparent,
      openElevation: 0,
      closedElevation: 0,
      transitionDuration: animationDuration,
      transitionType: transitionType,
      openBuilder:
          (BuildContext context, void Function({Object? returnValue}) action) =>
              navigateTo,
      closedBuilder: onTap,
    );
  }
}

class PageTransitionSwitcherNavigatorAnimation extends StatelessWidget {
  const PageTransitionSwitcherNavigatorAnimation({
    super.key,
    required Widget pages,
    required this.isForwardDirection,
    required this.animationDuration,
    required this.transitionType,
  }) : _pages = pages;

  final Widget _pages;
  final bool isForwardDirection;
  final Duration animationDuration;
  final SharedAxisTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: animationDuration,
      reverse: isForwardDirection,
      transitionBuilder: (child, animation, secondaryAnimation) =>
          SharedAxisTransition(
        fillColor: Colors.transparent,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: transitionType,
        child: child,
      ),
      child: _pages,
    );
  }
}
