import 'package:flutter/material.dart';
import 'package:flutter_app/database/dao/person_dao.dart';
import 'package:flutter_app/database/entity/person.dart';
import 'create_update_person.dart';


class PersonList extends StatefulWidget {
  PersonList({Key key}) : super(key: key);

  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {

  List _people;
  PersonDao _personDao;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async{
    if( _personDao == null) {
      _personDao = new PersonDao();
      await _personDao.open();
    }
    _people = await _personDao.list( 10000, 0 );
    setState(() {});
  }

  @override
  void dispose() {
    try{
      _personDao.close();
    }catch(e){}

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People List'),
      ),
      body: _people!=null? ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _people.map((var person) {
          return PersonItem(
            person: person,
            personDao: _personDao,
            onChange: (result){
              _loadData();
            },
          );
        }).toList(),
      ) : Center(
        child: Text('No record'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          Person result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateUpdatePerson(personDao: _personDao, ),
              )
          );
          if( result != null){
            _loadData();
          }
        },
        label: Text(
          'New person',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(Icons.person_add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class PersonItem extends StatelessWidget {
  PersonItem({this.person, this.personDao, this.onChange});

  final person;
  final PersonDao personDao;
  final Function onChange;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(5.0 ),
      child: Card(
        elevation: 2,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Text(person.name[0]),
              ),
              title: Text('${person.name}'),
              subtitle: Text(person.address),
            ),
            // new Image.asset("assets/images/logo.png"),
            ButtonTheme.bar( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Edit',
                    onPressed: () async{
                      Person result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => CreateUpdatePerson(
                              person: person,
                              personDao: personDao,
                            ),
                          )
                      );
                      if( result != null){
                        onChange(result);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    tooltip: 'Delete',
                    onPressed: () async{
                      bool result = await _showConfirmDialog(context);
                      if ( !result ){return;}

                      int count = await personDao.deleteById(person.id);
                      if( count > 0){
                        onChange(person);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return ListTile(
      leading: CircleAvatar(
        child: Text(person.name[0]),
      ),
      title: Text('${person.name}'),
      subtitle: Text(person.address),
      onTap: () async{
        Person result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateUpdatePerson(
                person: person,
                personDao: personDao,
              ),
            )
        );
        if( result != null){
          onChange(result);
        }
      },
    );
  }

  Future<bool> _showConfirmDialog( BuildContext context )async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Delete confirm"),
          content: new Text("Are you sure to delete?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () { result = true;Navigator.of(context).pop();},
            ),
            new FlatButton(
              child: new Text("No"),
              onPressed: () { result = false; Navigator.of(context).pop();},
            ),
          ],
        );
      },
    );
    return result;
  }
}