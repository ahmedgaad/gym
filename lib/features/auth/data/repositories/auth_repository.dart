import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/core/errors/failures.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _usersSource = FirebaseFirestore.instance.collection("users");

  Future<Either<Failure, Unit>> createAccount({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    UserCredential userCreds;
    try {
      userCreds = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = userCreds.user!.uid;
      await _usersSource.doc(userId).set({
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": "$firstName $lastName",
      });
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "weak-password":
          return Left(
              ServerFailure("كلمة المرور ضعيفة. يرجى اختيار كلمة مرور أقوى."));
        case "email-already-in-use":
          return Left(ServerFailure("عنوان البريد الإلكتروني مستخدم بالفعل."));
        case "operation-not-allowed":
          return Left(
              ServerFailure("العملية غير مسموح بها. يرجى التواصل مع الدعم."));
        case "invalid-email":
          return Left(ServerFailure("عنوان البريد الإلكتروني غير صحيح."));
        case "network-request-failed":
          return Left(NoInternetFailure());
        default:
          return Left(ServerFailure("حدث خطأ أثناء إنشاء الحساب."));
      }
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure("حدث خطأ غير متوقع أثناء إنشاء الحساب."));
    }
  }

  Future<Either<Failure, Unit>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return Left(ServerFailure(
              "المستخدم غير موجود. الرجاء التحقق من البريد الإلكتروني."));
        case "wrong-password":
          return Left(ServerFailure(
              "كلمة المرور غير صحيحة. الرجاء المحاولة مرة أخرى."));
        case "network-request-failed":
          return Left(NoInternetFailure());
        default:
          return Left(ServerFailure("حدث خطأ أثناء تسجيل الدخول."));
      }
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure("حدث خطأ غير متوقع أثناء تسجيل الدخول."));
    }
  }
}
