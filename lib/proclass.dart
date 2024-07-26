import 'package:shared_preferences/shared_preferences.dart';

class UserProfile {
  static const String keyName = 'name';
  static const String keyAge = 'age';
  static const String keyCity = 'city';
  static const String keyBio = 'bio';

  static Future<void> saveProfile(String name, int age, String city, String bio) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyName, name);
    await prefs.setInt(keyAge, age);
    await prefs.setString(keyCity, city);
    await prefs.setString(keyBio, bio);
  }

  static Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(keyName);
    final age = prefs.getInt(keyAge);
    final city = prefs.getString(keyCity);
    final bio = prefs.getString(keyBio);

    return {
      'name': name,
      'age': age,
      'city': city,
      'bio': bio,
    };
  }
}
