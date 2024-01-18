import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import 'package:easy_localization/easy_localization.dart';

class ParseError extends Equatable {
  final String code;
  final String message;
  ParseError({
    required this.code,
    required this.message,
  });
  @override
  List<Object> get props => [code, message];

  static ParseError fromJson(dynamic error) {
    String code = '-1';
    String message = "key_unhandle_error".tr();
    try {
      DataError? dataError;
      if (error is CognitoClientException && error.code == 'NetworkError') {
        return ParseError(
          code: error.code.toString(),
          message: 'key_network_connect'.tr(),
        );
      } else if (error is PlatformException) {
        message = '${error.message}';
      } else if (error is DioError) {
        code = error.response!.statusCode.toString();
        if (error.response!.data is Map) {
          dataError = DataError.fromJson(error.response!.data);
          code = dataError.rCode;
          message = dataError.rMessage;
        } else {
          if (code == '503') {
            message = "key_service_503".tr();
          } else {
            message = error.message;
          }
        }
      } else {
        if (error is Map) {
          dataError = DataError.fromJson(error);
          code = dataError.rCode;
          message = dataError.rMessage;
        } else if (error is CognitoClientException?) {
          code = error!.code!;
          message = error.message!;
        } else {
          message = error.toString();
        }
      }
      return ParseError(
        code: code,
        message: message,
      );
    } catch (e) {
      return ParseError(code: code, message: message);
    }
  }
}

class DataError extends Equatable {
  final String rCode;
  final String rMessage;

  const DataError({required this.rCode, required this.rMessage});

  @override
  List<Object> get props => [rCode, rMessage];

  static DataError fromJson(dynamic json) {
    String detail = '';
    if (json['detail'] != null && json['detail'] is List) {
      detail = (json['detail'] as List)
          .reduce((value, element) => value + '\n' + element);
    }
    return DataError(
      rCode: "$json['statusCode']",
      rMessage:
          (json['message'] is List ? json['message'].first : json['message']) +
              '\n$detail',
    );
  }
}
