
import 'package:flutter/material.dart';
import 'package:flutter_app/view/register.dart';
import 'package:flutter_app/view/shopping.dart';
import 'package:flutter_svg/svg.dart';
import 'service/firebase_service.dart';
import 'view/bottom_nav.dart';
import 'view/design.dart';
import 'view/design2.dart';
import 'view/drawer.dart';
import 'view/google_map.dart';
import 'view/login.dart';
import 'view/my_button.dart';
import 'view/person_list.dart';
import 'view/post_list_reusable.dart';
import 'view/post_list_simple.dart';
import 'package:easy_localization/easy_localization.dart';

import 'view/pull_to_refresh_list.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Language selectedLanguage;
  List<Language> languages = <Language> [new Language("မြန်မာ", SvgPicture.asset( 'assets/images/myanmar.svg', semanticsLabel: 'My',height: 24, width: 24, )),
    Language('English', SvgPicture.asset( 'assets/images/uk.svg', semanticsLabel: 'En',height: 24, width: 24, ))];

  @override
  void initState() {
    super.initState();
    selectedLanguage = languages[1];
  }

  Widget dropdownWidget() {
    return new DropdownButtonHideUnderline(
      child: DropdownButton<Language>(
        //hint:  Text("Select item"),
        value: selectedLanguage,
        onChanged: (Language value) {
          setState(() {
            selectedLanguage = value;
            if( value.name != 'English'){
              context.locale = Locale('my','');
            }else{
              context.locale = Locale('en','');
            }
          });
        },
        items: languages.map((Language lang) {
          return  DropdownMenuItem<Language>(
            value: lang,
            child: Row(
              children: <Widget>[
                lang.icon,
                SizedBox(width: 10,),
                Text(
                  lang.name,
                  style:  TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Theme.of(context).primaryColor,
              ),
              child: dropdownWidget()
          ),
        ],

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
          RaisedButton(
              child: Text(
                  'SQLite Database',
                style: Theme.of(context).textTheme.headline2,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => PersonList()
                ));
              }
          ),
          RaisedButton(
              child: Text(
                'Refresh List'
              ),
              color: Colors.green,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => PullToRefreshList()
                ));
              }
          ),
          RaisedButton(
              child: Text(
                  'Google map'
              ),
              color: Colors.green,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => GoogleMapSample()
                ));
              }
          ),
          RaisedButton(
              child: Text(
                  'Firebase token'
              ),
              color: Colors.green,
              onPressed: () async{
                String token = await getFirebaseToken();
                print('Token: $token');
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

class Language {
  const Language(this.name,this.icon);
  final String name;
  final SvgPicture icon;
}