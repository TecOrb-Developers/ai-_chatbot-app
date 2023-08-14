import 'package:get/get.dart';
import '../constants/api_const.dart';
import '../services/headers_map.dart';
import '../services/network_api.dart';

class ProfileController extends GetxController {
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
    print('getProfile1');
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
      print('okk');
    } catch (e) {
      print("no");
      print(e);
    }
    update();
  }
}
