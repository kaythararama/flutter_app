import 'package:flutter/material.dart';
import 'view/design1.dart';


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
                    builder: (BuildContext context) => HomeDesign(title: 'My home design',),
                  ));
                },
            ),
            RaisedButton(
              child: Text('Button 1'),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text('Button 1'),
              onPressed: (){},
            ),
            RaisedButton(
              child: Text('Button 1'),
              onPressed: (){},
            ),
          ],
        ),
    );
  }
}
