import 'dart:async';
import 'package:flutter_mobile_base_structure/core/error/exceptions.dart';
import 'package:flutter_mobile_base_structure/core/error/failures.dart';
import 'package:flutter_mobile_base_structure/core/network/network_status.dart';

import 'api_endpoint_input.dart';
import 'dart:convert' as convert;
import 'dart:io';
import 'api_error.dart';
import 'package:dio/dio.dart';

abstract class ApiConfig {
  String baseUrl;
  int connectTimeout;
  int receiveTimeout;
}

class ApiConnection {
  ApiConfig _apiConfig;
  NetworkStatus networkStatus;

  ApiConnection(this._apiConfig, {this.networkStatus});

  Future<dynamic> execute(ApiInput input) async {
    print('execute');

    Future<Response> future;
    final isConnected = await this.networkStatus?.isConnected ?? true;
    if (!isConnected) {
      throw (RemoteException(errorMessage: INTERNET_ERROR_MESSAGE));
    }
    switch (input.method) {
      case ApiMethod.get:
        future = _get(input);
        break;
      case ApiMethod.post:
        future = _post(input);
        break;
      case ApiMethod.delete:
        future = _delete(input);
        break;
      case ApiMethod.put:
        future = _put(input);
        break;
    }
    return future.then(_parseResponse).catchError((_handleError));
  }

  _handleError(error) {
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.RESPONSE:
          throw ApiError.initCombine(error.response.statusCode,
              _convertToJsonIfNeeds(error.response.data));
          break;
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          throw ApiError(
              httpStatusCode: 404,
              errorCode: TIMEOUT_EXCEPTION,
              errorMessage: SERVER_ERROR_MESSAGE);
          break;
        case DioErrorType.CANCEL:
        case DioErrorType.DEFAULT:
          if (error.error is SocketException) {
            throw ApiError(
                httpStatusCode: 0,
                errorCode: SOCKET_EXCEPTION,
                errorMessage: SOCKET_ERROR_MESSAGE);
          } else {
            throw ApiError(
                httpStatusCode: 0,
                errorCode: UNKNOWN_EXCEPTION,
                errorMessage: UNKNOWN_ERROR_MESSAGE);
          }
          break;
      }
    } else {
      throw error;
    }
  }

  Future<dynamic> _parseResponse(Response response) async {
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      return response.data;
    } else {
      throw ApiError.initCombine(response.statusCode, response.data);
    }
  }

  Future<Response> _get(ApiInput input) async {
    return _httpClient(input).get(input.endPoint);
  }

  Future<Response> _post(ApiInput input) async {
    return _httpClient(input).post(input.endPoint, data: input.body);
  }

  Future<Response> _put(ApiInput input) async {
    return _httpClient(input).put(input.endPoint, data: input.body);
  }

  Future<Response> _delete(ApiInput input) async {
    return _httpClient(input).delete(input.endPoint, data: input.body);
  }

  Dio _httpClient(ApiInput input) {
    var options = BaseOptions(
        baseUrl: _apiConfig.baseUrl,
        connectTimeout: _apiConfig.connectTimeout,
        receiveTimeout: _apiConfig.receiveTimeout,
        headers: input.header);
    return Dio(options);
  }

  Map<String, dynamic> _convertToJsonIfNeeds(dynamic data) {
    if (data is String) {
      return convert.json.decode(data);
    }
    return data;
  }
}
