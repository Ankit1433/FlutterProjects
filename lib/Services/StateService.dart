import 'dart:convert';

import 'package:covideapp/Modal/WorldStatesModal.dart';
import 'package:covideapp/Services/Utilities/AppUrl.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../Modal/CountryStateModal.dart';


class StateService{
    Future<WorldStatesModal> fetchWorldStatesRecords() async{
      final response=await http.get(Uri.parse(AppUrl.worldStatesApi));
      if(response.statusCode==200){
        var data=jsonDecode(response.body);
        return WorldStatesModal.fromJson(data);
      }else{
        throw Exception("failed to fetch data");
      }
    }




    Future<List<dynamic>> fetchCountryListApi() async{
      var data ;
      final response=await http.get(Uri.parse(AppUrl.countriesList));
      if(response.statusCode==200){
         data = jsonDecode(response.body);
        return data;
      }
      else{
        throw Exception("failed to fetch country");
      }
    }
}
