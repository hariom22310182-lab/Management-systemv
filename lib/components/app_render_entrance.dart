import 'package:flutter/material.dart';

class AppRenderEntrance extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const AppRenderEntrance({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 180),
  });

  @override
  State<AppRenderEntrance> createState() => _AppRenderEntranceState();
}

class _AppRenderEntranceState extends State<AppRenderEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _fade, child: widget.child);
  }
}
