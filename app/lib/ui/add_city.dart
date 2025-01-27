import 'package:app/ui/widget/gradient_scaffold.dart';
import 'package:flutter/cupertino.dart';
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
            Row(
              children: [
                backButton(),
                searchBar(),
              ],
            ),
            citiesResult(),
          ],

        ),
    );

  }

  searchBar() => Expanded(
    child: Padding(
      padding: EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: SearchBar(
          leading: const Icon(Icons.search),
        ),
      ),
    ),
  );

  backButton() => Padding(
    padding: EdgeInsets.only(left: 10),
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
  );

  citiesResult() => Center(
    child: Container(
      constraints: const BoxConstraints(maxHeight: 450.0),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 5, right: 5),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 45,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cergy, Ile-de-France, France'
                    ),
                    InkWell(
                        onTap: (){
                          print('ajouter');
                        },
                        child: const Text(
                          'Ajouter',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        )
                    ),
                  ]
              ),
            ),
          );
        },
      ),
    ),
  );
  
}