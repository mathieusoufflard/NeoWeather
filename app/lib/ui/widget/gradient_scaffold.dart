import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget{

  final Widget child;

  const GradientScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(136, 193, 150, 1),
            Color.fromRGBO(31, 131, 163, 1)
          ],
        ),
      ),
      child: Scaffold(
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