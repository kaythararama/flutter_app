
import 'package:flutter/material.dart';
import 'package:flutter_app/view/register.dart';
import 'package:flutter_app/view/shopping.dart';
import 'package:flutter_app/simple_internet_connection.dart';
import 'view/bottom_nav.dart';
import 'view/design.dart';
import 'view/design2.dart';
import 'view/drawer.dart';
import 'view/login.dart';
import 'view/my_button.dart';
import 'view/post_list_reusable.dart';
import 'view/post_list_simple.dart';
import 'service/post_service.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text('Design 1'),
              onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => HomeDesign(title: 'My home design',)
              ));
              }
          ),
          RaisedButton(
              child: Text('Gesture'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => MyButton()
                ));
              }
          ),
          RaisedButton(
              child: Text('Shopping list'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => ShoppingList(
                      products: <Product>[
                        Product(name: 'Eggs'),
                        Product(name: 'Flour'),
                        Product(name: 'Chocolate chips'),
                      ],
                    )
                ));
              }
          ),
          RaisedButton(
              child: Text('Design 2'),
              color: Colors.orange,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Design2(
                      title: 'My Design 2',
                    )
                ));
              }
          ),
          RaisedButton(
              child: Text('Login form'),
              color: Colors.red,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => MyLogin()
                ));
              }
          ),
          RaisedButton(
              child: Text('Register form'),
              color: Colors.green,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => MyRegister()
                ));
              }
          ),
          MyButton(),
          RaisedButton(
              child: Text('RESTful API Simple'),
              color: Colors.green,
              onPressed: ()async{
                // PostService postService = PostService();
                // var postList = await postService.getPostList();
                // print('Total post size: ${postList.length}');
                // var post = postList[0];
                // print('Id: ${post.id}');
                // print('title: ${post.title}');

                // var postList = await getRequestData();
                // print('Total post size: ${postList.length}');
                // var post = postList[0];
                // print('Id: ${post['id']}');
                // print('title: ${post['title']}');


                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => PostListSimple()
                ));
              }
          ),
          RaisedButton(
              child: Text('Restful API reusable'),
              color: Colors.green,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => PostListReusable()
                ));
              }
          ),
        ],
      ),
      drawer: AppDrawer(),
      bottomNavigationBar: MyBottomNavigator(
        selectedIndex: (index){
          print('Selected bottom nav index is $index');
          setState(() {});
        },
      ),
    );
  }
}