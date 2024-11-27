// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void validatorSessions() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? username = _prefs.getString('username');

    if (username != null) {
      Navigator.pushNamed(context, 'principal');
    } else {
      Navigator.pushNamed(context, 'login');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validatorSessions();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
