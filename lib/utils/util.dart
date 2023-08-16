import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar({
  required BuildContext context,
  required String title,
  Duration duration = const Duration(milliseconds: 2000),
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(title)),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      action: action,
    ),
  );
}

bool isValidEmail(String email) {
  // Regular expression pattern for email validation
  const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(email);
}

void showCountryPickerBottomSheet(BuildContext context) {
  return showCountryPicker(
    context: context,
    showPhoneCode: true,
    countryListTheme: CountryListThemeData(
      borderRadius: BorderRadius.circular(20),
      inputDecoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          // borderSide: BorderSide(color: kAccentColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
              // color: kLightestTextColor,
              ),
        ),
        hintText: "Enter your country name or code",
        contentPadding: const EdgeInsets.only(left: 28),
        hintStyle: const TextStyle(
          // color: kLightestTextColor,
          fontSize: 14,
        ),
      ),
    ),
    onSelect: (Country country) {
      // setState(() {
      //   maxLength = country.example.length;
      //   selectedCountryCode = country.phoneCode;
      // });
    },
  );
}

final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final nameRegExp =
    RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$", caseSensitive: false);
