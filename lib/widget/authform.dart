import 'dart:io';

import 'package:chatappudemy/widget/picker/image_pickerfile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  //
  AuthForm(this.submitform, this.isloading);
  final bool isloading;
  //
  final void Function(
    String uname,
    String email,
    String password,
    File? imageUpload,
    bool islogin,
    BuildContext context,
  ) submitform;

  @override
  State<AuthForm> createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {
  var _uname = '';
  var _password = '';
  var _email = '';
  File? imageUpload;

  bool isLogin = true;
  void setImageFile(File image) {
    imageUpload = image;
  }

  final globalKey = GlobalKey<FormState>();

  void _saveForm() {
    final isValid = globalKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid!) {
      globalKey.currentState?.save();
      FocusScope.of(context).unfocus();
      widget.submitform(
        _uname.trim(),
        _email.trim(),
        _password.trim(),
        imageUpload,
        isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!isLogin) ImageUserPicker(pickimagefun: setImageFile),
                  if (!isLogin)
                    TextFormField(
                      key: const ValueKey('uname'),
                      onSaved: (newValue) {
                        _uname = newValue!;
                      },
                      decoration: InputDecoration(labelText: 'username'),
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (va) {
                      if (va!.isEmpty || va.length < 4) {
                        return 'please enter at least  4 characters';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _email = newValue!;
                    },
                    decoration: InputDecoration(labelText: 'email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    onSaved: (newValue) {
                      _password = newValue!;
                    },
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'password'),
                  ),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: Text(isLogin ? 'sign In' : 'Sign Up'),
                    ),
                  if (!widget.isloading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(
                        isLogin
                            ? 'create new account'
                            : 'I already have an account',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
