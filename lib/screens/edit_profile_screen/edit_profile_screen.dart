import 'dart:io';

import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/screens/settings_screen/screen/settings_screen.dart';
import 'package:ai_chatbot_flutter/screens/settings_screen/widgets/profile_avatar.dart';
import 'package:ai_chatbot_flutter/services/headers_map.dart';
import 'package:ai_chatbot_flutter/services/network_api.dart';
import 'package:ai_chatbot_flutter/utils/colors.dart';
import 'package:ai_chatbot_flutter/utils/image_assets.dart';
import 'package:ai_chatbot_flutter/utils/text_styles.dart';
import 'package:ai_chatbot_flutter/utils/ui_parameters.dart';
import 'package:ai_chatbot_flutter/utils/util.dart';
import 'package:ai_chatbot_flutter/widgets/custom_app_bar.dart';
import 'package:ai_chatbot_flutter/widgets/gradient_rect_btn_widget.dart';
import 'package:ai_chatbot_flutter/widgets/loading_indicator.dart';
import 'package:ai_chatbot_flutter/widgets/profile_container.dart';
import 'package:ai_chatbot_flutter/widgets/text_white_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/grad_horizontal_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {super.key,
      this.email,
      this.selectedCountryCode,
      this.image,
      this.name,
      this.phoneNo,
      this.subscription});
  final email;
  final phoneNo;
  final name;
  final selectedCountryCode;
  final image;
  final subscription;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // var selectedCountryCode = '';
  // var email = '';
  // var phoneNo = '';
  // var name = '';
  // var image = '';
  File? images;
  // bool subscription = false;
  // bool isLoading = false;
  bool isUploading = false;
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    print('editProfile');

    emailController = TextEditingController(text: widget.email);
    nameController = TextEditingController(text: widget.name);
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);
    if (pickedImage == null) return;

    final imageTemporary = File(pickedImage.path);
    setState(() {
      this.pickedImage = imageTemporary;
    });
  }

  // Future<void> getProfile() async {
  //   print('getProfile');
  //   try {
  //     final headers = {
  //       "Authorization": authorizationValue,
  //     };
  //     var response = await NetworkApi.getResponse(
  //       url: getProfileUrl,
  //       headers: headers,
  //     );
  //     print('getProfile--$response');
  //     if (response['message'] == 'Success') {
  //       isLoading = true;
  //      name = response['data']['name'];
  //       selectedCountryCode = response['data']['countryCode'];
  //       email = response['data']['email'];
  //       phoneNo = response['data']['phoneNumber'];
  //       subscription = response['data']['subscription'];
  //       image = response['data']['image'];
  //       setState(() {
  //         emailController = TextEditingController(text: email);
  //         nameController = TextEditingController(text: name);
  //       });
  //     }
  //   } catch (e) {
  //     print("no");
  //     print(e);
  //   }
  // }

  Future<void> updateProfile() async {
    print('updateProfile');

    setState(() {
      isUploading = true;
    });
    try {
      final headers = {
        "Authorization": authorizationValue,
      };
      final Map<String, String> body = {
        // "name": nameController.text.trim(),
        // "email": emailController.text.trim(),
        "phoneNumber": widget.phoneNo,
        "countryCode": widget.selectedCountryCode,
      };
      setState(() {});
      if (nameController.text.trim() != null) {
        body["name"] = nameController.text.trim();
      } else {
        body["name"] = widget.name;
      } //name section

      if (emailController.text.trim() != null) {
        body["email"] = emailController.text.trim();
      } else {
        body["email"] = widget.email;
      } //email section

      if (pickedImage != null) {
        images = File(pickedImage!.path);
      }
      //image section

      print(nameController.text.trim());
      print(emailController.text.trim());

      var response = await NetworkApi.postFormData(
          url: udateProfileUrl,
          httpRequestType: "PUT",
          body: body,
          headers: headers,
          image: images);
      print('updateProfile-- $response');
      if (response['message'] == "Success") {
        showSnackbar(
          context: context,
          title: AppLocalizations.of(context)!.successfullyUpdated,
        );

        Navigator.pop(context, true);
      }
      print(response['message']);
    } catch (e) {
      print(e);
    }
    setState(() {
      isUploading = false;
    });
  }

  int maxLength = 10;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        CustomAppBar(
                          leading: GradientRectBtnWidget(
                            padding: paddingAll10,
                            colors: whiteGradientBoxColor,
                            child: backArrowIcon,
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          title: AppLocalizations.of(context)!.editProfile,
                        ),
                        const GradientHorizontalDivider(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            ProfileAvatar(
                              onpress: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      Future.delayed(Duration(seconds: 5), () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        backgroundColor: const Color.fromARGB(
                                            255, 58, 54, 54),
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .selectImagefrom,
                                          style: poppinsMedTextStyle.copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              pickImage(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .camera,
                                              style:
                                                  poppinsRegTextStyle.copyWith(
                                                color: Colors.blue,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              pickImage(ImageSource.gallery);
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .gallery,
                                              style:
                                                  poppinsRegTextStyle.copyWith(
                                                color: Colors.blue,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              backgroundImage: isImage
                                  ? pickedImage != null
                                      ? Image.file(
                                          pickedImage!,
                                          fit: BoxFit.contain,
                                        ).image
                                      : NetworkImage(
                                          widget.image,
                                        )
                                  : const AssetImage(
                                      'assets/images/avatar.png'),
                              child: const CircleAvatar(
                                radius: 16,
                                backgroundColor: kBlackColor,
                                child: cameraIcon,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ProfileContainer(
                              icon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              name: 'Arihant Singh',
                              text: AppLocalizations.of(context)!.fullName,
                              onChanged: (val) {},
                              validator: (val) {
                                if (val == '') {
                                  return AppLocalizations.of(context)!
                                      .enterTheName;
                                }
                                return null;
                              },
                              keyBoardType: TextInputType.name,
                              controller: nameController,
                            ),
                            ProfileContainer(
                              icon: const Icon(Icons.mail, color: Colors.white),
                              name: 'arihant@gmail.com',
                              text: AppLocalizations.of(context)!.email,
                              onChanged: (val) {},
                              validator: (val) {
                                if (val == null) {
                                  return AppLocalizations.of(context)!
                                      .enterTheEmail;
                                } else if (!emailRegExp.hasMatch(val)) {
                                  return AppLocalizations.of(context)!
                                      .enterTheValidMail;
                                }
                                return null;
                              },
                              keyBoardType: TextInputType.emailAddress,
                              controller: emailController,
                            ),
                            Text(
                              AppLocalizations.of(context)!.mobileNo,
                              style: poppinsRegTextStyle.copyWith(
                                fontSize: 16,
                                color: kdarkTextColor,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 18,
                              ),
                              decoration: const BoxDecoration(
                                color: Color(0xff171717),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        mobileIcon,
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.selectedCountryCode,
                                          style: poppinsRegTextStyle.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      widget.phoneNo,
                                      style: poppinsRegTextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 160,
                            ),
                            TextWhiteBtnWidget(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  updateProfile();
                                }
                              },
                              title: AppLocalizations.of(context)!.update,
                              margin: const EdgeInsets.symmetric(vertical: 30),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isUploading,
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
//
// }
}
