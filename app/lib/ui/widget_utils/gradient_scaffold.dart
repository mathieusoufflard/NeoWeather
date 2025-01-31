import 'package:flutter/material.dart';

/// A custom `StatelessWidget` that wraps a `Scaffold` with a gradient background.
/// The main purpose is to provide a consistent gradient background throughout the app.
class GradientScaffold extends StatelessWidget {

  /// A child widget that will be placed inside the body of the Scaffold.
  final Widget child;

  /// Constructor to pass the child widget and ensure it is required.
  const GradientScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /// Applying the gradient background to the container.
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(136, 193, 150, 1),
            Color.fromRGBO(31, 131, 163, 1),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.transparent,
        body: child,
      ),
    );
  }
}
