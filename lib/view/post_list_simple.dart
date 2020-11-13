import 'package:flutter/material.dart';
import '../simple_internet_connection.dart';


class PostListSimple extends StatefulWidget {
  PostListSimple({Key key}) : super(key: key);

  @override
  _PostListSimpleState createState() => _PostListSimpleState();
}


class _PostListSimpleState extends State<PostListSimple> {

  List _posts;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async{
    _posts = await getRequestData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post List Simple'),
      ),
      body: _posts!=null? ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _posts.map((var post) {
          return ListItem(
            post: post,
          );
        }).toList(),
      ) : Text('Loading'),
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
        child: Text(post['title'][0]),
      ),
      title: Text('${post['id']}'),
      subtitle: Text(post['title']),
    );
  }
}
