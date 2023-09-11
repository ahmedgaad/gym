import 'package:dio/dio.dart';
import 'package:gym/core/errors/failures.dart';

handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      throw ServerFailure("تأكد من اتصالك بالانترنت");
    case DioExceptionType.badResponse:
      throw handleStatusCode(error.response?.statusCode);
    case DioExceptionType.cancel:
      break;
    case DioExceptionType.unknown:
    default:
      throw ServerFailure("حدث خطأ حاول مرة اخري");
  }
}

String handleStatusCode(int? statusCode) {
  switch (statusCode) {
    case 400:
      throw ServerFailure('حدث طلب غير صحيح.');
    case 401:
    case 403:
      throw ServerFailure('تم رفض الوصول غير المصرح به.');
    case 404:
      throw ServerFailure('الوصول إلى الموارد ممنوع.');
    case 409:
      throw ServerFailure('الموارد المطلوبة غير موجودة.');
    default:
      throw ServerFailure('عذرًا، حدث خطأ ما!');
  }
}
