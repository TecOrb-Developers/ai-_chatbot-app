import 'dart:convert';
import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/controllers/profile_controller.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/widgets/text_white_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../utils/text_styles.dart';
import '../../utils/ui_parameters.dart';
import '../../utils/util.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import '../../widgets/gradient_rect_btn_widget.dart';
import '../../widgets/loading_indicator.dart';
import 'widget/card_utils.dart';

enum SelectPaymentType { DebitCard, CreditCard }

var cardName = '';
var cardNumber = '';
var cvvNumber = '';
var cardExpiryMonth = '';
var cardExpiryYear = '';
String cardToken = '';
final ProfileController profileController = Get.find<ProfileController>();

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({
    super.key,
  });

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  var cardExpiryNumber = '';
  bool isPosting = false;

  CardType cardType = CardType.Invalid;

  @override
  void initState() {
    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    super.initState();
  }

  Future<void> postCardToken() async {
    print('post card Token');

    try {
      print('try');
      final headers = {
        "Authorization": authorizationValue,
      };
      final body = {
        "cardToken": cardToken,
        "customerId": profileController.stripeId
      };
      print("body--$body");
      var response = await NetworkApi.post(
          url: addCustomerSourceApi, headers: headers, body: body);
      if (response['message'] == "Success") {
        showSnackbar(context: context, title: 'Successfully add card');
        Navigator.pop(context, true);
      }
      setState(() {
        isPosting = false;
      });
      print("response===$response");

      print(response['message']);
    } catch (e) {
      print('catch');
      print(e);
    }
    // setState(() {
    //   isPosting = false;
    // });
  }

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController cardnameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvCodeController = TextEditingController();

  // SelectPaymentType? _card = SelectPaymentType.DebitCard;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SizedBox(
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CustomAppBar(
                          leading: GradientRectBtnWidget(
                            padding: paddingAll10,
                            colors: whiteGradientBoxColor,
                            child: backArrowIcon,
                            onTap: () => Navigator.pop(context),
                          ),
                          title: 'Add Card',
                        ),
                        const GradientHorizontalDivider(),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                ProfileTextContainer(
                                  text: 'Card Holder Name',
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter the Card Holder Name';
                                    }
                                    return null;
                                  },
                                  controller: cardnameController,
                                  keyBoardType: TextInputType.name,
                                ),
                                ProfileTextContainer(
                                  text: 'Card Number',
                                  controller: cardNumberController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(16),
                                    CardNumberInputFormatter()
                                  ],
                                  onChanged: (value) {},
                                  validator: (value) {
                                    return CardUtils.validateCardNum(value);
                                  },
                                  keyBoardType: TextInputType.number,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ProfileTextContainer(
                                        text: 'Exp Date',
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                          CardMonthInputFormatter()
                                        ],
                                        controller: expiryDateController,
                                        keyBoardType: TextInputType.datetime,
                                        onChanged: (value) {},
                                        validator: (value) {
                                          return CardUtils.validateDate(value);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: ProfileTextContainer(
                                        text: 'CVV',
                                        controller: cvvCodeController,
                                        keyBoardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(3),
                                        ],
                                        onChanged: (value) {},
                                        validator: (value) {
                                          return CardUtils.validateCVV(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                    TextWhiteBtnWidget(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isPosting = true;
                          });
                          cardName = cardnameController.text;
                          cardNumber = cardNumberController.text;
                          cardExpiryNumber = expiryDateController.text;
                          cardExpiryMonth =
                              CardUtils.giveMonth(cardExpiryNumber)!;
                          cardExpiryYear =
                              CardUtils.giveYear(cardExpiryNumber)!;
                          cvvNumber = cvvCodeController.text;
                          if (profileController.stripeId == '') {
                            getProfile();
                          }
                          createToken();
                        }
                      },
                      title: 'SAVE & CONTINUE',
                      margin: const EdgeInsets.symmetric(vertical: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isPosting,
            child: const Scaffold(
              backgroundColor: Colors.black38,
              body: Center(
                child: LoadingIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createToken() async {
    print('create Token');

    Map<String, dynamic> body = {
      "card[number]": cardNumber,
      "card[exp_month]": cardExpiryMonth,
      "card[exp_year]": cardExpiryYear,
      "card[cvc]": cvvNumber,
      "card[name]": cardName,
    };
    try {
      setState(() {
        isPosting = true;
      });
      http.Response response;
      response = await http.post(
        Uri.parse(
          createTokenApi,
        ),
        body: body,
        headers: {
          'Authorization': 'Bearer $secretPublicKey',
          'Content_method_type': 'application/x-www-form-urlencoded'
        },
      );

      if (response.statusCode == 200) {
        print('ok');
        var data;
        data = jsonDecode(response.body);
        print(data);

        setState(() {
          cardToken = data['id'];
        });
        if (cardToken != '' && profileController.stripeId != '') {
          postCardToken();
        }
        print('cardToken- $cardToken');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProfile() async {
    print('getProfile');

    try {
      setState(() {
        isPosting = true;
      });
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

        setState(() {
          profileController.stripeId = response['data']['stripeId'];
        });
        print(profileController.stripeId);
      }
      print('okk');
    } catch (e) {
      print("no");
      print(e);
    }
  }
}

class ProfileTextContainer extends StatelessWidget {
  ProfileTextContainer(
      {super.key,
      this.text,
      this.controller,
      this.keyBoardType,
      this.validator,
      this.onChanged,
      this.inputFormatters});
  final String? text;

  final TextEditingController? controller;
  final TextInputType? keyBoardType;

  void Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text!,
            style: poppinsRegTextStyle.copyWith(
              fontSize: 16,
              color: kdarkTextColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            // initialValue: initialvalue,
            keyboardType: keyBoardType,
            cursorColor: Colors.white,
            controller: controller,
            style: poppinsRegTextStyle.copyWith(
              fontSize: 16,
              color: Colors.white,
            ),
            validator: validator,
            decoration: InputDecoration(
                labelStyle: poppinsRegTextStyle.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: kchatBodyColor)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: kchatBodyColor)),
                filled: true,
                fillColor: kchatBodyColor,
                hintStyle: poppinsMedTextStyle.copyWith(
                  fontSize: 17,
                  color: Colors.white,
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: kchatBodyColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          )
        ],
      ),
    );
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }
    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}
