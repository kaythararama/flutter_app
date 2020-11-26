import 'package:flutter/material.dart';
import 'package:flutter_app/database/dao/person_dao.dart';
import 'package:flutter_app/database/entity/person.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'create_update_person.dart';


class PullToRefreshList extends StatefulWidget {
  PullToRefreshList({Key key}) : super(key: key);

  @override
  _PersonListState createState() => _PersonListState();
}

class _PersonListState extends State<PullToRefreshList> {

  int _page = 0;
  static int LIMIT = 2;
  List _people=[];
  PersonDao _personDao;
  RefreshController _refreshController = RefreshController(initialRefresh: true);


  @override
  void initState() {
    super.initState();
  }

  _loadData( bool refresh ) async{
    if( _personDao == null) {
      _personDao = new PersonDao();
      await _personDao.open();
    }
    if( refresh)
      _page = 0;

    List _searchItems = await _personDao.list( LIMIT, _page * LIMIT );

    if( refresh && _people.isNotEmpty)
      _people.removeRange(0, _people.length);

    _searchItems.forEach((element) {
      _people.add(element);
    });
    setState(() {});
  }

  @override
  void dispose() {
    try{
      _personDao.close();
    }catch(e){}

    super.dispose();
  }

  Widget buildContent(BuildContext context) {
    return ListView.separated(
      reverse: false,
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => PersonItem(
        person: _people[i],
        personDao: _personDao,
        onChange: (result){
          _loadData(true);
        },
      ),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.transparent,
        );
      },
      itemCount: _people.length,
    );
  }

  Widget refresh(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      child: buildContent(context),
      physics: BouncingScrollPhysics(),
      header: WaterDropHeader(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),

      // scroll down
      onRefresh: () async {
        _page = 0;
        await _loadData( true);
//        await Future.delayed(Duration(milliseconds: 1000));
        if (mounted) setState(() {});
        _refreshController.refreshCompleted();

        /*
        if(failed){
         _refreshController.refreshFailed();
        }
      */
      },
      // scroll up
      onLoading: () async {
        ++_page;
        await _loadData( false );
//        await Future.delayed(Duration(milliseconds: 1000));
        if (mounted) setState(() {});
        _refreshController.loadComplete();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People List'),
      ),
      body: refresh(context),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async{
          Person result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateUpdatePerson(personDao: _personDao, ),
              )
          );
          if( result != null){
            _loadData( true );
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