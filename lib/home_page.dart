import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_account_integration/google_service.dart';
import 'package:google_account_integration/profile_info.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                  onPressed: () async {
                    try {
                      var user = await signInWithGoogle();
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) =>
                                  ProfileInfoScreen(credential: user)));
                    } catch (e) {
                      log(e.toString());
                    }
                  },
                  child: const Text(
                    'Google',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
