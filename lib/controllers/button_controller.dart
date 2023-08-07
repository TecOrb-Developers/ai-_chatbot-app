import 'package:get/get.dart';

class ButtonController extends GetxController {
  String _selectCard = 'Debit Card';
  String get selectCard => _selectCard;
  void selectCardType(String type) {
    _selectCard = type;
    update();
  }
}
