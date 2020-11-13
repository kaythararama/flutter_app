
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class MyRegister extends StatefulWidget {
  MyRegister({Key key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller_name = new TextEditingController();
  final TextEditingController _controller_email = new TextEditingController();
  final TextEditingController _controller_phone = new TextEditingController();
  final TextEditingController _controller_dob = new TextEditingController();
  String _gender;
  double _age = 0;
  DateTime _dob;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register'),
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
                          hintText: 'e.g. mg mg',
                          labelText: 'Name',
                        ),
                        controller: _controller_name,
                        validator: (val) => val.isEmpty ? 'Name is required' : null,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: new TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.phone),
                            hintText: '09 xxx xxx xxx',
                            labelText: 'Mobile number',
                          ),
                          controller: _controller_phone,
                          keyboardType: TextInputType.phone,
                          validator: (val) => val.isEmpty ? 'Mobile number is required' : (isValidPhoneNumber(val) ? null : 'Please enter a valid phone number'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: new TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.email),
                            hintText: 'name@domain.com',
                            labelText: 'Email address',
                          ),
                          controller: _controller_email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => isValidEmail(value) ? null : 'Please enter a valid email address',
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                        child:new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              'Gender',
                              style: new TextStyle( fontWeight: FontWeight.bold,),
                            ),
                            Expanded(
                                child: Center(
                                    child:
                                    RadioListTile(
                                      value: 'Male',
                                      groupValue: _gender,
                                      title: Text('Male'),
                                      onChanged: ( value){
                                        setState(() { _gender = value; });
                                      },
                                    )
                                )
                            ),
                            Expanded(
                                child: Center(
                                    child:
                                    RadioListTile(
                                      value: 'Female',
                                      groupValue: _gender,
                                      title: Text('Female'),
                                      onChanged: ( value){
                                        setState(() { _gender = value; });
                                      },
                                    )
                                )
                            ),
                          ],
                        ),
                      ),

                      new Container(
                          margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: ListTile(
                            title: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Theme.of(context).primaryColor,
                                inactiveTrackColor: Colors.blueGrey[50],
                                trackShape: RoundedRectSliderTrackShape(),
                                trackHeight: 5.0,
                                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                thumbColor: Theme.of(context).primaryColor,
                                overlayColor: Colors.green[800].withAlpha(32),
                                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                                tickMarkShape: RoundSliderTickMarkShape(),
                                activeTickMarkColor: Colors.white,
                                inactiveTickMarkColor: Colors.red[600],
                                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                valueIndicatorColor: Theme.of(context).primaryColor,
                                valueIndicatorTextStyle: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              child: Slider(
                                value: _age,
                                min: 0.0,
                                max: 75,
                                divisions: 15,
                                label: '${_age.roundToDouble().toInt()} Age',
                                onChanged: (value) {
                                  setState(() {
                                    _age = value;
                                  });
                                },
                              ),
                            ),
                            subtitle: Text('Your age is ${_age.roundToDouble().toInt()} yr'),
                          )
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child:new Row(children: <Widget>[
                          new Expanded(
                              child: new TextFormField(
                                decoration: new InputDecoration(
                                  icon: const Icon(Icons.calendar_today),
                                  hintText: 'yyyy-mm-dd',
                                  labelText: 'Date of birth',
                                ),
                                controller: _controller_dob,
                                keyboardType: TextInputType.datetime,
                              )),
                          new IconButton(
                            icon: new Icon(Icons.mode_edit),
                            tooltip: 'Choose date',
                            onPressed: (() {
                              _chooseDate(context, _controller_dob.text );
                            }),
                          )
                        ]),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 25.0, right: 10.0, top: 25),
                        width: double.infinity,
                        child: RaisedButton(
                            padding: EdgeInsets.all(15),
                            onPressed: () { _submitForm(context);},
                            elevation: 1,
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                        ),
                      ),
                    ]
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
      String name = _controller_name.text;
      String phone = _controller_phone.text;
      String email = _controller_email.text;
      _doLogin( context );
    }
  }

  // SnackBar
  void showMessage(String message, BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(backgroundColor: Theme.of(context).primaryColor, content: new Text(message)));
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('your message')));
  }

  void _doLogin(BuildContext context){
    showMessage("Registering with ${_controller_name.text}", context);
  }

  bool isValidPhoneNumber(String input) {
    if( input== null || input.isEmpty) return true;
    final RegExp regex = new RegExp(r'^[0-9]{9,13}$');
    return regex.hasMatch(input);
  }

  bool isValidEmail(String input) {
    if( input==null || input.isEmpty) return true;
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  Future _chooseDate(BuildContext context, String initialDateString ) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1950),
        lastDate: new DateTime(2100)
    );

    if (result == null) return;

    setState(() {
      _controller_dob.text = new DateFormat('yyyy-MM-dd').format(result);
      _dob = result;
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat('yyyy-MM-dd').parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }
}