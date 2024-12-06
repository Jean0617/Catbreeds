import 'dart:convert';

import 'package:catbreeds/models/cat_model.dart';
import 'package:catbreeds/services/enviroment.dart';
import 'package:http/http.dart' as http;

class ServicesApi {

  final String _url = Enviroment.url;
  final String _apiKey = Enviroment.apiKey;

  Future<Map> getCats(int page) async {

    try {

      final response = await http.get(Uri.parse('$_url/breeds?limit=10&page=$page'),
        headers: {
          'x-api-key': Enviroment.apiKey
        }
      );

      if (response.statusCode == 200) {
        
        final List<dynamic> data = jsonDecode(response.body);
        final List<CatModel> cats = data.map((item) => CatModel.fromJson(item)).toList();
        
        for (var cat in cats) {
          String urlImage = await getImageUrl(cat.reference_image_id);
          cat.urlImage = urlImage;
        }

        return {'status': response.statusCode, 'data': cats};

      }else{
        return {'status':response.statusCode,'msg':'Error al consultar.'};
      }
      
    } catch (e) {
       return {'status': 500, 'msg': e.toString()};
    }
  }

  Future<String> getImageUrl(String id) async {

    try {

      final response = await http.get(Uri.parse('$_url/images/$id'));

      if (response.statusCode == 200) {
        
        final Map data = jsonDecode(response.body);
        return data['url'];

      }else{
        return '';
      }
      
    } catch (e) {
       return '';
    }
  }

  Future<Map> getCatByRace(String race) async {

    try {

      final response = await http.get(Uri.parse('$_url/images/search?breed_ids=$race'),
        headers: {
          'x-api-key': Enviroment.apiKey
        }
      );

      if (response.statusCode == 200) {
        
        final List data = jsonDecode(response.body);

        if(data.isNotEmpty){

          final CatModel cat = CatModel.fromJson(data[0]['breeds'][0]);
          
          String urlImage = await getImageUrl(cat.reference_image_id);
          cat.urlImage = urlImage;

          return {'status': response.statusCode,'data':[cat]};

        }else{
          return {'status': response.statusCode,'data':[]};
        }

      }else{
        return {'status': response.statusCode,'data':[]};
      }
      
    } catch (e) {
      return {'status': 500,'data':[]};
    }
  }

}