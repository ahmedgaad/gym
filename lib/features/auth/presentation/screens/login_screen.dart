import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym/core/extensions/sized_box.dart';
import 'package:gym/core/utils/colors.dart';
import 'package:gym/core/utils/svg.dart';
import 'package:gym/core/widgets/custom_elevated_btn.dart';
import 'package:gym/features/auth/presentation/components/loading_dialog.dart';
import 'package:gym/features/auth/presentation/components/sign_in_form.dart';
import 'package:gym/features/auth/presentation/controller/auth_cubit.dart';
import 'package:gym/features/auth/presentation/screens/register_screen.dart';
import 'package:gym/features/exercises/presentation/screens/home_screen.dart'; 

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  SvgUtils.login,
                  width: MediaQuery.sizeOf(context).width * .75,
                  height: MediaQuery.sizeOf(context).height * .25,
                ),
                25.ph,
                SignInForm(
                  formKey: formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                24.ph,
                BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, state) {
                    if (state is LoginLoadingState) {
                      loadingDialog(context);
                    } else if (state is LoginFailureState) {
                      Navigator.of(context, rootNavigator: true).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(state.error),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } else if (state is LoginSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false);
                    }
                  },
                  builder: (context, state) {
                    return CustomElvatedButton(
                      title: 'Login',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthCubit.get(context).login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),
                10.ph,
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'New Member? ',
                          style: TextStyle(
                              color: ColorUtils.grey4A, fontSize: 16.sp),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    const RegisterScreen(),
                                transitionDuration:
                                    const Duration(milliseconds: 850),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                              ));
                            },
                          text: 'Create New Account',
                          style: TextStyle(
                              color: ColorUtils.primary, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
