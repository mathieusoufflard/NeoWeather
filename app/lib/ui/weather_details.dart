import 'package:app/ui/widget/gradient_scaffold.dart';
import 'package:app/ui/widget_utils/app_widgets.dart';
import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                backButton(context),
                Expanded(
                  child: Center(
                    child: AppWidgets.customText(text: 'Paris', color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold, maxLines: 1, textOverflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mainData(),
                  weatherAlertCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget backButton(BuildContext context) => GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: Image.asset(
      'assets/navigation/back_arrow.png',
      color: Colors.black,
      scale: 1.75,
    ),
  );

  Widget mainData() => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 10),
            child: Image.asset(
              'assets/weather_icon/clear_sky.png',
              scale: 1.5,
            ),
          ),
          AppWidgets.customText(text: '8°', color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ],
      ),
      AppWidgets.customText(text: 'Nuageux', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      AppWidgets.customText(text: 'Resentie 6°', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 10),
            child: AppWidgets.customText(text: 'min: 1', color: Colors.white, fontSize: 16),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: AppWidgets.customText(text: 'max: 10', color: Colors.white, fontSize: 16),
          ),
        ],
      )
    ],
  );

  weatherAlertCard() => AppWidgets.customCard(
      color: const Color.fromRGBO(216, 0, 4, 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppWidgets.customText(text: 'Alerte', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 18,),
          AppWidgets.customText(text: 'Meteo_France', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          SizedBox(height: 18,),
          AppWidgets.customText(text: 'Avis aux petites embarcations', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          SizedBox(height: 18,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppWidgets.customText(text: 'Debut 10:00', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              AppWidgets.customText(text: 'Fin 15:00', color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ],
          ),
          SizedBox(height: 18,),
          Container(
            height: 14 * 10 + 20,
            child: SingleChildScrollView(
              child: AppWidgets.customText(text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,'
              'molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum'
                  'numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium'
                  'optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis'
                  'obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam'
                  'nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit,'
                  'tenetur error, harum nesciunt ipsum debitis quas aliquid. Reprehenderit,'
                  'quia. Quo neque error repudiandae fuga? Ipsa laudantium molestias eos'
                  'sapiente officiis modi at sunt excepturi expedita sint? Sed quibusdam'
                  'recusandae alias error harum maxime adipisci amet laborum. Perspiciatis'
                  'minima nesciunt dolorem! Officiis iure rerum voluptates a cumque velit'
                  'quibusdam sed amet tempora. Sit laborum ab, eius fugit doloribus tenetur'
                  'fugiat, temporibus enim commodi iusto libero magni deleniti quod quam'
                  'consequuntur! Commodi minima excepturi repudiandae velit hic maxime'
                  'doloremque. Quaerat provident commodi consectetur veniam similique ad'
                  'earum omnis ipsum saepe, voluptas, hic voluptates pariatur est explicabo'
                  'fugiat, dolorum eligendi quam cupiditate excepturi mollitia maiores labore'
                  'suscipit quas? Nulla, placeat. Voluptatem quaerat non architecto ab laudantium'
                  'modi minima sunt esse temporibus sint culpa, recusandae aliquam numquam'
                  'totam ratione voluptas quod exercitationem fuga. Possimus quis earum veniam'
                  'quasi aliquam eligendi, placeat qui corporis!', color: Colors.white, fontSize: 14, height: 1.2),
            ),
          ),
        ],
      ),
  );
}