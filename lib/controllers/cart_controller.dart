import 'package:homeeaze_sourcecode/Models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController {
  Future<bool> isServiceExist(String serviceName) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(serviceName) != null);
  }

  Future<Service> read(String serviceName) async {
    final prefs = await SharedPreferences.getInstance();
    return Service.fromJson(prefs.getString(serviceName)!);
  }

  Future<void> save(String serviceName, Service service) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(serviceName, service.toJson());
  }

  Future<void> remove(String serviceName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(serviceName);
  }
}
