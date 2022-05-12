import 'package:flutter/material.dart';
import 'package:map_proj/view/dashboard.dart';
import 'package:map_proj/view/dashboard_member.dart';
import 'package:map_proj/view/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Mynda",
                      style: TextStyle(
                        color: Color.fromARGB(255, 16, 100, 168),
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                        height: 200,
                        child: Image.asset(
                          "assets/landing.png",
                          fit: BoxFit.contain,
                        )),
                  ],
                ),
                flex: 3,
              ),
              Expanded(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 32.0),
                      color: Colors.blue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Text(
                        'Enter',
                        style: TextStyle(fontSize: 30),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardScreen()));
                        // builder: (context) =>
                        //     const DashboardScreenMember()));
                        // builder: (context) => const DashboardScreen()));
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      'Sign-in as a User/Staff',
                      style: TextStyle(
                          color: Color(0xFF0069FE),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
