//import 'dart:convert';
//import 'dart:developer';
//
//import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:sigv4/sigv4.dart';
//
////Code that interacts with Lex bot
//
//class BotService {
//  Map<String,dynamic> result;
//  String botName= "<NAME_OF_BOT>";
//  String kAccessKeyId = '<ACCESS_KEY>';
//  String kSecretAccessKey = '<SECRET_ACCESS_KEY>';
//  String botAlias= "<BOT_ALIAS>";
//  String botAWSRegion= "<AWS_LEX_REGION>";
//
//  String requestUrl= "https://runtime.lex."+botAWSRegion+".amazonaws.com/bot/"+botName+"/alias/"+botAlias+"/user/1234/text";
//
//  Future<Map<String,dynamic>> callBot(String message) async {
//    var response;
//
//    Sigv4Client client = Sigv4Client(
//      region: botAWSRegion,
//      serviceName: 'lex',
//      defaultContentType: 'application/json; charset=utf-8',
//      keyId: kAccessKeyId,
//      accessKey: kSecretAccessKey,
//    );
//
//    final request = client.request(
//      requestUrl,
//      method: 'POST',
//      body: jsonEncode({'inputText': message}),
//    );
//
//    response = await http.post(request.url,
//        headers: request.headers, body: request.body);
//    result = jsonDecode(response.body);
//    return result;
//  }
//}