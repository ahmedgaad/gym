import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/core/extensions/sized_box.dart';
import 'package:gym/core/utils/colors.dart';
import 'package:gym/core/utils/svg.dart';
import 'package:gym/core/widgets/custom_elevated_btn.dart';
import 'package:gym/features/auth/presentation/components/loading_dialog.dart';
import 'package:gym/features/auth/presentation/components/register_form.dart';
import 'package:gym/features/auth/presentation/controller/auth_cubit.dart';
import 'package:gym/features/auth/presentation/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    SvgUtils.register,
                    width: MediaQuery.sizeOf(context).width * .75,
                    height: MediaQuery.sizeOf(context).height * .25,
                  ),
                  25.ph,
                  RegisterForm(
                      formKey: formKey,
                      firstNameController: _firstNameController,
                      lastNameController: _lastNameController,
                      emailController: _emailController,
                      passwordController: _passwordController),
                  24.ph,
                  BlocConsumer<AuthCubit, AuthStates>(
                      listener: (context, state) {
                    if (state is RegisterLoadingState) {
                      loadingDialog(context);
                    } else if (state is RegisterFailureState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else if (state is RegisterSuccessState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('🎉تم التسجيل بنجاح'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 3), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      });
                    }
                  }, builder: (context, state) {
                    return CustomElvatedButton(
                      title: 'Register',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthCubit.get(context).register(
                            email: _emailController.text,
                            password: _passwordController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                          );
                        }
                      },
                    );
                  }),
                  10.ph,
                  Align(
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Already A Member? ',
                            style: TextStyle(
                                color: ColorUtils.grey4A, fontSize: 16.sp),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                            text: 'Login',
                            style: TextStyle(
                                color: ColorUtils.primary, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
