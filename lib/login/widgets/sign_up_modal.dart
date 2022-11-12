import 'package:continual_care_alpha/log_flow/log_flow.dart';
import 'package:continual_care_alpha/login/login.dart';
import 'package:continual_care_alpha/sign_up/view/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> signUpModal(
  BuildContext context,
) async {
  return showDialog(
    context: context,
    builder: (newContext) {
      return AlertDialog(
        title: Text('Create Account',
            style: Theme.of(context).textTheme.headline1),
        content: Text('How would you like to sign up?'),
        actions: [
          TextButton(
            child: Text(
              'Email & Password',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(newContext);
              Navigator.of(context).push<void>(SignUpPage.route());
            },
          ),
          TextButton(
            child: Text(
              'Google',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(newContext);
              context.read<LoginCubit>().logInWithGoogle();
            },
          ),
        ],
      );
    },
  );
}
