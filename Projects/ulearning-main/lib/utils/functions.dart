import 'package:flutter/material.dart';
import '/views/widgets/custom_web_tab.dart';

Future<void> delay(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}

void launchTermsAndConditions(BuildContext context) {
  launchURLInBottomSheet(context, 'https://touchwoodtechnologies.com/terms');
}

void launchPrivacyPolicy(BuildContext context) {
  launchURLInBottomSheet(
      context, 'https://touchwoodtechnologies.com/privacy-policy',
      h: 1);
}
