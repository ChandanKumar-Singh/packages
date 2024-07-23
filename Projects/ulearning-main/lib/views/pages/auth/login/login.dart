import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/blocs/index.dart';
import '/constants/asset_const.dart';
import '/utils/extentions/index.dart';
import '/utils/index.dart';
import '/views/pages/index.dart';

import '../../../../blocs/auth/providers/providers.dart';
import '../../../../routes/index.dart';
import '../../../widgets/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> rememberMe = ValueNotifier(false);
  ValueNotifier<bool> termsCondition = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        logg('AuthBloc listener ${state.status} : ${state.message}',
            name: 'LoginPage');
        if (state.status == AuthStatus.loading) {
          showLoading();
        } else {
          hideLoading();
        }
        if (state.status == AuthStatus.success) {
          logg('User is logged in ${state.user?.toMap()}');
          successToast(state.message ?? "Success");
        } else if (state.status == AuthStatus.failure) {
          errorToast(state.message ?? "Error");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: transparentAppBar(
            context,
            title: 'Log In',
            theme: true,
            height: 0,
            centerTile: true,
          ),
          body: Column(
            children: [
              10.height,
              const Text('Log In'),
              Divider(color: Colors.grey[200], thickness: 1),
              Column(
                children: [
                  _socialLogin(),
                  const SizedBox(height: 20),
                  Text('Or user your email account to log in',
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey)),
                  50.height,
                  _form(context, state).scrollable().expand(),
                  ElevatedButton(
                          onPressed: () => _login(EmailAuth(
                              email: state.email, password: state.password)),
                          child: const Text('Log In'))
                      .expand()
                      .row(),
                  OutlinedButton(
                          onPressed: () => pushTo(SignUpPage.routeName),
                          child: const Text('Sign Up'))
                      .expand()
                      .row(),
                ],
              ).paddingSymmetric(vertical: 20.h, horizontal: 20.w).expand(),
            ],
          ),
        );
      },
    );
  }

  void _login(AuthProviderInterface method) async {
    if (!termsCondition.value) {
      infoToast('Please agree to the terms and conditions');
      return;
    }
    if (method is EmailAuth) {
      if (!formKey.currentState!.validate()) {
        return;
      }
      if (rememberMe.value) TextInput.finishAutofillContext();
      formKey.currentState!.save();
    }
    context.read<AuthBloc>().add(AuthLoginSubmitted(method));
  }

  Widget _form(BuildContext context, AuthState state) {
    return AutofillGroup(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            MyTextField(
              controller: TextEditingController(),
              onChanged: (value) =>
                  context.read<AuthBloc>().add(AuthEmailChanged(value)),
              label: 'Email',
              prefix: const Icon(Icons.email),
              isPassword: false,
              inputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              hint: 'Enter your email',
              autofillHints: const [
                AutofillHints.email,
                AutofillHints.username,
                AutofillHints.newUsername,
              ],
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: TextEditingController(),
              onChanged: (value) =>
                  context.read<AuthBloc>().add(AuthPasswordChanged(value)),
              onSubmit: (p0) => _login(
                  EmailAuth(email: state.email, password: state.password)),
              label: 'Password',
              prefix: const Icon(Icons.lock),
              isPassword: true,
              inputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              hint: 'Enter your password',
              autofillHints: const [
                AutofillHints.newPassword,
                AutofillHints.password,
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: rememberMe,
                        builder: (context, value, child) {
                          return Checkbox(
                              value: value,
                              onChanged: (value) {
                                rememberMe.value = value!;
                              });
                        }),
                    const Text('Remember me'),
                  ],
                ),
                const Text('Forgot password?').onTap(() {}, radius: 3),
              ],
            ),
            Row(
              children: [
                ValueListenableBuilder<bool>(
                    valueListenable: termsCondition,
                    builder: (context, value, child) {
                      return Checkbox(
                          value: value,
                          onChanged: (value) {
                            termsCondition.value = value!;
                          });
                    }),
                RichText(
                  text: TextSpan(
                    text: 'I agree to the ',
                    style: context.textTheme.bodySmall,
                    children: [
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchTermsAndConditions(context),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launchPrivacyPolicy(context),
                      ),
                    ],
                  ),
                ).expand(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(MyPng.googleLogo, width: 30.w)
            .onTap(() => _login(GoogleAuth())),
        Image.asset(MyPng.appleLogo, width: 30.w)
            .onTap(() => _login(AppleAuth())),
        Image.asset(MyPng.facebookLogo, width: 30.w)
            .onTap(() => _login(FacebookAuth())),
      ],
    );
  }
}
