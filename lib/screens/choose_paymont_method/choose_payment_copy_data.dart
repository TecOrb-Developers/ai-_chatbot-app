// import 'dart:convert';

// import 'package:ai_chatbot_flutter/constants/api_const.dart';
// import 'package:ai_chatbot_flutter/screens/add_card_screen/add_card_screen.dart';
// import 'package:ai_chatbot_flutter/services/headers_map.dart';
// import 'package:ai_chatbot_flutter/services/network_api.dart';
// import 'package:ai_chatbot_flutter/utils/colors.dart';
// import 'package:ai_chatbot_flutter/utils/image_assets.dart';
// import 'package:ai_chatbot_flutter/utils/text_styles.dart';
// import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
// import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:http/http.dart' as http;
// import '../../utils/ui_parameters.dart';
// import '../../utils/util.dart';
// import '../../widgets/custom_app_bar.dart';
// import '../../widgets/gradient_rect_btn_widget.dart';

// import '../../widgets/text_white_btn_widget.dart';

// enum SelectCardName { Visa, Axis }

// class ChoosePaymentMethodScreen extends StatefulWidget {
//   const ChoosePaymentMethodScreen({super.key, this.amount});
//   final String? amount;

//   @override
//   State<ChoosePaymentMethodScreen> createState() =>
//       _ChoosePaymentMethodScreenState();
// }

// class _ChoosePaymentMethodScreenState extends State<ChoosePaymentMethodScreen> {
//   SelectPaymentType? _card = SelectPaymentType.DebitCard;
//   SelectCardName? _cardName = SelectCardName.Visa;
//   var id = '';
//   var chooseId = '';
//   var ex_year = '';
//   var ex_month = '';
//   var brand = '';
//   var last4 = '';
//   Map data = {};
//   var client_scret_id = '';
//   bool isloading = false;
//   List<dynamic> cardList = [];
//   int currentIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     getPaymentCardList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kBlackColor,
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomAppBar(
//                   leading: GradientRectBtnWidget(
//                     padding: paddingAll10,
//                     colors: whiteGradientBoxColor,
//                     child: backArrowIcon,
//                     onTap: () => Navigator.pop(context),
//                   ),
//                   title: 'Choose Method',
//                 ),
//                 const GradientHorizontalDivider(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Select Card Type",
//                         style: poppinsRegTextStyle.copyWith(
//                           color: kgrayColor,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Row(
//                             children: [
//                               Radio<SelectPaymentType>(
//                                 value: SelectPaymentType.CreditCard,
//                                 groupValue: _card,
//                                 onChanged: (SelectPaymentType? value) {
//                                   setState(() {
//                                     _card = value;
//                                   });
//                                 },
//                                 fillColor: MaterialStatePropertyAll(kPearColor),
//                                 // activeColor: kPearColor,
//                               ),
//                               Text(
//                                 "Debit Card",
//                                 style: poppinsRegTextStyle.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Radio<SelectPaymentType>(
//                                 value: SelectPaymentType.DebitCard,
//                                 groupValue: _card,
//                                 onChanged: (SelectPaymentType? value) {
//                                   setState(() {
//                                     _card = value;
//                                   });
//                                 },
//                                 fillColor: MaterialStatePropertyAll(kPearColor),
//                               ),
//                               Text(
//                                 "Credit Card",
//                                 style: poppinsRegTextStyle.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                         child: ListView(
//                           children: [
//                             Column(
//                               children: List.generate(
//                                 cardList.length,
//                                 (index) {
//                                   id = cardList[index]['id'];
//                                   if (index == currentIndex) {
//                                     chooseId = id;
//                                   }
//                                   // final item = cardList[index].toString();
//                                   return GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         currentIndex = index;
//                                       });
//                                     },
//                                     child: Slidable(
//                                         endActionPane: ActionPane(
//                                             // dragDismissible: false,
//                                             motion: const ScrollMotion(),
//                                             children: [
//                                               SlidableAction(
//                                                 onPressed: (context) {
//                                                   index != currentIndex
//                                                       ? showDialog(
//                                                           context: context,
//                                                           builder: (ctx) {
//                                                             return AlertDialog(
//                                                               shape: RoundedRectangleBorder(
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               20)),
//                                                               backgroundColor:
//                                                                   const Color
//                                                                           .fromARGB(
//                                                                       255,
//                                                                       58,
//                                                                       54,
//                                                                       54),
//                                                               title: Text(
//                                                                 'Remove Card',
//                                                                 style:
//                                                                     poppinsMedTextStyle
//                                                                         .copyWith(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 17,
//                                                                 ),
//                                                               ),
//                                                               content: Text(
//                                                                 "Do you really want to remove this Card ?",
//                                                                 style:
//                                                                     poppinsMedTextStyle
//                                                                         .copyWith(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 15,
//                                                                 ),
//                                                               ),
//                                                               actions: <Widget>[
//                                                                 TextButton(
//                                                                   onPressed:
//                                                                       () {
//                                                                     Navigator.of(
//                                                                             ctx)
//                                                                         .pop();
//                                                                   },
//                                                                   child: Text(
//                                                                     'No',
//                                                                     style: poppinsRegTextStyle
//                                                                         .copyWith(
//                                                                       color: Colors
//                                                                           .blue,
//                                                                       fontSize:
//                                                                           15,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 TextButton(
//                                                                   onPressed:
//                                                                       () {
//                                                                     deleteCard(
//                                                                         id);
//                                                                     print(id);
//                                                                     Navigator.of(
//                                                                             ctx)
//                                                                         .pop();
//                                                                   },
//                                                                   child: Text(
//                                                                     'Yes',
//                                                                     style: poppinsRegTextStyle
//                                                                         .copyWith(
//                                                                       color: Colors
//                                                                           .blue,
//                                                                       fontSize:
//                                                                           15,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             );
//                                                           })
//                                                       : showSnackbar(
//                                                           context: context,
//                                                           title:
//                                                               "You can't remove this card",
//                                                         );

