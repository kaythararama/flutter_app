

import 'dart:convert';
import '../entity/post.dart';

class PostResponse{
  List<Post> posts = List();

  fromJson(String json){
    if( json == null) return;
    final resultData = jsonDecode(json) as List;
    resultData.forEach((element) {
      Post post = Post.fromJson(element);
      posts.add(post);
    });
  }
}