import 'package:app/ui/widget/gradient_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherDetails extends StatefulWidget{
  const WeatherDetails({super.key});

  @override
  State<WeatherDetails> createState() => _WeatherDetails();
}

class _WeatherDetails extends State<WeatherDetails>{
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Stack(
        children: [

        ],

      ),
    );
  }

}