
import 'package:arzaq_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys{
  loggedIn,
  name,
  email,
  phone,
  image,
  type,
  token
}
class SharedPrefController {
  SharedPrefController._();

  static final SharedPrefController _instance = SharedPrefController._();


  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future<void> save({ required User user, bool withToken = true}) async{
    if(withToken) {
      await _sharedPreferences.setString(PrefKeys.token.name, 'Bearer '+user.token!);
    }
    await _sharedPreferences.setString(PrefKeys.name.name, user.name!);
    await _sharedPreferences.setString(PrefKeys.email.name, user.email!);
    await _sharedPreferences.setString(PrefKeys.phone.name, user.phone!);
    await _sharedPreferences.setString(PrefKeys.image.name, user.image!);
    await _sharedPreferences.setString(PrefKeys.type.name, user.type!);
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);

  }

  T? getValueFor<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T?;
    }
    return null;
  }

  Future<bool> clear()async{
    return await _sharedPreferences.clear();
  }
}