import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('Full Name :- ${widget.credential.user!.displayName}'),
            Text('Email :- ${widget.credential.user!.email}'),
            Text('Email verified :- ${widget.credential.user!.emailVerified}'),
            Text('Phone number :- ${widget.credential.user!.phoneNumber}'),
            Text('Photo URL :- ${widget.credential.user!.photoURL}'),
            CachedNetworkImage(
              height: 200,
              width: 200,
              filterQuality: FilterQuality.high,
              imageUrl: widget.credential.user!.photoURL.toString(),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(
                'Creation Time :- ${widget.credential.user!.metadata.creationTime}'),
            Text('isAnonymous:- ${widget.credential.user!.isAnonymous}'),
          ],
        ),
      ),
    );
  }
}
