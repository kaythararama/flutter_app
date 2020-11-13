

import 'package:flutter/material.dart';

class HomeDesign extends StatefulWidget {
  HomeDesign({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeDesign> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 0, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonColumn(context, Colors.blue, Icons.monetization_on, 'Earn Points'),
                _buildButtonColumn(context, Colors.blue, Icons.redeem, 'Use Points'),
                _buildButtonColumn(context, Colors.blue, Icons.share, 'Share'),
                _buildButtonColumn(context, Colors.blue, Icons.account_circle, 'My Profile'),
              ],
            ),
          ),
          _card1()
        ],
      ),
    );
  }

  Column _buildButtonColumn( BuildContext context, Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
            child: Material(
              color: color, // button color
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child: SizedBox(width: 56, height: 56, child: Icon(icon, color: Colors.red)),
                onTap: () {},
              ),
            )
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  Widget _card1(){
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 5.0, top: 3.0, right: 5.0 ),
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                elevation: 8,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage('https://www.edge.com.mm/media/k2/items/cache/fa55c8bad0e242eb7986dc1135b50adb_L.jpg'), ),
                      title: Text('KMD'),
                      subtitle: Text('Updated: Today'),
                      trailing: Icon(Icons.menu),
                    ),
                    // new Image.asset("assets/images/logo.png"),
                    new Image.network(
                      'https://www.edge.com.mm/media/k2/items/cache/fa55c8bad0e242eb7986dc1135b50adb_L.jpg',
                      width: 200,
                      height: 200,
                    ),
                    ButtonTheme.bar( // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: Text('View more'),
                            onPressed: () { /* ... */ },
                          ),
                          IconButton(
                            icon: Icon(Icons.thumb_up),
                            tooltip: 'Like',
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            tooltip: 'Share',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }

}