import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';

void launchTermsAndConditions(BuildContext context) {
  launchURLInBottomSheet(context, 'https://touchwoodtechnologies.com/terms');
}

void launchPrivacyPolicy(BuildContext context) {
  launchURLInBottomSheet(
      context, 'https://touchwoodtechnologies.com/privacy-policy',
      h: 1);
}
