import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_tutorial/extensions/datetime.dart';
import 'package:weather_app_tutorial/providers/current_weather_providers.dart';
import 'package:weather_app_tutorial/views/gradient_container.dart';

import '../constants/text_styles.dart';
import '../views/hourly_forcast_view.dart';
import '../views/weather_info.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(currentWeatherProvider);
    return weatherData.when(data: (weather){
      return GradientContainer(
          children: [
            const SizedBox(width: double.infinity,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(weather.name, style: TextStyles.h1,),
                const SizedBox(height: 20,),

                Text(DateTime.now().dateTime, style: TextStyles.subtitleText,),
                const SizedBox(height: 30,),
                SizedBox(
                  height: 260,
                  child: Image.asset(
                    'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40,),
                Text(weather.weather[0].description, style: TextStyles.h2,),
              ],
            ),

            WeatherInfo(weather: weather,),
            const SizedBox(height: 30,),
            //hour forcast

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Today', style: TextStyles.h2,),
                TextButton(onPressed: (){}, child: const Text('View Full Forecast')
                )
              ],
            ),
            const SizedBox(height: 15,),
              const HourlyForecastView(),
          ]);
    },
      error: (error, StackTrace){
      return Center(
        child: Text(error.toString()),
      );
    },
        loading: (){
          return const Center(
            child: CircularProgressIndicator(),
          );
        },);
  }
}
