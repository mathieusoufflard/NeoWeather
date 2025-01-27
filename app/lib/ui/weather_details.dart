import 'package:app/ui/widget/gradient_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget{
  const WeatherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Stack(
        children: [
          Row(
            children: [
              backButton(context),
              title(),
            ],
          ),
          mainData(),
          weatherDetailsCard(),
        ],
      ),
    );
  }

  backButton(BuildContext context) => Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/navigation/back_arrow.png',
              color: Colors.black,
              scale: 1.75,
            ),
          )
      ),
    ),
  );

  title() => Expanded(
    child: Padding(
      padding: EdgeInsets.only(right: 20, left: 10),
      child: Align(
        alignment: Alignment.topCenter,
        child: const Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Paris',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );

  mainData() => Container();

  weatherDetailsCard() => Container();
}