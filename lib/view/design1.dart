
import 'package:flutter/material.dart';


class HomeDesign extends StatefulWidget {
  HomeDesign({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeDesign> {

  Column _buildButtonColumn( BuildContext context, Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
            child: Material(
              color: Colors.blue, // button color
              child: InkWell(
                splashColor: Colors.red, // inkwell color
                child: SizedBox(width: 56, height: 56, child: Icon(icon, color: Colors.white)),
                onTap: () {},
              ),
            )
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonColumn(context, Colors.blueGrey, Icons.monetization_on, 'Earn Points'),
                _buildButtonColumn(context, Colors.blueGrey, Icons.redeem, 'Use Points'),
                _buildButtonColumn(context, Colors.blueGrey, Icons.share, 'Share'),
                _buildButtonColumn(context, Colors.blueGrey, Icons.account_circle, 'My Profile'),
              ],
            ),
          ),
          _card1(),
        ],
      ),
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
                    const ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage('https://www.edge.com.mm/media/k2/items/cache/fa55c8bad0e242eb7986dc1135b50adb_L.jpg'), ),
                      title: Text('KMD'),
                      subtitle: Text('Updated: Today'),
                      trailing: Icon(Icons.menu),
                    ),
                    new Image.network(
                      'https://lh3.googleusercontent.com/proxy/5VTIIJfsnhz3hxipxxe2kXgxipdIBneBNARnEHWqgZn_q4clPhyPc3yrZw_UzyHkODYUcyMHGYlZd5F4zNKJccqgid4',
                    ),
                    ButtonTheme.bar( // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('View more'),
                            onPressed: () { /* ... */ },
                          ),
                          IconButton(
                            icon: Icon(Icons.thumb_up),
                            tooltip: 'Like',
                            onPressed: () {},
                          ),IconButton(
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
