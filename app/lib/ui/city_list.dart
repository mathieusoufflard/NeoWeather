import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CityList extends StatefulWidget{
  const CityList({super.key});

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList>{
  @override
  Widget build(BuildContext context) {

  return Scaffold(
      body: Container(
        child: const Center(
          child: Text('Home Page'),
        ),
  )
      );

  }
}