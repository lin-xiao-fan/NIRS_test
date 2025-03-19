import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  final List<Color> gradientBackground;
  final Widget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const GradientScaffold({
    super.key,
    required this.gradientBackground,
    this.appBar,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientBackground, // 使用顏色常數
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // 確保背景透明
        appBar: appBar != null ? PreferredSize(preferredSize: const Size.fromHeight(56.0), child: appBar!) : null,
        body: body,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
