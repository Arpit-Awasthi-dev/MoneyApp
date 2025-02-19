import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final InterceptedClient client;
  final String baseUrl;

  ApiService({
    required this.client,
    required this.baseUrl,
  });

  Future<dynamic> get(
    String endpoint, {
    Map<String, String?>? queryParams,
    Map<String, String>? additionalHeaders,
  }) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(baseUrl, '/$endpoint', queryParams);
      final response = await client.get(uri, headers: additionalHeaders);
      responseJson = _response(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> post(
    String endpoint,
    Map<String, String?> params,
  ) async {
    dynamic responseJson;
    try {
      final uri = Uri.https(baseUrl, '/$endpoint');
      final response = await client.post(uri, body: params);
      print(response.request.toString());
      responseJson = _response(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok: //200
        var responseJson = json.decode(response.body);
        return responseJson;

      case HttpStatus.created: //201
        var responseJson = json.decode(response.body);
        return responseJson;

      case HttpStatus.badRequest:
        var responseJson = json.decode(response.body) as Map<String, dynamic>;
        throw ApiException(responseJson['message']);

      case HttpStatus.unprocessableEntity: //422
        var responseJson = json.decode(response.body) as Map<String, dynamic>;
        final listOfErrors = responseJson['errors'] as Map<String, dynamic>;
        var buffer = StringBuffer();
        listOfErrors.forEach((key, value) {
          final result = value as List;
          for (int i = 0; i < result.length; i++) {
            final element = result[i];
            buffer.write(element);
          }
        });
        throw ApiException(buffer.toString());

      default:
        {
          var responseJson = json.decode(response.body) as Map<String, dynamic>;
          throw ApiException(responseJson['message']);
        }
    }
  }
}

class ApiException implements Exception {
  final String message;

  ApiException(this.message);
}
