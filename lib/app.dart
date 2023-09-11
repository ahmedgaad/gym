import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/core/services/di.dart';
import 'package:gym/core/utils/colors.dart';
import 'package:gym/features/auth/presentation/controller/auth_cubit.dart';
import 'package:gym/features/auth/presentation/screens/login_screen.dart';
import 'package:gym/features/exercises/presentation/screens/home_screen.dart';

class GymApp extends StatefulWidget {
  const GymApp({super.key});

  @override
  State<GymApp> createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: MaterialColor(
              ColorUtils.primary.value,
              <int, Color>{
                50: ColorUtils.primary.withOpacity(0.1),
                100: ColorUtils.primary.withOpacity(0.2),
                200: ColorUtils.primary.withOpacity(0.3),
                300: ColorUtils.primary.withOpacity(0.4),
                400: ColorUtils.primary.withOpacity(0.5),
                500: ColorUtils.primary.withOpacity(0.6),
                600: ColorUtils.primary.withOpacity(0.7),
                700: ColorUtils.primary.withOpacity(0.8),
                800: ColorUtils.primary.withOpacity(0.9),
                900: ColorUtils.primary.withOpacity(1.0),
              },
            ),
            primaryColor: ColorUtils.primary,
            fontFamily: GoogleFonts.poppins().fontFamily,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
          ),
          home: FirebaseAuth.instance.currentUser != null
              ? const HomeScreen()
              : const LoginScreen(),
        ),
      ),
    );
  }
}
