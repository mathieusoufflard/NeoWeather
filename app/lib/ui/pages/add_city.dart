import 'package:app/model/city.dart';
import 'package:app/ui/widget_utils/gradient_scaffold.dart';
import 'package:app/ui/widget_utils/app_widgets.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/api_call.dart';

/// A screen that allows users to search for and add a city.
///
/// - [_savedCities] : city that already on cityList page
/// Users can enter a city name in the search bar, retrieve matching results from the API,
/// and select a city to add to their list.
class AddCity extends StatefulWidget {
  final List<City> _savedCities;

  const AddCity(this._savedCities, {super.key});

  @override
  State<AddCity> createState() => _AddCity();
}

class _AddCity extends State<AddCity> {
  /// Controller for the search text field.
  final _textEditController = TextEditingController();

  /// Whether to display search results.
  bool _showResult = false;

  /// List of cities retrieved from the API.
  List<City> _searchCities = [];

  @override
  void initState() {
    super.initState();
    _textEditController.addListener(_onSearchChanged);
  }

  /// Callback that triggers when the search text changes.
  ///
  /// If the input is not empty, it fetches matching cities from the API.
  /// Otherwise, it clears the results.
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

  /// Fetches cities from the API based on the user's input.
  ///
  /// Updates `_searchCities` with the retrieved results and toggles without duplicate city `_showResult` accordingly.
  Future<void> _fetchCities() async {
    try {
      final List<City> cities = await ApiCall.getCityCoordinates(_textEditController.text);

      List<City> newCities = Utils.removeDuplicateCity(cities);
      List<City> result = Utils.removeAlreadyNowCites(newCities, widget._savedCities);
      setState(() {
        _searchCities = result;
        _showResult = _searchCities.isNotEmpty;
      });
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  void dispose() {
    _textEditController.removeListener(_onSearchChanged);
    _textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Stack(
        children: [
          Row(
            children: [
              _backButton(),
              _searchBar(),
            ],
          ),
          _citiesResult(),
        ],
      ),
    );
  }

  /// Returns a back button that navigates to the previous screen.
  Widget _backButton() => Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset(
          'assets/navigation/back_arrow.png',
          color: Colors.black,
          scale: 1.75,
        ),
      ),
    ),
  );

  /// Returns a search bar for entering a city name.
  Widget _searchBar() => Expanded(
    child: Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: SearchBar(
          leading: const Icon(Icons.search),
          controller: _textEditController,
        ),
      ),
    ),
  );

  /// Returns a list of search results or an empty container if no results are available.
  Widget _citiesResult() {
    if (!_showResult || _searchCities.isEmpty) {
      return Container();
    } else {
      return Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 450.0),
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: AppWidgets.customText(text: '${city.name}, ',color: Colors.black, textOverflow: TextOverflow.ellipsis),
                      ),
                      Flexible(
                        flex: 8,
                        child: AppWidgets.customText(text : city.state != null
                            ?'${city.state}, '
                            :'',
                            color: Colors.black, textOverflow: TextOverflow.ellipsis),
                      ),
                      Flexible(
                        flex: 1,
                        child: AppWidgets.customText(text: city.country, color: Colors.black, textOverflow: TextOverflow.ellipsis),
                      ),

                      const Spacer(),

                      /// Button to add the selected city.
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, City(
                              name: city.name,
                              lat: city.lat,
                              lon: city.lon,
                              country: city.country,
                              state: city.state,
                              weatherData: null,
                            ),
                          );
                        },
                        child: AppWidgets.customText(text: 'Ajouter', color: CupertinoColors.activeBlue, textOverflow: TextOverflow.ellipsis),
                      ),
                    ],
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
