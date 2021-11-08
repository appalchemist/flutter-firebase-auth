import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:sincerely/auth/auth.dart';
import 'package:sincerely/helper.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final size = query.size;
    final itemWidth = size.width * 0.8;
    final itemHeight = itemWidth * (size.width / size.height);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Sign up',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/sincerely-logo.png',
                  width: itemWidth,
                  height: itemHeight,
                ),
              ),
            ),
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Email'),
                                controller: emailTextController),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Password'),
                                controller: passwordTextController),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                enableSuggestions: false,
                                autocorrect: false,
                                obscureText: true,
                                style: TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    hintText: 'Confirm Password'),
                                controller: confirmPasswordTextController),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 60,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 6.0,
                          primary: Colors.blueAccent, // background
                          onPrimary: Colors.white, // foreground
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(color: Colors.blueAccent)),
                        ),
                        onPressed: () async {
                          String email = emailTextController.text.trim();
                          String pass = passwordTextController.text.trim();
                          String confirmPass =
                              confirmPasswordTextController.text.trim();

                          if (pass != confirmPass) {
                            showSnackbar(context, 'Passwords do not match.');
                            return;
                          }

                          final result = await context
                              .read<AuthenticationService>()
                              .signUp(
                                email: email,
                                password: pass,
                              );

                          showSnackbar(context, result);

                          if (result == "Signed up") {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/auth'));
                          }
                        },
                        child: Text('Create Account',
                            style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/signin'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          Text(
                            'Sign in.',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        )
    );
  }
}
