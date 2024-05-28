import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotesfahmed/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Register';
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(title),
          ),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                        controller: _email,
                        textAlign: TextAlign.justify,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                        )),
                    TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter your password',
                        )),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          //print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            //print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            //print('The account already exists for that email.');
                          }
                        } catch (e) {
                          //print(e);
                        }
                      },
                      child: const Text(title),
                    ),
                  ],
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ));
  }
}
