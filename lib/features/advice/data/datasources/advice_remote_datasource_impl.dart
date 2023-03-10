import 'dart:convert';

import 'package:teste_iatec/core/error/exceptions.dart';
import 'package:teste_iatec/features/advice/data/datasources/advice_remote_datasource.dart';
import 'package:teste_iatec/features/advice/data/models/advice_model.dart';
import 'package:teste_iatec/features/advice/domain/entities/advice.dart';
import 'package:http/http.dart' as http;

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final http.Client client;

  AdviceRemoteDataSourceImpl({required this.client});

  @override
  Future<Advice>? getAdvice() async {
    final response = await client.get(
      Uri.parse('https://api.adviceslip.com/advice'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return AdviceModel.fromJson(jsonMap['slip']);
    } else {
      throw ServerException();
    }
  }
}
