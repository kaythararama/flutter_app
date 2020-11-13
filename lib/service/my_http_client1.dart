import 'package:http/http.dart' as http;


Future<String> getRequest( String uri  ) async{

  String reply;
  try{
    var response = await http.get('$uri'
        //, headers: {"Content-Type": "application/json;charset=UTF-8","Accept": "application/json"}
    );
    if( response.statusCode == 200 )
      reply = response.body;
  }catch(e){
    print(e);
  }

  return reply;
}