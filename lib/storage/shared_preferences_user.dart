import 'package:shared_preferences/shared_preferences.dart';

const kPhoneNumberKey = 'phone_number';

Future<void> savePhoneNumber(String number) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(kPhoneNumberKey, number);
}

Future<String?> loadPhoneNumber() async {
  final prefs = await SharedPreferences.getInstance();
  final number = prefs.getString(kPhoneNumberKey);
  if (number != null) {
    return number;
  } else {
    return null;
  }
}

Future<void> resetPhoneNumber() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(kPhoneNumberKey);
}
