import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:smart_agri/homepage.dart';
import 'package:smart_agri/wether/ui/widgets/main_screen/main_screen_model.dart';
import 'package:smart_agri/wether/utils/constants.dart';


class MainScreenWidget extends StatelessWidget {
  const MainScreenWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch<MainScreenModel>();

    return Scaffold(
      appBar: AppBar(  
            title: const Text('Wether'),
          // centerTitle: true,
          backgroundColor:  const Color.fromARGB(255, 247, 82, 17),
           leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
       Navigator.push(context, MaterialPageRoute(builder: (context) => introduction()));
    }
  ), ),
      
      // backgroundColor: Colors.white,
      body:
          model.forecastObject?.location?.name != null && model.loading == false
              ? _ViewWidget()
              : const Center(
                  child: SpinKitCubeGrid(color: Colors.blue, size: 80),
                ),
    );
  }
}

class _ViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();

    return SafeArea(
      child: Stack(
        children: [
          model.forecastObject!.location!.name != 'Null'
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        SizedBox(height: 70),
                        CityInfoWidget(),
                        SizedBox(height: 15),
                        CarouselWidget(),
                        SizedBox(height: 15),
                        WindWidget(),
                        SizedBox(height: 15),
                        BarometerWidget(),
                      ]),
                )
              : Center(
                  child: appText(size: 16, text: 'An error has occurred'),
                ),
          const HeaderWidget(),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: ((value) => model.cityName = value),
              onSubmitted: (_) => model.onSubmitSearch(),
              decoration: InputDecoration(
                filled: true,
                fillColor: bgGreyColor.withAlpha(235),
                hintText: 'Search',
                hintStyle: TextStyle(color: Color.fromARGB(255, 250, 158, 122),),
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Color.fromARGB(255, 247, 82, 17),),
                  onPressed: model.onSubmitSearch,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: bgGreyColor.withAlpha(235),
            ),
            child: IconButton(
              padding: const EdgeInsets.all(12),
              iconSize: 26,
              onPressed: model.onSubmitLocate,
              icon: const Icon(Icons.location_on_outlined, color: Color.fromARGB(255, 247, 82, 17),),
            ),
          ),
        ],
      ),
    );
  }
}

class CityInfoWidget extends StatelessWidget {
  const CityInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var city = snapshot!.location?.name;
    var temp = snapshot.current?.tempC!.round();
    var feelTemp = snapshot.current?.feelslikeC;
    var windDegree = snapshot.current?.windDegree;
    var url =
        'https://${((snapshot.current!.condition!.icon).toString().substring(2)).replaceAll("64", "128")}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(url, scale: 1.2),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appText(
              size: 30,
              text: '$city',
              isBold: FontWeight.bold,
              color: primaryColor,
            ),
            RotationTransition(
              turns: AlwaysStoppedAnimation(windDegree! / 360),
              child: const Icon(Icons.north, color: primaryColor),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appText(
              size: 70,
              text: '$temp°',
            ),
            appText(size: 20, text: '$feelTemp°', color: darkGreyColor),
          ],
        ),
      ],
    );
  }
}

class BarometerWidget extends StatelessWidget {
  const BarometerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var temperature = snapshot!.current?.tempC;
    var humidity = snapshot.current?.humidity;
    var pressure = snapshot.current?.pressureMb;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: appText(
              size: 20,
              color: primaryColor.withOpacity(.8),
              text: 'Barometer',
              isBold: FontWeight.bold,
            ),
          ),
          Card(
            color: bgGreyColor,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customListTile(
                    first: 'Temperature:',
                    second: ' $temperature °C',
                    icon: Icons.thermostat,
                    iconColor: Color.fromARGB(255, 247, 82, 17),
                  ),
                  customListTile(
                    first: 'Humidity:',
                    second: ' $humidity %',
                    icon: Icons.water_drop_outlined,
                    iconColor: Color.fromARGB(255, 247, 82, 17),
                  ),
                  customListTile(
                    first: 'Pressure:',
                    second: ' $pressure hPa',
                    icon: Icons.speed,
                    iconColor: Color.fromARGB(255, 247, 82, 17),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WindWidget extends StatelessWidget {
  const WindWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    var speed = snapshot!.current?.windKph;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: appText(
              size: 20,
              color: primaryColor.withOpacity(.8),
              text: 'Wind',
              isBold: FontWeight.bold,
            ),
          ),
          Card(
            color: bgGreyColor,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customListTile(
                    text: snapshot.current!.windDir!,
                    first: 'Speed:',
                    second: ' $speed km/h',
                    icon: Icons.air,
                    iconColor: Color.fromARGB(255, 247, 82, 17),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<MainScreenModel>();
    final snapshot = model.forecastObject;
    return SizedBox(
      height: 100,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 23,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: index == 0 ? const EdgeInsets.only(left: 20) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  index < 11
                      ? appText(
                          size: 14,
                          text: '${index + 1} am',
                          color: primaryColor)
                      : index == 11
                          ? appText(
                              size: 14,
                              text: '${index + 1} pm',
                              color: primaryColor)
                          : appText(
                              size: 14,
                              text: '${index - 11} pm',
                              color: primaryColor),
                  const SizedBox(height: 10),
                  Image.network(
                      'https://${(snapshot!.forecast!.forecastday![0].hour![index].condition!.icon).toString().substring(2)}',
                      scale: 2),
                  const SizedBox(height: 5),
                  appText(
                    size: 14,
                    text:
                        '${snapshot.forecast!.forecastday![0].hour![index].tempC}°',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
