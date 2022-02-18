import 'package:another_flushbar/flushbar_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:posty/screens/manage_posts_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (_) => ManagePostsScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        FlushbarHelper.createError(
          message: 'Invalid email.',
          title: 'error',
        ).show(context);
        return;
      } else if (e.code == 'wrong-password') {
        FlushbarHelper.createError(
          message: 'Wrong password ',
          title: 'wrong password',
        ).show(context);
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  _submit() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      await loginUser(
          email: _emailController.text, password: _passwordController.text);
    }
  }

  bool _showPassword = false;
  bool _isLoading = false;

  togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
      _isLoading = !_isLoading;
    });
  }

  sendPasswordResetLink() async {
    await _auth.sendPasswordResetEmail(email: _emailController.text);
  }

  signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      // Create a new credential.
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase with the Google [UserCredential].
      final UserCredential googleUserCredential =
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (_) => ManagePostsScreen(),
        ),
      );
    } catch (e) {
      FlushbarHelper.createError(message: 'An error occurred. Try again');
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: GoogleFonts.montserrat(
                  fontSize: 32, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _emailController,
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return Center(
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(20),
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: Material(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Reset Password',
                                    style: GoogleFonts.berkshireSwash(
                                        fontSize: 22),
                                  ),
                                  TextField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your email',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: sendPasswordResetLink,
                                    child: const Text('Reset Password'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.berkshireSwash(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _isLoading
                ? const LinearProgressIndicator(minHeight: 50)
                : Center(
                    child: ElevatedButton.icon(
                        onPressed: _submit,
                        icon: const Icon(Icons.email),
                        label: Text(
                          'Sign In',
                          style: GoogleFonts.montserrat(),
                        )),
                  ),
            const SizedBox(
              height: 10,
            ),
            _isLoading
                ? SizedBox.shrink()
                : Center(
                    child: ElevatedButton.icon(
                        onPressed: () {
                          _isLoading = true;
                          signInWithGoogle();
                        },
                        icon: const Icon(Icons.email),
                        label: Text(
                          'Sign In With Google',
                          style: GoogleFonts.montserrat(),
                        )),
                  )
          ],
        ),
      ),
    );
  }
}
