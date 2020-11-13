


import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name;
  String _password;
  String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              new TextFormField(
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  hintText: '',
                  labelText: 'Name',
                ),
                validator: (val) => val.isEmpty ? 'Name is required' : null,
                onSaved: (val) => _name = val,
              ),
                new TextFormField(
                  obscureText: true,// convert to password box
                  decoration: InputDecoration(
                    icon: const Icon(Icons.star),
                    hintText: '',
                    labelText: 'Password',
                  ),
                  validator: (val) => val.isEmpty ? 'Password required' : (val.length<6? 'Minimum password length is 6' : null),
                  onSaved: (val) => _password = val,
                ),
                new TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.star),
                    hintText: '',
                    labelText: 'Confirm password',
                  ),
                  validator: (val) => val.isEmpty ? 'Password required' : (val.length<6? 'Minimum password length is 6' : null),
                  onSaved: (val) => _confirmPassword = val,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 25.0, right: 10.0, top: 25),
                  width: double.infinity,
                  child: RaisedButton(
                      padding: EdgeInsets.all(15),
                      onPressed: () {
                        _submitForm(context);
                        },
                      elevation: 1,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
                  ),
                ),
              ],
            )
    ),
        )
      ),
    );
  }

  void _submitForm(BuildContext context) {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Required username and password!', context);
    } else {
      form.save(); //This invokes each onSaved event

      if( _password != _confirmPassword){
        // SnackBar
        showMessage("Password does not match!", context);
        return;
      }
      _doLogin( context );
    }
  }
  void _doLogin(BuildContext context){
    showMessage("Now logging in! with $_name and $_password", context);
  }

// SnackBar
  void showMessage(String message, BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(backgroundColor: Theme.of(context).primaryColor, content: new Text(message)));
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('your message')));
  }

}