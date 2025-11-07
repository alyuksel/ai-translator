import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/translation.dart';

class TranslatorApi {
  TranslatorApi({
    this.baseUrl = 'http://127.0.0.1:8000',
    http.Client? client,
  }) : _client = client ?? http.Client();

  final String baseUrl;
  final http.Client _client;

  Uri get _translateUri => Uri.parse('$baseUrl/translate');

  Future<TranslationResponse> translate(TranslationRequest request) async {
    final response = await _client.post(
      _translateUri,
      headers: const <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 200) {
      throw TranslatorApiException(
        statusCode: response.statusCode,
        body: response.body,
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return TranslationResponse.fromJson(json);
  }

  void close() {
    _client.close();
  }
}

class TranslatorApiException implements Exception {
  TranslatorApiException({
    required this.statusCode,
    required this.body,
  });

  final int statusCode;
  final String body;

  @override
  String toString() {
    return 'TranslatorApiException(statusCode: $statusCode, body: $body)';
  }
}
