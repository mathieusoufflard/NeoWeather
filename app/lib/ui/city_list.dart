import 'package:app/ui/widget/add_city.dart';
import 'package:flutter/material.dart';

class CityList extends StatefulWidget{
  const CityList({super.key});

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList>{
  @override
  Widget build(BuildContext context) {

  return Stack(
    children: [
      title(),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          list(),
          addBtn(),
        ],
      ),
    ],
  );


  }

  title() => const Align(
    alignment: Alignment.topCenter,child: Text(
    'NeoWeather',
    style: TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
  ),
  );

  list() => Center(
    child: Container(
      constraints: const BoxConstraints(maxHeight: 450.0),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 5, right: 5),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              print('tap');
            },
            child:Container(
              height: 90,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/weather_icon/broken_clouds.png', scale: 1.5, color: Colors.black,),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Paris',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Nuageux',
                          ),
                        ],
                      ),
                      const Text('8' '°',
                        style:  TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                ),
              ),
            ),
          );
        },
      ),
    ),
  );

  addBtn() => Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 40,
        right: 40,
      ),
      child: FloatingActionButton(
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddCity()));
        },
        backgroundColor: Colors.white,
        child: const Text(
          '+',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      )
    ),
  );
}