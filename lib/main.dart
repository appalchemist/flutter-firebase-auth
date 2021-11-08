import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sincerely/auth/auth.dart';

import 'package:sincerely/auth/signin.dart';
import 'package:sincerely/auth/signup.dart';
import 'package:sincerely/home/home.dart';
import 'package:sincerely/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Requires that the Firebase Auth emulator is running locally
  /// e.g via `melos run firebase:emulator`.
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 2
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        // 3
        StreamProvider(
          create: (context) =>
          context
              .read<AuthenticationService>()
              .authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Colors.deepPurpleAccent,
            primaryColorDark: Colors.deepPurple,
            accentColor: Colors.blueAccent,
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white54),
            ),
            scaffoldBackgroundColor: Color.fromARGB(255, 185, 159, 255),
            pageTransitionsTheme: PageTransitionsTheme(builders: {TargetPlatform.android: CupertinoPageTransitionsBuilder(),}),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/auth': (context) => AuthenticationWrapper(),
          '/signin': (context) => SignIn(),
          '/signup': (context) => SignUp(),
          '/home': (context) => Home(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      return Home();
    }
    return SignIn();
  }
}