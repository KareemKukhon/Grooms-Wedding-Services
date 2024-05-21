import 'package:Rafeed/apiServices/ShP.dart';
import 'package:Rafeed/apiServices/loginSignup.dart';
import 'package:Rafeed/screen/Login&Signup/login.dart';
import 'package:Rafeed/screen/bottomBarPages/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';




class AuthLoadingScreen extends StatefulWidget {
  @override
  _AuthLoadingScreenState createState() => _AuthLoadingScreenState();
}

class _AuthLoadingScreenState extends State<AuthLoadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkStoredCredentials(); // Ensure this runs after build phase
    });
  }

  Future<void> checkStoredCredentials() async {
    final token=ShP.shp.getValue("token");

    if (token != null) {
      final appProvider = Provider.of<LoginSignup>(context, listen: false);
      // appProvider.emailController.text = email;
      // appProvider.passwordController.text = password;

      final signInSuccess = await appProvider.signInBackground(token);

      if (signInSuccess==200) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomBar()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Login()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            width: 40.w, height: 40.h, child: CircularProgressIndicator()),
      ),
    );
  }
}
