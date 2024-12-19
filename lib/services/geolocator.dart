import 'package:geolocator/geolocator.dart';

Future<Position> getLocation()async{
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied){
      return Future.error('Location permission is denied');
    }
  }
  if (permission == LocationPermission.deniedForever){
    return Future.error('Loction permissions are permentaly denied, we cannot request permissions');
  }
  return await Geolocator.getCurrentPosition();
}