import 'package:flutter/material.dart';
import 'package:gym/core/extensions/sized_box.dart';
import 'package:gym/core/widgets/custom_form_filed.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.formKey,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _firstNameController = firstNameController,
        _lastNameController = lastNameController,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> formKey;
  final TextEditingController _firstNameController;
  final TextEditingController _lastNameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextFormFiled(
                  controller: _firstNameController,
                  insertTitle: true,
                  title: 'First Name',
                  keyboardType: TextInputType.text,
                  prefixIC: const Icon(Icons.person),
                ),
              ),
              5.pw,
              Expanded(
                child: CustomTextFormFiled(
                  controller: _lastNameController,
                  insertTitle: true,
                  title: 'Last Name',
                  keyboardType: TextInputType.text,
                  prefixIC: const Icon(Icons.person),
                ),
              ),
            ],
          ),
          16.ph,
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
