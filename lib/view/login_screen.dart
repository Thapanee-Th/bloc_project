import 'package:bloc_project/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../route/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    context.read<AuthBloc>().add(
      LoginRequested(_usernameController.text, _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return _body(local);
    return Scaffold(
      appBar: AppBar(title: Text(local.appTitle)),
      body: _body(local),
    );
  }

  Widget _body(AppLocalizations local) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.profile);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              local.login,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: local.username),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: local.password),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: _login,
                  child: Text(local.login),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
