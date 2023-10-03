import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/api_const.dart';
import '../constants/shared_prefs_keys.dart';
import '../services/headers_map.dart';
import '../services/network_api.dart';

class ProfileController extends GetxController {
  void onInit() {
    super.onInit();
    print('get profile!!');
    getProfile();
  }

  var subscribeType = '';
  bool subscription = false;
  bool isImage = false;
  var stripeId = '';
  var name = '';
  var image = '';
  bool isLoading = false;
  var selectedCountryCode = '';
  var email = '';
  var phoneNo = '';
  bool isUploading = false;

  Future<void> getProfile() async {
    isLoading = true;

    print('getProfile!!!');
    try {
      final headers = {
        "Authorization": authorizationValue,
      };
      var response = await NetworkApi.getResponse(
        url: getProfileUrl,
        headers: headers,
      );

      print('getProfile--$response');
      if (response['code'] == 200) {
        isLoading = false;
        update();
        print('ok');
        subscribeType = response['data']['subscriptionType'].toString();
        subscription = response['data']['subscription'];
        name = response['data']['name'];
        selectedCountryCode = response['data']['countryCode'];
        email = response['data']['email'];
        phoneNo = response['data']['phoneNumber'];
        stripeId = response['data']['stripeId'];
        subscription = response['data']['subscription'];
        if (response['data']['image'] != null) {
          print('image');
          image = response['data']['image'];
          isImage = true;
        } else {
          print('image null');
        }
      }
      print(subscribeType);
      print(subscription);
      final prefs = await SharedPreferences.getInstance();

      prefs.setString(subcriptionTypeKey, subscribeType);
      subcription_type = prefs.getString(subcriptionTypeKey) ?? '';

      print('okk');
    } catch (e) {
      print("no");
      print(e);
    }
    isLoading = false;

    update();
  }
}
