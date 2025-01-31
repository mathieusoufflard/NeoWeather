import 'package:app/model/city.dart';
import 'package:app/ui/widget_utils/gradient_scaffold.dart';
import 'package:app/ui/widget_utils/app_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/api_call.dart';

class AddCity extends StatefulWidget{

  const AddCity({super.key});

  @override
  State<AddCity> createState() => _AddCity();
}

class _AddCity extends State<AddCity>{
  final _textEditController = TextEditingController();
  bool _showResult = false;
  List<City> _searchCities = [];

  @override
  void initState() {
    super.initState();
    _textEditController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_textEditController.text.isNotEmpty) {
      _fetchCities();
    } else {
      setState(() {
        _showResult = false;
        _searchCities.clear();
      });
    }
  }
  Future<void> _fetchCities() async {
    try {
      final List<City> cities = await ApiCall.getCityCoordinates(_textEditController.text);

      setState(() {
        _searchCities = cities;
        _showResult = _searchCities.isNotEmpty;
      });
    } catch (e) {
      print('Erreur : $e');
    }
  }

  @override
  void dispose() {
    _textEditController.dispose();
    _textEditController.removeListener(_onSearchChanged);
    super.dispose();
  }

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


  searchBar() => Expanded(
    child: Padding(
      padding: EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: SearchBar(
          leading: const Icon(Icons.search),
          controller: _textEditController,
        ),
      ),
    ),
  );

  citiesResult() {
    if (!_showResult || _searchCities.isEmpty){
      return Container();
    }else{
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 450.0),
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _searchCities.length,
            itemBuilder: (context, index) {
              final city = _searchCities[index];
              return Container(
                height: 45,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                            child: AppWidgets.customText(text: '${city.name}, ', color: Colors.black, textOverflow: TextOverflow.ellipsis),
                        ),
                        Flexible(
                          flex: 8,
                          child: AppWidgets.customText(text: '${city.state}, ', color: Colors.black, textOverflow: TextOverflow.ellipsis),
                        ),
                        Flexible(
                          flex: 1,
                          child: AppWidgets.customText(text: city.country, color: Colors.black, textOverflow: TextOverflow.ellipsis),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: (){
                              Navigator.pop(context, City(
                                name: city.name,
                                lat: city.lat,
                                lon: city.lon,
                                country: city.country,
                                weatherData: null,
                              ));
                            },
                            child: AppWidgets.customText(text: 'Ajouter', color: CupertinoColors.activeBlue, textOverflow: TextOverflow.ellipsis)
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
  }
  
}