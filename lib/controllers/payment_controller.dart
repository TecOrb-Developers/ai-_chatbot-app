import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  static const cardDetailsChannel = MethodChannel('example.com/card_details');

  static String cardNumber = '';
  static String cvv = '';
  static String expiryMonth = '';
  static String expiryYear = '';
  static String cardId = '';
  static String cardName = '';
  static bool saveCardBoolean = false;
  static String client_secret_id = '';

  static Future<void> saveCardDetails() async {
    print('save card');
    try {
      final String result =
          await cardDetailsChannel.invokeMethod('saveCardDetails', {
        'cardNumber': cardNumber,
        'cvv': cvv,
        'expiryMonth': expiryMonth,
        'expiryYear': expiryYear,
        'cardId': cardId,
        'cardName': cardName,
        'saveCardBoolean': saveCardBoolean.toString(),
        'client_secret_id': client_secret_id
      });
      print('result-$result');
    } on PlatformException catch (e) {
      print("Failed to save card details: ${e.message}");
    }
  }
}
