import 'package:ext_plus/ext_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../../../business_logics/blocs/index.dart';
import '../../../../constants/index.dart';
import '../../../../data/repositories/index.dart';
import '../../../widgets/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier<bool> rememberMe = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          SmartDialog.showLoading(msg: 'Logging in...');
        } else {
          SmartDialog.dismiss();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: transparentAppBar(context, height: 70),
          body: Column(
            children: [
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
                  _form().expand(),
                  ElevatedButton(
                          onPressed: () {
                            var logger = Logger(printer: PrettyPrinter());

                            var loggerNoStack =
                                Logger(printer: PrettyPrinter(methodCount: 0));

                            void demo() {
                              logger.d('Log message with 2 methods');

                              loggerNoStack.i('Info message');

                              loggerNoStack.w('Just a warning!');

                              logger.e('Error! Something bad happened');

                              loggerNoStack.f({'key': 5, 'value': 'something'},
                                  time: DateTime.now());

                              loggerNoStack.e('message');
                            }

                            demo();
                          },
                          child: const Text('Log In'))
                      .expand()
                      .row(),
                  OutlinedButton(onPressed: () {}, child: const Text('Sign Up'))
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

  Widget _form() {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          decoration: const InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock),
          ),
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
      ],
    );
  }

  Row _socialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(MyPng.googleLogo, width: 30.w).onTap(() =>
            context.read<LoginBloc>().add(SocialLoginEvent(GoogleAuth()))),
        Image.asset(MyPng.appleLogo, width: 30.w).onTap(() {}),
        Image.asset(MyPng.facebookLogo, width: 30.w).onTap(() {}),
      ],
    );
  }
}
