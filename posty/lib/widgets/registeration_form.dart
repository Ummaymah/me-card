import 'package:another_flushbar/flushbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posty/screens/manage_posts_screen.dart';

class RegisterationForm extends StatefulWidget {
  const RegisterationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterationForm> createState() => _RegisterationFormState();
}

class _RegisterationFormState extends State<RegisterationForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  registerUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _auth.currentUser?.updateDisplayName(_displayNameController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        FlushbarHelper.createError(
          message: 'The password provided is too weak.',
          title: 'Weak Password',
        ).show(context);
        return;
      } else if (e.code == 'email-already-in-use') {
        FlushbarHelper.createError(
          message: 'The account already exists for that email.',
          title: 'Email already in use',
        ).show(context);
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  _submit() async {
    setState(() => _isLoading = true);
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      await registerUser(
          email: _emailController.text, password: _passwordController.text);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (_) => ManagePostsScreen(),
        ),
      );
    }
  }

  bool _showPassword = false;
  bool _isLoading = false;
  togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Form(
        key: _formkey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Register',
              style: GoogleFonts.montserrat(
                  fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _displayNameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your fullname';
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                label: const Text('Full name'),
                hintText: 'Mona Shanahan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please provide a valid email';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_rounded),
                label: const Text('Email'),
                hintText: 'kimtaehyungismybias@army.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: _showPassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password_outlined),
                suffixIcon: IconButton(
                  onPressed: () => togglePasswordVisibility(),
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                label: const Text('Password'),
                hintText: '**************',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _isLoading
                ? const LinearProgressIndicator(minHeight: 50)
                : ElevatedButton(
                    onPressed: _submit, child: const Text('Register'))
          ],
        ),
      ),
    );
  }
}
