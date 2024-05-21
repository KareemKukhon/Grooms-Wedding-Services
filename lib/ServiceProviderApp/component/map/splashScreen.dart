import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/loadingScreen.dart';
import 'package:rafeed_provider/ServiceProviderApp/component/map/mapPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((_) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MapPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(),
    );
  }
}
