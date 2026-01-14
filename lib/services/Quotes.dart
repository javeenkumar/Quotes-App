import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quotes_app/services/models/QuotesModel.dart';

import '../main.dart';

class Quotes{
  Future<QuotesModel?> getQuotes()async{
    final response =await http.get(Uri.parse('https://api.api-ninjas.com/v1/quotes'),
      headers: {
      'X-Api-Key' : apiKey.toString(),
      },
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print('_______>>>> $data');
      return QuotesModel.fromJson(data[0]);

    } else {
      throw Exception('Failed to load data');
    }
  }
}