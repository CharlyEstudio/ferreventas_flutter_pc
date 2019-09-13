// Plugins
import 'package:geolocator/geolocator.dart';

class PosicionProvider {

  getPosicion() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}