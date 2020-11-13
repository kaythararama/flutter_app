
import 'dart:convert';
import 'package:flutter_app/model/entity/post.dart';
import 'package:flutter_app/model/reponse/post_response.dart';
import 'my_http_client.dart';

class PostService{

  Future<List<Post>> getPostList() async{
    String reply_raw_data = await getRequest('https://jsonplaceholder.typicode.com/posts');
    PostResponse postResponse = new PostResponse();
    postResponse.fromJson(reply_raw_data);
    return postResponse.posts;
  }

  Future<Post> createPost( Post post) async{
    Post response;
    String reply_raw_json = await postRequest('https://jsonplaceholder.typicode.com/posts', post.toMap());

    if( reply_raw_json != null){
      Map<String, dynamic> data = jsonDecode(reply_raw_json);
      response = Post.fromJson( data );
    }

    return response;
  }

  Future<Post> updatePost( Post post) async{
    Post response;
    String reply_raw_json = await putRequest('https://jsonplaceholder.typicode.com/posts/${post.id}', post.toMap());

    if( reply_raw_json != null){
      Map<String, dynamic> data = jsonDecode(reply_raw_json);
      response = Post.fromJson( data );
    }

    return response;
  }

  Future<bool> deletePost( int postId) async{
    await deleteRequest('https://jsonplaceholder.typicode.com/posts/$postId');
    return true;
  }

}
