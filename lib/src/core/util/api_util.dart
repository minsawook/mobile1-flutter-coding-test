import 'package:dio/dio.dart';
import 'package:mobile1_flutter_coding_test/src/core/common/exception/custom_exception.dart';

import 'logger_util.dart';

mixin ApiUtilMixin {
  ///Api통신 결과에 따른 결과괎 리턴
  Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      throw e.error ?? const UnknownException();
    } catch (e) {
      logger.e('An unexpected non-Dio error occurred in repository: $e');
      throw const UnknownException();
    }
  }
}
