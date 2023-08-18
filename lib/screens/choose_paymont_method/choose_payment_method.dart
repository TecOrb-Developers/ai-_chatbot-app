import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/screens/add_card_screen/add_card_screen.dart';
import 'package:ai_chatbot_flutter/screens/pay_now_screen/pay_now_screen.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/widgets/grad_horizontal_divider.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/card_detail_model.dart';
import '../../utils/ui_parameters.dart';
import '../../utils/util.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/gradient_rect_btn_widget.dart';

import '../../widgets/text_white_btn_widget.dart';

enum SelectCardName { Visa, Axis }

class ChoosePaymentMethodScreen extends StatefulWidget {
  const ChoosePaymentMethodScreen(
      {super.key, this.amount, this.subcriptionType});
  final String? amount;
  final String? subcriptionType;

  @override
  State<ChoosePaymentMethodScreen> createState() =>
      _ChoosePaymentMethodScreenState();
}

class _ChoosePaymentMethodScreenState extends State<ChoosePaymentMethodScreen> {
  SelectPaymentType? _card = SelectPaymentType.DebitCard;
  SelectCardName? _cardName = SelectCardName.Visa;
  var id = '';
  var cardId = '';
  var chooseId = '';
  var choose_ex_year = '';
  var choose_ex_month = '';
  var choose_last4 = '';
  var ex_year = '';
  var ex_month = '';
  var cardHolderName = 'Card Holder Name';
  var brand = '';
  var last4 = '';
  Map data = {};

