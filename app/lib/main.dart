import 'package:app/ui/city_list.dart';
import 'package:app/ui/widget/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GradientScaffold(child: CityList()),
      debugShowCheckedModeBanner: false,
    );
  }
}
