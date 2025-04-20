import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static Future<bool> requestStorage() async {
    return await Permission.storage.request().isGranted;
  }

  static Future<bool> requestLocation() async {
    return await Permission.location.request().isGranted;
  }

  static Future<bool> checkAll() async {
    return await Permission.storage.isGranted && 
           await Permission.location.isGranted;
  }
}