  bool isloading = false;
  List<dynamic> cardDataList = [];
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    getPaymentCardList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  leading: GradientRectBtnWidget(
                    padding: paddingAll10,
                    colors: whiteGradientBoxColor,
                    child: backArrowIcon,
                    onTap: () => Navigator.pop(context),
                  ),
                  title: 'Choose Method',
                ),
                const GradientHorizontalDivider(),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Card Type",
                        style: poppinsRegTextStyle.copyWith(
                          color: kgrayColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio<SelectPaymentType>(
                                value: SelectPaymentType.CreditCard,
                                groupValue: _card,
                                onChanged: (SelectPaymentType? value) {
                                  setState(() {
                                    _card = value;
                                  });
                                },
                                fillColor:
                                    const MaterialStatePropertyAll(kPearColor),
                                // activeColor: kPearColor,
                              ),
                              Text(
                                "Debit Card",
                                style: poppinsRegTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio<SelectPaymentType>(
                                value: SelectPaymentType.DebitCard,
                                groupValue: _card,
                                onChanged: (SelectPaymentType? value) {
                                  setState(() {
                                    _card = value;
                                  });
                                },
                                fillColor:
                                    const MaterialStatePropertyAll(kPearColor),
                              ),
                              Text(
                                "Credit Card",
                                style: poppinsRegTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            Column(
                              children: List.generate(
                                cardDataList.length,
                                (index) {
                                  id = cardDataList[index]['id'];

                                  if (index == currentIndex) {
                                    chooseId = id;
                                    choose_ex_month = cardDataList[index]
                                            ['exp_month']
                                        .toString();
                                    choose_ex_year = cardDataList[index]
                                            ['exp_year']
                                        .toString();
                                    choose_last4 =
                                        cardDataList[index]['last4'].toString();
                                    if (cardDataList[index]['name'] != null) {
                                      cardHolderName = cardDataList[index]
                                              ['name']
                                          .toString();
                                    }
                                  }
                                  // final item = cardList[index].toString();
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                    child: Slidable(
                                        endActionPane: ActionPane(
                                            // dragDismissible: false,
                                            motion: const ScrollMotion(),
                                            children: [
                                              SlidableAction(
                                                onPressed: (context) {
                                                  index != currentIndex
                                                      ? showDialog(
                                                          context: context,
                                                          builder: (ctx) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              backgroundColor:
                                                                  const Color
                                                                          .fromARGB(
                                                                      255,
                                                                      58,
                                                                      54,
                                                                      54),
                                                              title: Text(
                                                                'Remove Card',
                                                                style:
                                                                    poppinsMedTextStyle
                                                                        .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                              content: Text(
                                                                "Do you really want to remove this Card ?",
                                                                style:
                                                                    poppinsMedTextStyle
                                                                        .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            ctx)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'No',
                                                                    style: poppinsRegTextStyle
                                                                        .copyWith(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    deleteCard(
                                                                        id);
                                                                    print(id);
                                                                    Navigator.of(
                                                                            ctx)
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    'Yes',
                                                                    style: poppinsRegTextStyle
                                                                        .copyWith(
                                                                      color: Colors
                                                                          .blue,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          })
                                                      : showSnackbar(
                                                          context: context,
                                                          title:
                                                              "You can't remove this card",
                                                        );

                                                  // setState(() {
                                                  //   cardList.removeAt(index);
                                                  // });
                                                },
                                                foregroundColor: Colors.red,
                                                backgroundColor: kBlackColor,
                                                icon:
                                                    Icons.delete_sweep_outlined,
                                              ),
                                            ]),
                                        child: AddCardList(
                                            index: index,
                                            cardList: cardDataList,
                                            currentIndex: currentIndex)),
                                  );
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const AddCardScreen();
                                  },
                                )).then((value) {
                                  if (value == true) {
                                    getPaymentCardList();
                                  }
                                });
                              },
                              child: Text(
                                "+ Add New Card",
                                style: poppinsRegTextStyle.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextWhiteBtnWidget(
                        onTap: () {
                          print('payment');
                          print(widget.amount);
                          if (currentIndex >= 0) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PayNowScreen(
                                  expMonth: choose_ex_month,
                                  expYear: choose_ex_year,
                                  id: chooseId,
                                  last4: choose_last4,
                                  amount: widget.amount,
                                  cardNo: cardId,
                                  saveCardBool: true,
                                  subcriptionType: widget.subcriptionType,
                                  cardHolderName: cardHolderName,
                                );
                              },
                            ));
                          } else {
                            showSnackbar(
                              context: context,
                              title: "Please Select the Card first",
                            );
                          }
                        },
                        title: 'Pay',
                        margin: const EdgeInsets.symmetric(vertical: 30),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isloading,
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

  Future<CardDetail> getCardDetail(String cardId) async {
    try {
      final headers = {
        "Authorization": authorizationValue,
      };
      String cardDetailUrl = "/v1/customers/cus_OCtfhpXI2YvuFs/sources/$cardId";
      var response = await NetworkApi.getResponse(
        url: cardDetailUrl,
        headers: headers,
      );

      CardDetail cardDetail = CardDetail.fromJson(response);

      return cardDetail;
    } catch (e) {
      print(e);
      return CardDetail(
          data: Data(
            object: '',
            data: [],
            hasMore: false,
            url: "xyz.com",
          ),
          code: 167,
          message: '');
    }
  }

  Future<void> getPaymentCardList() async {
    print('payment card list');
    setState(() {
      isloading = true;
    });
    try {
      final headers = {
        "Authorization": authorizationValue,
      };
      var response = await NetworkApi.getResponse(
        url: paymentCardListUrl,
        headers: headers,
      );

      setState(() {
        Map<String, dynamic> data = response['data'];
        cardDataList = data['data'];
      });

      print("get payment card list-$response");
    } catch (e) {
      print(e);
    }
    setState(() {
      isloading = false;
    });
  }

  Future<void> deleteCard(String cardId) async {
    final body = {
      "cardId": cardId,
    };
    final headers = {
      "Authorization": authorizationValue,
    };
    print('delete card');
    var response =
        await NetworkApi.post(url: deleteCardUrl, headers: headers, body: body);
    if (response['code'] == 200) {
      getPaymentCardList();
      showSnackbar(
        context: context,
        title: 'Successfully card removed',
      );
    }
    print(response);
  }
}

class AddCardList extends StatelessWidget {
  const AddCardList(
      {super.key,
      required this.cardList,
      required this.currentIndex,
      required this.index});

  final List cardList;
  final int currentIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kchatBodyColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              child: cardIcon,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'XXXX XXXX  ${cardList[index]['last4']}',
                  style: poppinsRegTextStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  ' ${cardList[index]['exp_month']}/ ${cardList[index]['exp_year']}',
                  style: poppinsRegTextStyle.copyWith(
                    color: kgrayColor,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Spacer(),
            currentIndex == index
                ? const Icon(
                    Icons.radio_button_checked,
                    color: kPearColor,
                  )
                : const Icon(
                    Icons.radio_button_unchecked,
                    color: kgrayColor,
                  )
          ],
        ));
  }
}
