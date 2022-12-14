import 'package:flutter/material.dart';

import 'style/app_theme.dart';

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wan Android',
      theme: appThemeData(context),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Scaffold(body: Container()),
    );
  }
}

class InheritedProvider<T> extends InheritedWidget {
  final T data;

  InheritedProvider({required this.data, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T data;
  final Widget child;

  ChangeNotifierProvider({
    Key? key,
    required this.data,
    required this.child,
  });

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}
