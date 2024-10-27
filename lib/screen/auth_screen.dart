import 'dart:io';

import 'package:group_chat/widget/authform.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isLoading = false;
  @override
  void initState() {
    final fcm = FirebaseMessaging.instance;
    super.initState();
  }

  void _submitForm(
    String uname,
    String email,
    String password,
    File? imageUpload,
    bool islogin,
    BuildContext context,
  ) async {
    setState(() {
      isLoading = true;
    });
    try {
      if (islogin) {
        final authInstance = FirebaseAuth.instance;
        var sampleUsre = await authInstance.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        if (imageUpload == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'please take a photo',
                style: TextStyle(color: Colors.red),
              ),
              backgroundColor: Colors.white,
            ),
          );
          isLoading = false;
          return;
        }
        final respoonse = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${respoonse.user!.uid}.jpg');
        await ref.putFile(imageUpload);
        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(respoonse.user?.uid)
            .set(
          {
            'username': uname,
            'email': email,
            'image_url': url,
          },
        );
      }

      setState(() {
        isLoading = false;
      });
    } on PlatformException catch (e) {
      var message = 'an error occured , please check your credentials';
      if (e.message != null) {
        message = e.message!;
        setState(() {
          isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ),
      );
    } catch (er) {
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: AuthForm(_submitForm, isLoading),
    );
  }
}
