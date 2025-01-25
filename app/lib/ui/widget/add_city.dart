import 'package:app/ui/widget/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class AddCity extends StatefulWidget{
  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCity();
}

class _AddCity extends State<AddCity>{
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text('addCity'),
            )
          ],
        ),
    );

  }
}