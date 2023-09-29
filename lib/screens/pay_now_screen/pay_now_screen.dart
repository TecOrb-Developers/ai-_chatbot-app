import 'package:ai_chatbot_flutter/screens/add_card_screen/widget/card_utils.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/widgets/bottom_bar.dart';
import 'package:ai_chatbot_flutter/widgets/text_white_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/api_const.dart';
import '../../services/headers_map.dart';
import '../../services/network_api.dart';
import '../../utils/text_styles.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../utils/ui_parameters.dart';
import '../../utils/util.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/grad_horizontal_divider.dart';
import '../../widgets/gradient_rect_btn_widget.dart';
import '../../widgets/loading_indicator.dart';

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
      this.id,
      this.subcriptionType});
  final String? last4;
  final String? expMonth;
  final String? expYear;
  final String? cardHolderName;
  final String? id;
  final String? amount;
  final String cardNo;
  final bool? saveCardBool;
  final String? subcriptionType;

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
  bool paymentProcess = false;
  var paymentId = '';

  @override
  void initState() {
    super.initState();
    // PaymentController paymentController = Get.put(PaymentController());
    cardnameController = TextEditingController(text: widget.cardHolderName);
    cardNumberController =
        TextEditingController(text: 'XXXX-XXXX-XXXX-${widget.last4}');
    expiryDateController = TextEditingController(
        text: '${widget.expMonth}/${int.parse(widget.expYear!) % 100}');
    // expiryDateController = TextEditingController(text: '12/25');
    cvvCodeController = TextEditingController();
  }

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
                          title: 'Payment',
                        ),
                        const GradientHorizontalDivider(),
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
                          ],
                        ),
                      ],
                    ),
                    TextWhiteBtnWidget(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await paymentIntent(widget.id!, widget.amount);
                          comfirmPayment();
                          // // PaymentController.cardName = '';
                          // PaymentController.cardNumber =
                          //     PaymentController.cardNumber;
                          // PaymentController.cvv = cvvCodeController.text;
                          // PaymentController.expiryMonth =
                          //     widget.expMonth!;
                          // PaymentController.expiryYear = widget.expYear!;
                          // PaymentController.saveCardBoolean =
                          //     PaymentController.saveCardBoolean;
                          // PaymentController.cardId = widget.id!;
                          // PaymentController.client_secret_id =
                          //     client_scret_id;
                          // PaymentController.saveCardDetails();
                        }
                      },
                      title: 'Payment',
                      margin: const EdgeInsets.symmetric(vertical: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: paymentProcess,
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

  Future<void> paymentIntent(String cardId, String? amount) async {
    print('payment intent');
    try {
      setState(() {
        paymentProcess = true;
      });
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

  Future<void> comfirmPayment() async {
    print('confirm Payment');
    try {
      final paymentResult = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: client_scret_id,
      );
      print('confirm Payment1');
      print("paymentResul===$paymentResult");

      if (paymentResult.status == PaymentIntentsStatus.Succeeded) {
        print('confirm Payment2');
        print(widget.amount);
        print(widget.subcriptionType);
        subscription(paymentResult.id);
        setState(() {
          paymentProcess = false;
        });

        print("paymentResul===${paymentResult.id}");
      }
    } catch (e) {
      print("error---$e");
      setState(() {
        paymentProcess = false;
      });

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              title: Text(
                'Oops!,Some thing went wrong',
                style: poppinsMedTextStyle.copyWith(
                  color: Colors.red,
                  fontSize: 17,
                ),
              ),
              content: Icon(
                Icons.dangerous,
                color: Colors.red,
                size: 40,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      showSnackbar(
                        context: context,
                        title: "Payment Not Successfull",
                      );
                    },
                    child: Text('OK')),
              ],
            );
          });
    }
    setState(() {
      paymentProcess = false;
    });
  }

  Future<void> subscription(String id) async {
    print('subscription');
    try {
      final body = {
        "subscriptionType":
            widget.subcriptionType, // OneDay , Weekly , Monthly ,Yearly
        "amount": widget.amount,
        "paymentId": id,
        "cardType": "Debit", // Debit , Cradit
        "paymentStatus": "succeeded" // succeeded
      };
      final headers = {
        "Authorization": authorizationValue,
      };

      var response = await NetworkApi.post(
          url: subsciptionUrl, body: body, headers: headers);
      if (response['code'] == 200) {
        print("response>>>>>$response");
        print("response>>>>>${response['data']}");
        paymentId = response['data']['paymentId'];
        print("response>>>>>$paymentId");
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    successfullpaymentIcon,
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Payment Successfull',
                      style: poppinsMedTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'You have completed your payment',
                      style: poppinsRegTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      'Transaction Number: ${paymentId.toString()}',
                      style: poppinsRegTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => BottomBar()),
                            (Route<dynamic> route) => false);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => BottomBar(),
                        //     ));

                        // showSnackbar(
                        //   context: context,
                        //   title: "Payment Successfull",
                        // );
                      },
                      child: Text('OK')),
                ],
              );
            });
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      paymentProcess = false;
    });
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