//                                                   // setState(() {
//                                                   //   cardList.removeAt(index);
//                                                   // });
//                                                 },
//                                                 foregroundColor: Colors.red,
//                                                 backgroundColor: kBlackColor,
//                                                 icon:
//                                                     Icons.delete_sweep_outlined,
//                                               ),
//                                             ]),
//                                         child: AddCardList(
//                                             index: index,
//                                             cardList: cardList,
//                                             currentIndex: currentIndex)),
//                                   );
//                                 },
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () async {
//                                 Navigator.push(context, MaterialPageRoute(
//                                   builder: (context) {
//                                     return const AddCardScreen();
//                                   },
//                                 )).then((value) {
//                                   if (value == true) {
//                                     getPaymentCardList();
//                                   }
//                                 });
//                               },
//                               child: Text(
//                                 "+ Add New Card",
//                                 style: poppinsRegTextStyle.copyWith(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       TextWhiteBtnWidget(
//                         onTap: () {
//                           print(widget.amount);
//                           paymentIntent(chooseId, widget.amount);
//                         },
//                         title: 'Pay',
//                         margin: const EdgeInsets.symmetric(vertical: 30),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Visibility(
//             visible: isloading,
//             child: const Scaffold(
//               backgroundColor: Colors.black38,
//               body: Center(
//                 child: LoadingIndicator(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> getPaymentCardList() async {
//     print('payment card list');
//     setState(() {
//       isloading = true;
//     });
//     try {
//       final headers = {
//         "Authorization": authorizationValue,
//       };
//       var response = await NetworkApi.getResponse(
//           url: paymentCardListUrl, headers: headers);
//       setState(() {
//         Map data = response['data'];
//         cardList = data['data'];
//       });

//       // for (Map item in cardList) {
//       //   id = item['id'];

//       // }
//       // print("id-$id");

//       print("card list -${cardList[0]['ex_month']}");
//       print("get payment card list-$response");
//     } catch (e) {
//       print(e);
//     }
//     setState(() {
//       isloading = false;
//     });
//   }

//   Future<void> deleteCard(String cardId) async {
//     final body = {
//       "cardId": cardId,
//     };
//     final headers = {
//       "Authorization": authorizationValue,
//     };
//     print('delete card');
//     var response =
//         await NetworkApi.post(url: deleteCardUrl, headers: headers, body: body);
//     if (response['code'] == 200) {
//       getPaymentCardList();
//       showSnackbar(
//         context: context,
//         title: 'Successfully card removed',
//       );
//     }
//     print(response);
//   }

//   Future<void> paymentIntent(String cardId, String? amount) async {
//     print('payment intent');
//     try {
//       final body = {"amount": amount, "cardAttachedID": cardId};
//       final headers = {
//         "Authorization": authorizationValue,
//       };

//       var response = await NetworkApi.post(
//           url: customerPaymentIntentUrl, body: body, headers: headers);
//       client_scret_id = response['data']['client_secret'];
//       print('ok');

//       print(response);
//       print(client_scret_id);
//       print('ok');
//     } catch (e) {
//       print(e);
//     }
//     // handleStripePayment();
//   }

//   // Future<void>confirmCardPayment()async{
//   //   var stripe;
//   //   var response= await stripe.confirmCardPayment({secretPublicKey}, {
//   //       payment_method: selectedCard,
//   //       return_url: "https://aichatbot-web.vercel.app/subscription",
//   //     });
//   // }
// //  void confirmPayment()async{
// //   const stripe
// // var Res = await stripe.confirmCardPayment(`${isSecretKey}`, {
// //         payment_method: `${selectedCard}`,
// //         return_url: "https://aichatbot-web.vercel.app/subscription",
// //       });
// //  }
//   Future<void> handleStripePayment() async {
//     print("payment card confirmation");
//     print(client_scret_id);

//     try {
//       final clientSecret =
//           client_scret_id; // Replace with your actual client secret

//       if (clientSecret == null || clientSecret.isEmpty) {
//         print('Invalid client secret.');
//         return;
//       }

//       final url = 'https://api.stripe.com/v1/payment_intents/$clientSecret';
//       print(url);

//       final headers = {
//         'Authorization': "Bearer $secretPublicKey",
//         'Content_method_type': 'application/x-www-form-urlencoded'
//       };

//       final response = await http.get(
//         Uri.parse(url),
//         headers: headers,
//       );

//       final data = json.decode(response.body);
//       print('payment---$data');

//       if (response.statusCode == 200) {
//         print('200');
//         final jsonResponse = json.decode(response.body);
//         final paymentIntent = jsonResponse['paymentIntent'];

//         if (paymentIntent != null && paymentIntent['status'] == 'succeeded') {
//           // Handle successful payment here
//           print('Payment succeeded');
//         } else {
//           // Handle unsuccessful, processing, or canceled payments and API errors here
//           print('Payment failed or still processing');
//         }
//       } else {
//         // Handle other response statuses or errors
//         print('Failed to retrieve payment intent: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('002');
//       print(e);
//     }
//   }
// }

// class AddCardList extends StatelessWidget {
//   const AddCardList(
//       {super.key,
//       required this.cardList,
//       required this.currentIndex,
//       required this.index});

//   final List cardList;
//   final int currentIndex;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         padding: const EdgeInsets.all(12),
//         margin: const EdgeInsets.only(bottom: 15),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: kchatBodyColor,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Container(
//               child: cardIcon,
//             ),
//             const SizedBox(
//               width: 15,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'XXXX XXXX  ${cardList[index]['last4']}',
//                   style: poppinsRegTextStyle.copyWith(
//                     color: Colors.white,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   ' ${cardList[index]['exp_month']}/ ${cardList[index]['exp_year']}',
//                   style: poppinsRegTextStyle.copyWith(
//                     color: kgrayColor,
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//             Spacer(),
//             index == currentIndex
//                 ? const Icon(
//                     Icons.radio_button_checked,
//                     color: kPearColor,
//                   )
//                 : const Icon(
//                     Icons.radio_button_unchecked,
//                     color: kgrayColor,
//                   )
//           ],
//         ));
//   }
// }
