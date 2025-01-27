import 'package:app/ui/widget/gradient_scaffold.dart';
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
                    child: title(),
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
                  weatherDetailsCard(),
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

  Widget title() => const Text(
    'Paris',
    style: TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
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
          Text(
              '8°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      Text(
        'Nuageux',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'Resentie 6°',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.only(right: 10),
            child: Text(
              'min: 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'max: 10',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      )
    ],
  );

  Widget weatherDetailsCard() => Padding(
    padding: EdgeInsets.only(left: 20, right: 20, top: 43),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      //color: Colors.red.withOpacity(0.25),
      color: Color.fromRGBO(216, 0, 4, 0.25),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromRGBO(216, 0, 4, 0.25),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: widgetCard(),
        ),
    ),
    ),
  );

  widgetCard() => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Alerte',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      SizedBox(height: 18,),
      Text(
        'Meteo-France',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      SizedBox(height: 18,),
      Text(
        'Avis aux petites embarcations',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      SizedBox(height: 18,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Debut 10:00',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            'Fin 15:00',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      SizedBox(height: 18,),
      Container(
        height: 14 * 10 + 20,
        child: SingleChildScrollView(
          child: Text(
        'Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia,'
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
  'quasi aliquam eligendi, placeat qui corporis!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.2,
            ),
          ),
        ),
      ),
    ],
  );
}