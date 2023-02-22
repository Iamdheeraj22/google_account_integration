import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_account_integration/google_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileInfoScreen extends StatefulWidget {
  UserCredential credential;
  ProfileInfoScreen({
    Key? key,
    required this.credential,
  }) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Card(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
                      filterQuality: FilterQuality.high,
                      imageUrl: widget.credential.user!.photoURL.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' ${widget.credential.user!.displayName!.toUpperCase()}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Card(
                          child: TextFormField(
                            enabled: false,
                            initialValue: widget.credential.user!.email,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Email verified',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Switch(
                                value: widget.credential.user!.emailVerified,
                                onChanged: (v) {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Card(
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () {
                        log(widget
                            .credential.additionalUserInfo!.profile!['iss']
                            .toString());

                        _launchUrl(Uri.parse(widget
                            .credential.additionalUserInfo!.profile!['iss']));
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 13, horizontal: 40),
                        child: Text(
                          'Help Account',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.redAccent,
                    child: InkWell(
                      onTap: () {
                        signOutGoogle(context);
                      },
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 13, horizontal: 40),
                        child: Text(
                          'Logout Account',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
