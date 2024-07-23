// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_sense/src/config/constant/api_url.dart';

class Api {
  final _host = Constants.hostname;
  final _protocol = Constants.protocol;
  final stringToBase64Url = utf8.fuse(base64Url);

  Future<Map> requestPOST({required String? path, dynamic parameters}) async {
    bool chk = parameters!.containsKey("token");
    var headersData = _headers;
    dynamic res = jsonEncode(parameters);
    if (chk) {
      headersData['Authorization'] = 'Bearer ${parameters['token']}';
    }

    Uri uri;
    if (_protocol == "https") {
      uri = Uri.https(_host, path!);
    } else {
      uri = Uri.http(_host, path!);
    }

    final result = await http.post(uri, headers: headersData, body: res);

    if (result.body.isNotEmpty) {
      final jsonObject = json.decode(result.body);
      return jsonObject;
    } else {
      return {};
    }
  }

  Future<dynamic> requestGET(
      {required String path, Map<String, Object>? parameters}) async {
    bool chk = parameters!.containsKey('token');
    var headersData = _headers;
    if (chk) {
      headersData['Authorization'] = 'Bearer ${parameters['token']}';
    }
    dynamic uri;
    if (_protocol == 'https') {
      uri = Uri.https(_host, path, parameters);
    } else {
      uri = Uri.http(_host, path, parameters);
    }
    print(uri);
    final result = await http.get(uri, headers: headersData);
    print('Response status: ${result.statusCode}');
    if (result.body.isNotEmpty) {
      final jsonObject = json.decode(result.body);
      return jsonObject;
    } else {
      return {};
    }
  }

    Future<Map> requestPUT({
  required String? path,
  required Map<String, dynamic> fields,
  required List<http.MultipartFile> files,
}) async {
  bool chk = fields.containsKey("token");
  var headersData = _headers;

  if (chk) {
    headersData['Authorization'] = 'Bearer ${fields['token']}';
  }

  Uri uri;
  if (_protocol == 'https') {
    uri = Uri.https(_host, path!);
  } else {
    uri = Uri.http(_host, path!);
  }

  var request = http.MultipartRequest('PUT', uri);
  request.headers.addAll(headersData);

  // Adding fields
  fields.forEach((key, value) {
    request.fields[key] = value;
  });

  // Adding files
  request.files.addAll(files);

  // Sending request
  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  if (response.body.isNotEmpty) {
    final jsonObject = json.decode(response.body);
    return jsonObject;
  } else {
    return {'status': 'failure', 'message': 'empty response from server'};
  }
}




   Future<Map> requestPUTPass({
    required String? path,
    required Map<String, String> fields,
    required List<http.MultipartFile> files,
  }) async {
    bool chk = fields.containsKey("token");
    var headersData = _headers;
    if (chk) {
      headersData['Authorization'] = 'Bearer ${fields['token']}';
    }

    Uri uri;
    if (_protocol == 'https') {
      uri = Uri.https(_host, path!);
    } else {
      uri = Uri.http(_host, path!);
    }

    var request = http.MultipartRequest('PUT', uri);
    request.headers.addAll(headersData);

    // Adding fields
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // Adding files
    request.files.addAll(files);

    // Sending request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.body.isNotEmpty) {
      final jsonObject = json.decode(response.body);
      return jsonObject;
    } else {
      return {'status':'failure','message': 'empty response from server'};
    }
  }

  dynamic stringToBase64(data) {
    return stringToBase64Url.decode(data);
  }

  Map<String, String> get _headers => {
        'Accept': 'application/json, text/plain',
        "Content-Type": "application/json"
      };

 
}
