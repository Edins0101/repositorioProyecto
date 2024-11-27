import 'package:flutter/material.dart';
import 'package:yesnoapp/config/theme/app_theme.dart';
import 'package:yesnoapp/models/Carrito.dart';
import 'package:yesnoapp/presentation/CarritoScreen.dart';
import 'package:yesnoapp/presentation/LoginScreen.dart';
import 'package:yesnoapp/presentation/PrincipalScreen.dart';
import 'package:yesnoapp/presentation/ProductoScreen.dart';
import 'package:yesnoapp/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) =>Carrito(),
    child: MyApp(),
  )
);

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yes No App ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).theme(),
      initialRoute: 'splash',
      routes: {
         'splash' : (BuildContext context) => const SplashScreen(),
         'principal' : (BuildContext context) => const PrincipalScreen(),
         'login' : (BuildContext context) => const LoginScreen(),
         'productos' :(BuildContext context) => const ProductoScreen(),
         'carrito' : (BuildContext context) => const CarritoScreen(),
      }
       
      ,
      home: const SplashScreen(),
    );
  }
}