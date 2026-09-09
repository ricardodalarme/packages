// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

export 'package:flutter/widgets.dart';

/// A test replacement for MaterialApp using WidgetsApp without Material dependencies.
class MaterialApp extends StatelessWidget {
  /// Creates a test MaterialApp.
  const MaterialApp({super.key, this.home});

  /// The home widget.
  final Widget? home;

  static const TextStyle _errorTextStyle = TextStyle(
    color: Color(0xD0FF0000),
    fontFamily: 'monospace',
    fontSize: 48.0,
    fontWeight: FontWeight.w900,
    decoration: TextDecoration.underline,
    decorationColor: Color(0xFFFFFF00),
    decorationStyle: TextDecorationStyle.double,
  );

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      color: const Color(0xFF000000),
      textStyle: _errorTextStyle,
      pageRouteBuilder: <T>(RouteSettings s, WidgetBuilder b) => PageRouteBuilder<T>(
        settings: s,
        pageBuilder:
            (BuildContext c, Animation<double> animation, Animation<double> secondaryAnimation) =>
                b(c),
      ),
      home: home,
    );
  }
}

/// A test replacement for Scaffold without Material dependencies.
class Scaffold extends StatelessWidget {
  /// Creates a test Scaffold.
  const Scaffold({super.key, this.body, this.floatingActionButton});

  /// The body widget.
  final Widget? body;

  /// The floating action button widget.
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (body != null) Align(alignment: Alignment.topLeft, child: body),
        if (floatingActionButton != null)
          Align(alignment: Alignment.bottomRight, child: floatingActionButton),
      ],
    );
  }
}

/// A test replacement for FloatingActionButton without Material dependencies.
class FloatingActionButton extends StatelessWidget {
  /// Creates a test FloatingActionButton.
  const FloatingActionButton({super.key, required this.onPressed, this.child});

  /// The callback when pressed.
  final VoidCallback? onPressed;

  /// The child widget.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: child ?? const SizedBox(width: 56, height: 56),
    );
  }
}

/// A test replacement for TextField without Material dependencies.
class TextField extends StatefulWidget {
  /// Creates a test TextField.
  const TextField({super.key});

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  final FocusNode _node = FocusNode();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _node.requestFocus,
      child: Focus(focusNode: _node, child: const SizedBox(width: 100, height: 40)),
    );
  }
}

/// A Color subclass supporting swatch subscripting for tests.
class TestColor extends Color {
  /// Creates a test color.
  const TestColor(super.value);

  /// Subscript operator returning swatch color.
  Color operator [](int index) {
    if (index == 100 && value == 0xFF9C27B0) {
      return const Color(0xFFE1BEE7);
    }
    return this;
  }
}

/// Common colors for testing without Material dependencies.
abstract final class Colors {
  /// Red color.
  static const Color red = Color(0xFFF44336);

  /// Green color.
  static const Color green = Color(0xFF4CAF50);

  /// Blue color.
  static const Color blue = Color(0xFF2196F3);

  /// Yellow color.
  static const Color yellow = Color(0xFFFFEB3B);

  /// Orange color.
  static const Color orange = Color(0xFFFF9800);

  /// Purple color.
  static const TestColor purple = TestColor(0xFF9C27B0);

  /// Grey color.
  static const Color grey = Color(0xFF9E9E9E);
}
