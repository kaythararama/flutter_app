import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List> getRequestData() async{
  List reply;
  try{
    // connecting to server
    var response = await http.get('https://jsonplaceholder.typicode.com/posts');
    if( response.statusCode == 200 ) {
      String data = response.body;
      // converting raw data into json format
      if( data != null)
        reply = jsonDecode(data) as List;
    }
  }catch(e){print(e);}

  return reply;
}