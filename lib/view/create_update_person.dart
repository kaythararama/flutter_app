import 'package:flutter/material.dart';
import 'package:flutter_app/database/dao/person_dao.dart';
import 'package:flutter_app/database/entity/person.dart';
import 'package:intl/intl.dart';
import 'package:threading/threading.dart';


class CreateUpdatePerson extends StatefulWidget {
  CreateUpdatePerson({Key key, this.person, this.personDao}) : super(key: key);

  final Person person;
  final PersonDao personDao;

  @override
  _CreateUpdatePersonState createState() => _CreateUpdatePersonState();
}

class _CreateUpdatePersonState extends State<CreateUpdatePerson> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller_name = new TextEditingController();
  final TextEditingController _controller_address = new TextEditingController();
  final TextEditingController _controller_weight = new TextEditingController();
  final TextEditingController _controller_dob = new TextEditingController();
  DateTime _dob;
  bool _processing = false;
  Color progressColor = Colors.transparent;


  @override
  void initState() {
    super.initState();

    if( widget.person != null){
      _controller_name.text = widget.person.name;
      _controller_address.text = widget.person.address ?? '';
      _controller_weight.text = widget.person.weight.toString() ?? '0';
      if( widget.person.dob != null){
        _controller_dob.text = new DateFormat('yyyy-MM-dd').format(widget.person.dob);
        _dob = widget.person.dob;
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('${widget.person==null?'New person' : 'Update person'}'),
          bottom: _createProgressIndicator(),
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
                            icon: const Icon(Icons.add_location),
                            labelText: 'Address',
                          ),
                          controller: _controller_address,
                          keyboardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: null,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: new TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.ac_unit),
                            labelText: 'Weight(lb)',
                          ),
                          controller: _controller_weight,
                          keyboardType: TextInputType.number,
                        ),
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
                            color: Theme.of(context).primaryColor,
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
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              widget.person != null? 'Update' : 'Save',
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
      )
    );
  }

  void _submitForm(BuildContext context) {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Required!', context);
    } else {
      form.save();
      _saveOrUpdate( context );
    }
  }

  // SnackBar
  void showMessage(String message, BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(backgroundColor: Theme.of(context).primaryColor, content: new Text(message)));
    //Scaffold.of(context).showSnackBar(SnackBar(content: Text('your message')));
  }

  void _saveOrUpdate(BuildContext context) async{
    if( _processing ) return;

    setState(() {
      _processing = true;
      progressColor = Colors.orange;
    });

    bool isNewPerson = widget.person==null;
    Person person;
    if( isNewPerson)
      person = new Person();
    else
      person = widget.person;

    person.name = _controller_name.text;
    person.address = _controller_address.text;
    person.dob = _dob;
    person.weight = double.parse( _controller_weight.text );

    if( isNewPerson ){
      int count = await widget.personDao.insert(person);
      showMessage("$count new person has been inserted!", context);
    }else{
      int count = await widget.personDao.update(person);
      showMessage("${person.name} has been updated!", context);
    }

    setState(() {
      _processing = false;
      progressColor = Colors.transparent;
    });

    new ThreadTimer(new Duration(milliseconds: 3000), () {
      Navigator.pop(context, person);
    });
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

  PreferredSize _createProgressIndicator() => PreferredSize(
      preferredSize: Size(double.infinity, 4.0),
      child: SizedBox(
          height: 4.0,
          child: LinearProgressIndicator(backgroundColor: progressColor,)
      )
  );

  Future<bool> _onWillPop() async {
    return true;
  }

}