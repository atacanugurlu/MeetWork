import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPref {
  readPref(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  savePref(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  removePref(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
