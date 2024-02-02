import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> saveTheme(String theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.setString("theme", theme);
    return result;
  }

  static Future<String?> gatTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currentTheme = sharedPreferences.getString("theme");
    return currentTheme;
  }

  static Future<bool> addFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites =
        sharedPreferences.getStringList("favourite") ?? [];
    favourites.add(id);
    return sharedPreferences.setStringList("favourite", favourites);
  }

  static Future<bool> removeFavourite(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> favourites =
        sharedPreferences.getStringList("favourite") ?? [];
    favourites.remove(id);
    return sharedPreferences.setStringList("favourite", favourites);
  }

  static Future<List<String>> fetchFavourite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("favourite") ?? [];
  }
}
