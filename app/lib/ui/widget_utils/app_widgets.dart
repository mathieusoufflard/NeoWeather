import 'package:app/model/city.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

/// A utility class containing static methods to create custom widgets
/// like styled text and cards to maintain a consistent design.
class AppWidgets {

  AppWidgets._();

  /// Creates a custom [Text] widget with configurable style properties.
  ///
  /// - [text] : The string content to display.
  /// - [color] : The color of the text.
  /// - [fontSize] : The font size of the text.
  /// - [fontWeight] : The font weight (bold, normal, etc.).
  /// - [height] : The line height of the text.
  /// - [maxLines] : The maximum number of lines for the text.
  /// - [textOverflow] : The overflow behavior when the text exceeds its container.
  static customText({
    required String text,
    required Color color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
    int? maxLines,
    TextOverflow? textOverflow,
  }) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: textOverflow,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }

  /// Creates a custom [Card] with an intrinsic width and padding.
  ///
  /// - [color] : The background color of the card.
  /// - [child] : The content to display inside the card.
  /// - [paddingLeft] : The left padding for the card's content.
  /// - [paddingRight] : The right padding for the card's content.
  static customIntrinsicCard({
    required Color color,
    required Widget child,
    required double paddingLeft,
    required double paddingRight,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight, top: 43),
      child: IntrinsicWidth(
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: color,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  /// Creates a custom [Card] with a fixed width and padding.
  ///
  /// - [color] : The background color of the card.
  /// - [child] : The content to display inside the card.
  /// - [paddingLeft] : The left padding for the card's content.
  /// - [paddingRight] : The right padding for the card's content.
  static customCard({
    required Color color,
    required Widget child,
    required double paddingLeft,
    required double paddingRight,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: paddingLeft, right: paddingRight, top: 43),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: color,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }

  /// Creates a custom [AlertDialog].
  ///
  /// - [context] : context of the page who call the alert dialog.
  static customAlertDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Une erreur est survenue'),
        content: const Text('Vérifiez votre connexion et recommencez'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'true'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Creates a custom [AlertDialog].
  ///
  /// - [context] : context of the page who call the alert dialog.
  static customDeleteAlertDialog(BuildContext context, Box<City> cityBox, int index, VoidCallback onDelete) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('suppression'),
        content: Text('Êtes-vous sûr de vouloir supprimer ${cityBox.getAt(index)?.name} de votre liste ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'true'),
            child: const Text('non'),
          ),
          TextButton(
            onPressed: () {
              customSnackBar(context, 'suppression de ${cityBox.getAt(index)?.name}');
              cityBox.deleteAt(index);
              Navigator.pop(context, 'true');
              onDelete();
              },
            child: const Text('oui'),
          ),
        ],
      ),
    );
  }

  static customSnackBar(BuildContext context, String message){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            ),
          ),
          content: customText(text: message, color: Colors.black, fontSize: 20),
      ),
    );
  }
}
