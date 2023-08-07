import 'package:ai_chatbot_flutter/screens/add_card_screen/widget/card_utils.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/widgets/text_white_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constants/api_const.dart';
import '../../controllers/payment_controller.dart';
import '../../services/headers_map.dart';
import '../../services/network_api.dart';
import '../../utils/text_styles.dart';
import '../../utils/ui_parameters.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import '../../widgets/gradient_rect_btn_widget.dart';
// import 'package:stripe_sdk/stripe_sdk.dart';

class PayNowScreen extends StatefulWidget {
  const PayNowScreen(
      {super.key,
      this.cardHolderName,
      this.expMonth,
      this.expYear,
      this.last4,
      this.amount,
      required this.cardNo,
      this.saveCardBool,
      this.id});
  final String? last4;
  final String? expMonth;
  final String? expYear;
  final String? cardHolderName;
  final String? id;
  final String? amount;
  final String cardNo;
  final bool? saveCardBool;

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController cardnameController;
  late TextEditingController cardNumberController;
  late TextEditingController expiryDateController;
  late TextEditingController cvvCodeController;
  var client_scret_id = '';
  @override
  void initState() {
    super.initState();
    PaymentController paymentController = Get.put(PaymentController());
    cardnameController = TextEditingController(text: 'Card Holder Name');
    cardNumberController =
        TextEditingController(text: 'XXXX-XXXX-XXXX-${widget.last4}');
    expiryDateController = TextEditingController(
        text: '${widget.expMonth}/${int.parse(widget.expYear!) % 100}');
    // expiryDateController = TextEditingController(text: '12/25');
    cvvCodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          Container(
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  leading: GradientRectBtnWidget(
                    padding: paddingAll10,
                    colors: whiteGradientBoxColor,
                    child: backArrowIcon,
                    onTap: () => Navigator.pop(context),
                  ),
                  title: 'Payment',
                ),
                const GradientHorizontalDivider(),
                Expanded(
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          ProfileTextContainer(
                            enabled: false,
                            text: 'Card Holder Name',
                            onChanged: (value) {},
                            controller: cardnameController,
                            keyBoardType: TextInputType.name,
                          ),
                          ProfileTextContainer(
                            enabled: false,
                            text: 'Card Number',
                            controller: cardNumberController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(19),
                            ],
                            onChanged: (value) {},
                            keyBoardType: TextInputType.number,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ProfileTextContainer(
                                  enabled: false,
                                  text: 'Exp Date',
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(5),
                                  ],
                                  controller: expiryDateController,
                                  keyBoardType: TextInputType.datetime,
                                  onChanged: (value) {},
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Form(
                                  key: _formKey,
                                  child: ProfileTextContainer(
                                    text: 'CVV',
                                    controller: cvvCodeController,
                                    keyBoardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3),
                                    ],
                                    onChanged: (value) {},
                                    validator: (value) {
                                      return CardUtils.validateCVV(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 160,
                          ),
                          TextWhiteBtnWidget(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await paymentIntent(widget.id!, widget.amount);
                                // PaymentController.cardName = '';
                                PaymentController.cardNumber =
                                    PaymentController.cardNumber;
                                PaymentController.cvv = cvvCodeController.text;
                                PaymentController.expiryMonth =
                                    widget.expMonth!;
                                PaymentController.expiryYear = widget.expYear!;
                                PaymentController.saveCardBoolean =
                                    PaymentController.saveCardBoolean;
                                PaymentController.cardId = widget.id!;
                                PaymentController.client_secret_id =
                                    client_scret_id;
                                PaymentController.saveCardDetails();
                              }
                            },
                            title: 'Payment',
                            margin: const EdgeInsets.symmetric(vertical: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> paymentIntent(String cardId, String? amount) async {
    print('payment intent');
    try {
      final body = {"amount": amount, "cardAttachedID": cardId};
      final headers = {
        "Authorization": authorizationValue,
      };

      var response = await NetworkApi.post(
          url: customerPaymentIntentUrl, body: body, headers: headers);
      client_scret_id = response['data']['client_secret'];
      print('ok');

      print(response);
      print(client_scret_id);
      print('ok');
    } catch (e) {
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
      this.inputFormatters,
      this.enabled});
  final String? text;

  final TextEditingController? controller;
  final TextInputType? keyBoardType;

  void Function(String)? onChanged;
  List<TextInputFormatter>? inputFormatters;
  String? Function(String?)? validator;
  bool? enabled;

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
            enabled: enabled,
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
