import 'dart:convert';
import 'package:heros/api/heros.dart';
import 'package:http/http.dart' as http ;

class RemoteService {

  String url;

  Future <List> getHeros(String url) async{
    try {
      List<Heros> listHeros = [];
      var response = await http.get(Uri.parse(url),
      );
      if(response.statusCode == 200){
        var decodeJson = jsonDecode(response.body);
        decodeJson.forEach((item) => listHeros.add(Heros.fromJson(item)));
        return listHeros;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map> getDetailHero(String url) async {
    try {
      var _url = Uri.parse(url);
      var response = await http.get(_url);
      if(response.statusCode == 200){
        var json = jsonDecode(response.body);
        return json;
      } else {
        print('Erro ao carregar detalhes');
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}