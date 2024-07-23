import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/blocs/auth/providers/providers.dart';
import '/utils/extentions/index.dart';
import '/utils/index.dart';
import '/views/widgets/index.dart';

import '../../../../blocs/auth/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
  static const String routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          logg('User is logged in ${state.user?.toMap()}');
          successToast(state.message ?? "Success");
        } else if (state.status == AuthStatus.failure) {
          errorToast(state.message ?? "Error");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Login / Register')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                MyTextField(
                    onChanged: (value) =>
                        context.read<AuthBloc>().add(AuthEmailChanged(value)),
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.isEmail) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    }),
                20.height,
                MyTextField(
                  onChanged: (value) =>
                      context.read<AuthBloc>().add(AuthPasswordChanged(value)),
                  label: 'Password',
                  isPassword: true,
                  autofillHints: const [AutofillHints.password],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state.status == AuthStatus.loading) {
                      return const CircularProgressIndicator();
                    } else if (state.status == AuthStatus.success) {
                      return Text('Success: ${state.message}');
                    } else if (state.status == AuthStatus.failure) {
                      return Text('Error: ${state.message}',
                          style: const TextStyle(color: Colors.red));
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => context.read<AuthBloc>().add(
                          AuthLoginSubmitted(
                              EmailAuth(email: '', password: ''))),
                      child: const Text('Login'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => context.read<AuthBloc>().add(
                          AuthRegisterSubmitted(
                              EmailAuth(email: '', password: ''))),
                      child: const Text('Register'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(AuthLoginSubmitted(GoogleAuth())),
                      child: const Text('Login with Google'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(AuthLoginSubmitted(FacebookAuth())),
                      child: const Text('Login with Facebook'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => context
                          .read<AuthBloc>()
                          .add(AuthLoginSubmitted(AppleAuth())),
                      child: const Text('Login with Apple'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
