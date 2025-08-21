import 'package:flutter/material.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/features/authentication/screens/login/widgets/login_header.dart';
import 'package:dashboard/features/authentication/screens/login/widgets/login_form.dart';

class LoginScreenMobile extends StatelessWidget {
  const LoginScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Header
              TLoginHeader(),

              // Form
              TLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
