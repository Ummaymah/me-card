import 'package:flutter/material.dart';
import 'package:posty/widgets/header.dart';
import 'package:posty/widgets/login_form.dart';
import 'package:posty/widgets/registeration_form.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _showLogin = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Header()),
                _showLogin ? const LoginForm() : const RegisterationForm(),
                const SizedBox(
                  height: 100,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _showLogin = !_showLogin;
                      });
                    },
                    child: Text(_showLogin
                        ? 'Don\'t have an account? Register'
                        : 'Already have an account? Login'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
