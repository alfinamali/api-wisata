import 'package:flutter/material.dart';
import 'package:SM1/Screens/login_screen.dart';
import 'package:SM1/Screens/register_screen.dart';
import 'package:SM1/Services/favoriteproviders.dart';
import 'package:SM1/pages/home.dart';
import 'package:SM1/pages/profil.dart';
import 'package:SM1/pages/started.dart';
import 'package:SM1/pages/favorit.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TriSum',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const StartedPage(),
          '/home': (context) => HomePage(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterPage(),
          '/profile': (context) => ProfilePage(),
          '/favorite': (context) => FavoritePage(),
        },
      ),
    );
  }
}
