import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotesfahmed/firebase_options.dart';
import 'package:mynotesfahmed/view/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Home Page'),
        ),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                var user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified??false) {
                  print('User is verified');
                } else {
                  print('User is not verified');
                }
                return const Center(
                  child: Text('Welcome to the home page'),
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
          );
        },
        child: const Icon(Icons.login),
      ),
    );
  }
}
