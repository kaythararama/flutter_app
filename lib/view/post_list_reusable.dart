import 'package:flutter/material.dart';
import '../service/post_service.dart';
import 'create_or_update_post.dart';


class PostListReusable extends StatefulWidget {
  PostListReusable({Key key}) : super(key: key);

  @override
  _PostListReusableState createState() => _PostListReusableState();
}


class _PostListReusableState extends State<PostListReusable> {

  List _posts;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async{
    PostService postService = PostService();
    _posts = await postService.getPostList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List Reusable'),
      ),
      body: _posts!=null? ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _posts.map((var post) {
          return ListItem(
            post: post,
          );
        }).toList(),
      ) : Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateOrUpdatePost( ),
              )
          );
        },
        label: Text(
          'New post',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.create),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({this.post});

  final post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(post.title[0]),
      ),
      title: Text('${post.id}'),
      subtitle: Text(post.title),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CreateOrUpdatePost(post: post, ),
          )
        );
      },
    );
  }
}
