import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:main_project/domain/model/product_model.dart';

Future<List<ProductModel>> takingAllProductFromApi() async {
  String url = 'https://fakestoreapi.com/products';
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final List<dynamic> val = jsonDecode(response.body);
    var data = val.map((e) => ProductModel.fromMap(e)).toList();
    return data;
  }
  else{
    return [];
  }
}

  //  'email' : 'eve.holt@reqres.in',
  //       'password' : 'pistol'

loginChecking(String email,String pass)async{
  Future.delayed(const Duration(seconds: 10),(){
    return false;
  });
  Response responsee = await post(
      Uri.parse('https://reqres.in/api/login'),
      body: {
        'email' : email,
        'password' : pass
      }
    );
    return responsee.statusCode==200 ? true : false;
}
