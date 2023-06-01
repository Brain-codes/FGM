// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, prefer_const_constructors, unused_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:FGM/shared/components/snackbar/snack_bar.dart';
import 'package:FGM/shared/interceptor/auth_interceptor.dart';
import 'package:FGM/shared/model/base_api_response.dart';
import 'package:FGM/shared/services/local_database_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class ApiService {
  final http.Client _httpClient = http.Client();
  static const int _timeoutDuration = 30;

  static final client = InterceptedClient.build(
      interceptors: [AuthorizationInterceptor()],
      retryPolicy: ExpiredTokenRetryPolicy());

  Map<String, String>? userAuthorizationJson() {
    String _token = '';
    _token = LocalDatabaseService().getData(DbKeyStrings.loginToken).toString();
    var _headers = {
      'Authorization': 'Bearer $_token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    return _headers;
  }

  Future<BaseApiResponse> get(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    final _headers = ApiService().userAuthorizationJson();

    if (queryParams != null) {
      url += '?' + Uri(queryParameters: queryParams).query;
    }
    print(url);
    final response = await client
        .get(
          Uri.parse(url),
          headers: _headers,
        )
        .timeout(
          Duration(seconds: _timeoutDuration),
        );
    return _handleResponse(response);
  }

  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<BaseApiResponse> post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? queryParams}) async {
    final _headers = ApiService().userAuthorizationJson();
    if (queryParams != null) {
      url += '?' + Uri(queryParameters: queryParams).query;
    }
    print(url);
    if (body != null) {
      String jsonBody = jsonEncode(body);
      final response = await client
          .post(Uri.parse(url), headers: _headers, body: jsonBody)
          .timeout(Duration(seconds: _timeoutDuration));
      print(response.body);
      print(response.statusCode);

      return _handleResponse(response);
    }

    final response = await client
        .post(Uri.parse(url), headers: _headers)
        .timeout(Duration(seconds: _timeoutDuration));
    return _handleResponse(response);
  }

  Future<BaseApiResponse> put(String url, Map<String, dynamic> body) async {
    final _headers = ApiService().userAuthorizationJson();

    final response = await client
        .put(Uri.parse(url), body: jsonEncode(body), headers: _headers)
        .timeout(Duration(seconds: _timeoutDuration));
    return _handleResponse(response);
  }

  Future<BaseApiResponse> delete(String url) async {
    final _headers = ApiService().userAuthorizationJson();

    final response = await client
        .delete(Uri.parse(url), headers: _headers)
        .timeout(Duration(seconds: _timeoutDuration));
    return _handleResponse(response);
  }

  Future<BaseApiResponse> sendFile(
    String url,
    File file,
    String fileType,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.fields['fileType'] = fileType;
    final response = await request.send();
    return _handleResponse((await http.Response.fromStream(response)));
  }

  dynamic _handleResponse(http.Response response) {
    try {
      final decodedBody = json.decode(response.body);
      print(decodedBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return BaseApiResponse(
          code: response.statusCode,
          success: decodedBody['success'],
          message: decodedBody['message'] ?? '',
          data: decodedBody['data'],
        );
      } else {
        errorSnackBar('Error', decodedBody['message'] ?? 'An error occurred');
        return BaseApiResponse(
          code: response.statusCode,
          success: decodedBody['success'],
          message: decodedBody['message'] ?? '',
          data: decodedBody['body'],
        );
      }
    } on TimeoutException {
      errorSnackBar('Error', 'time out ');
      print('EFE TIMEOUT');
      return BaseApiResponse(
        code: response.statusCode,
        success: false,
        message: 'unexpected error occurred',
        data: null,
      );
    } on SocketException {
      errorSnackBar(
          'Unstable Network', 'it Looks like you internet connection is bad.');
      return BaseApiResponse(
        code: response.statusCode,
        success: false,
        message: 'unexpected error occurred',
        data: null,
      );
    } catch (e) {
      errorSnackBar('Error', 'Oops, unexpected error occurred');
      return BaseApiResponse(
        success: false,
        code: response.statusCode,
        message: 'unexpected error occurred',
        data: null,
      );
    }
  }
}
