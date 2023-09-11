import 'package:flutter/material.dart';
import 'package:gym/core/extensions/sized_box.dart';
import 'package:gym/core/widgets/custom_form_filed.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    super.key,
    required this.formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormFiled(
            controller: _emailController,
            insertTitle: true,
            title: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIC: const Icon(Icons.email),
          ),
          16.ph,
          CustomTextFormFiled(
            controller: _passwordController,
            insertTitle: true,
            title: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            prefixIC: const Icon(Icons.lock),
          ),
        ],
      ),
    );
  }
}
