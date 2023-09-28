import 'dart:io';

import 'package:ai_chatbot_flutter/constants/api_const.dart';
import 'package:ai_chatbot_flutter/controllers/profile_controller.dart';
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
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/grad_horizontal_divider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  File? images;

  bool isUploading = false;
  File? pickedImage;
  late final ProfileController profileController;
  @override
  void initState() {
    super.initState();
    print('editProfile');
    profileController = Get.find();

    emailController = TextEditingController(text: profileController.email);
    nameController = TextEditingController(text: profileController.name);
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      print('pick Image1');
      final picker = ImagePicker();
      print('pick Image2');
      final pickedImage = await picker.pickImage(source: source);
      print('pick Image3--$pickedImage');

      if (pickedImage == null) return;
      print('pick Image4');

      final imageTemporary = File(pickedImage.path);
      print('pick Image5');
      setState(() {
        this.pickedImage = imageTemporary;
      });
    } catch (e) {
      print('not pick image');
      print(e);
    }
  }

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
        "phoneNumber": profileController.phoneNo,
        "countryCode": profileController.selectedCountryCode,
      };
      setState(() {});
      if (nameController.text.trim() != null) {
        body["name"] = nameController.text.trim();
      } else {
        body["name"] = profileController.name;
      } //name section

      if (emailController.text.trim() != null) {
        body["email"] = emailController.text.trim();
      } else {
        body["email"] = profileController.email;
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
      profileController.isUploading = false;
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
                child: Container(
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          GetBuilder<ProfileController>(
                            builder: (controller) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  ProfileAvatar(
                                    onpress: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 58, 54, 54),
                                              content: Text(
                                                AppLocalizations.of(context)!
                                                    .selectImagefrom,
                                                style: poppinsMedTextStyle
                                                    .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    pickImage(
                                                        ImageSource.camera);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .camera,
                                                    style: poppinsRegTextStyle
                                                        .copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    pickImage(
                                                        ImageSource.gallery);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .gallery,
                                                    style: poppinsRegTextStyle
                                                        .copyWith(
                                                      color: Colors.blue,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    backgroundImage: controller.image != ''
                                        ? pickedImage != null
                                            ? Image.file(
                                                pickedImage!,
                                                fit: BoxFit.contain,
                                              ).image
                                            : NetworkImage(
                                                controller.image,
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
                                    text:
                                        AppLocalizations.of(context)!.fullName,
                                    maxlength: 20,
                                    onChanged: (val) {},
                                    validator: (val) {
                                      if (val == '') {
                                        return AppLocalizations.of(context)!
                                            .enterTheName;
                                      } else if (!nameRegExp.hasMatch(val!)) {
                                        return 'Only alphabets are allowed';
                                      } else if (val.length < 3) {
                                        return 'Enter at least 3 character';
                                      }

                                      return null;
                                    },
                                    keyBoardType: TextInputType.name,
                                    controller: nameController,
                                  ),
                                  ProfileContainer(
                                    icon: const Icon(Icons.mail,
                                        color: Colors.white),
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
                                                controller.selectedCountryCode,
                                                style: poppinsRegTextStyle
                                                    .copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const Icon(
                                                Icons
                                                    .keyboard_arrow_down_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            controller.phoneNo,
                                            style: poppinsRegTextStyle.copyWith(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
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
                  ),
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
}
