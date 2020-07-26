
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SalonService
{
  String serverUrl = "https://api.beehair.vn/";
  var status ;
  var res;

  Future<List> getData() async{

    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;

    String myUrl = "$serverUrl/branch_salons?page=1";
    http.Response response = await http.get(myUrl,
        headers: {
          'Accept':'application/json',
          'Authorization' : 'Bearer $value'
        });
    res = json.decode(response.body);
    return res['data']['data'];
  }


}
