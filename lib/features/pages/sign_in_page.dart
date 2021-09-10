import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getx/features/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) => _signInController.validateUsername(value),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Username',
                contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            TextFormField(
              validator: (value) => _signInController.validatePassword(value),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                focusColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
