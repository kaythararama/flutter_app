import 'dart:convert';
import 'package:http/http.dart' as http;


Future<String> getRequest( String uri  ) async{

  String reply;
  try{
    var response = await http.get('$uri',
        headers: {"Content-Type": "application/json;charset=UTF-8","Accept": "application/json"}
    );
    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;
  }catch(e){
      print(e);
  }

  return reply;
}

Future<String> getRequestWithAccessToken( String uri, String accessToken  ) async{

  String reply;
  try{
    var response = await http.get('$uri',
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Accept": "application/json",
          "Authorization":'Bearer ${accessToken}'
        }
    );
    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;
  }catch(e){
      print(e);
  }
  return reply;
}

Future<String> postRequest( String uri, Map jsonMap ) async{

  String reply;
  try{
    //encode Map to JSON
    var body = json.encode(jsonMap);

    var response = await http.post('$uri',
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        },
        body: body
    );

    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;

    //return response;
  }catch(e){
      print(e);
  }

  return reply;
}

Future<String> postRequestWithAccessToken( String uri, Map jsonMap, String accessToken ) async{

  String reply;
  try{
    //encode Map to JSON
    var body = json.encode(jsonMap);
    var response = await http.post('$uri',
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Accept": "application/json",
          "Authorization":'Bearer ${accessToken}'
        },
        body: body
    );

    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;

    //return response;
  }catch(e){
      print(e);
  }

  return reply;
}

Future<String> putRequest( String uri, Map jsonMap ) async{

  String reply;
  try{
    //encode Map to JSON
    var body = json.encode(jsonMap);
    var response = await http.put('$uri',
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        },
        body: body
    );

    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;

    //return response;
  }catch(e){
    print(e);
  }

  return reply;
}

Future<String> putRequestWithAccessToken( String uri, Map jsonMap, String accessToken ) async{

  String reply;
  try{
    //encode Map to JSON
    var body = json.encode(jsonMap);
    var response = await http.put('$uri',
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Accept": "application/json",
          "Authorization":'Bearer ${accessToken}'
        },
        body: body
    );

    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;

    //return response;
  }catch(e){
      print(e);
  }

  return reply;
}

Future<String> deleteRequest( String uri) async{

  String reply;
  try{
    var response = await http.delete('$uri',
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Accept": "application/json"
        }
    );
    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;
  }catch(e){
      print(e);
  }
  return reply;
}

Future<String> deleteRequestWithAccessToken( String uri, String accessToken  ) async{

  String reply;
  try{
    var response = await http.delete('$uri',
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Accept": "application/json",
          "Authorization":'Bearer ${accessToken}'
        }
    );
    if( response.statusCode == 200 || response.statusCode==201)
      reply = response.body;
  }catch(e){
    print(e);
  }
  return reply;
}