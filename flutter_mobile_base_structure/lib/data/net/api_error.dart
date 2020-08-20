import 'package:flutter_mobile_base_structure/core/error/exceptions.dart';

class ApiError extends RemoteException {
  ApiError({int httpStatusCode, String errorCode, String errorMessage})
      : super(
            httpStatusCode: httpStatusCode,
            errorCode: errorCode,
            errorMessage: errorMessage);

  factory ApiError.initCombine(int httpStatusCode, Map<String, dynamic> json) {
    final errorCode = json['errCode'];
    final errorMessage = json['message'];
    return ApiError(
        httpStatusCode: httpStatusCode,
        errorCode: errorCode,
        errorMessage: errorMessage);
  }
}
