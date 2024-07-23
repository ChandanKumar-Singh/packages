import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../business_logics/blocs/index.dart';
import '../../../../constants/index.dart';
import '../../../../core/index.dart';
import '../../../widgets/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.redirect});
  final String? redirect;
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> rememberMe = ValueNotifier(false);
  ValueNotifier<bool> termsCondition = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();

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
          logg('User is logged in ${state.user?.toJson()}');
          successToast(state.message ?? "Success");
        } else if (state.status == AuthStatus.failure) {
          errorToast(state.message ?? "Error");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: transparentAppBar(context, height: 70, theme: true),
          body: Column(
            children: [
              const Text('Log In'),
              Divider(color: Colors.grey[200], thickness: 1),
              ListView(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: 20.h, horizontal: 20.w),
                children: [
                  _socialLogin(),
                  20.height,
                  Text('Or user your email account to log in',
                          style: context.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey))
                      .center(),
                  50.height,
                  _form(context, state),
                ],
              ).expand(),
            ],
          ),
          bottomNavigationBar: bottomBar(context)
              .paddingSymmetric(vertical: 20.h, horizontal: 20.w),
        );
      },
    );
  }

  Column bottomBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
                onPressed: () => _login(EmailAuth('email', 'password')),
                child: const Text('Log In'))
            .expand()
            .row(),
        OutlinedButton(onPressed: () {}, child: const Text('Sign Up'))
            .expand()
            .row(),
      ],
    );
  }

  Widget _form(BuildContext context, AuthState state) {
    return AutofillGroup(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            MyTextField(
              // controller: TextEditingController(),
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
              // controller: TextEditingController(),
              onChanged: (value) =>
                  context.read<AuthBloc>().add(AuthPasswordChanged(value)),
              onSubmit: (p0) => _login(EmailAuth(state.email, state.password)),
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
