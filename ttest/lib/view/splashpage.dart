import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttest/model/config.dart';
import 'package:ttest/model/user.dart';
import 'package:ttest/view/mainpage.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    checkAndLogin();
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth * 0.85;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              child: Image.asset('assets/images/pasar.jpg'), width: resWidth),
          const CircularProgressIndicator(),
          Text(
            "Version 0.1",
            style: TextStyle(
                fontSize: resWidth * 0.05,
                //color: Colors.white,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Container(
    //         decoration: const BoxDecoration(
    //             image: DecorationImage(
    //                 image: AssetImage('assets/images/pasar.jpg'),
    //                 fit: BoxFit.cover))),
    //     Padding(
    //       padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: const [
    //           Text(
    //             "MY PASAR",
    //             style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    //           ),
    //           CircularProgressIndicator(),
    //           Text(
    //             "Version 0.1",
    //             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //           )
    //         ],
    //       ),
    //     )
    //   ],
    // );
  }

  checkAndLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    late User user;
    if (email.length > 1 && password.length > 1) {
      http.post(Uri.parse(Config.server + "/mypasar/php/login_user.php"),
          body: {"email": email, "password": password}).then((response) {
        print(response.body);
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200 && jsondata['status'] == 'success') {
          User user = User.fromJson(jsondata['data']);
          Timer(
              const Duration(seconds: 5),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainPage(user: user))));
        } else {
          user = User(
              id: "na",
              name: "na",
              email: "na",
              phone: "na",
              address: "na",
              regdate: "na",
              otp: "na");

          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainPage(user: user))));
        }
      }).timeout(const Duration(seconds: 5));
    } else {
      user = User(
          id: "na",
          name: "na",
          email: "na",
          phone: "na",
          address: "na",
          regdate: "na",
          otp: "na");
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => MainPage(user: user))));
    }
  }
}
