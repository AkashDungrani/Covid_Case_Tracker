import 'dart:convert';

import 'package:covid_details/models/covid.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();
  static final ApiHelper apiHelper = ApiHelper._();
  Future<List<CovidData>?> fetchCoviData() async {
    String api = "https://disease.sh/v3/covid-19/countries";
    http.Response res = await http.get(Uri.parse(api));
    List<dynamic> a = [];
    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body);

      List<CovidData> covidData = decodedData.map((e) {
        return CovidData.fromJson(data: e);
      }).toList();
      return covidData;
    }
    return null;
  
  
  }
}
