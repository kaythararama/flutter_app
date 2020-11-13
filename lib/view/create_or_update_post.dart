import 'package:flutter/material.dart';
import 'package:flutter_app/model/entity/post.dart';
import 'package:flutter_app/service/post_service.dart';



class CreateOrUpdatePost extends StatefulWidget {
  CreateOrUpdatePost({Key key, this.post}) : super(key: key);

  final Post post;
  @override
  _CreateOrUpdatePostState createState() => _CreateOrUpdatePostState();
}

class _CreateOrUpdatePostState extends State<CreateOrUpdatePost> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller_userId = new TextEditingController();
  final TextEditingController _controller_title = new TextEditingController();
  final TextEditingController _controller_body = new TextEditingController();
  bool _processing = false;
  Color progressColor = Colors.transparent;

  @override
  void initState() {
    super.initState();

    if( widget.post != null){
      _controller_userId.text = widget.post.userId.toString();
      _controller_title.text = widget.post.title;
      _controller_body.text = widget.post.body;
    }
  }

  @override
  Widget build(BuildContext context){
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('${widget.post==null?'New post' : 'Update post'}'),
            bottom: _createProgressIndicator(),
          ),
          body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          labelText: 'UserId',
                        ),
                        controller: _controller_userId,
                        validator: (val) => val.isEmpty ? 'UserId is required' : null,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: new TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.email),
                            labelText: 'Title',
                          ),
                          controller: _controller_title,
                          validator: (val) => val.isEmpty ? 'Title is required' : null,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                        child: new TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.email),
                            labelText: 'Body',
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 5,
                          maxLines: null,
                          controller: _controller_body,
                          validator: (val) => val.isEmpty ? 'Body is required' : null,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 25.0, right: 10.0, top: 25),
                        width: double.infinity,
                        child: RaisedButton(
                            padding: EdgeInsets.all(15),
                            onPressed: _processing?null : () { _submitForm(context);},
                            elevation: 1,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                        ),
                      ),
                    ]
                )
            ),
          )
        )
    );
  }

  void _submitForm(BuildContext context) {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Required fields must be entered!', context);
    } else {
      form.save(); //This invokes each onSaved event
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

    bool isNewPost = widget.post==null;
    Post post;
    if( isNewPost)
      post = new Post();
    else
      post = widget.post;

    post.userId = int.parse(_controller_userId.text);
    post.title = _controller_title.text;
    post.body = _controller_body.text;

    PostService postService = PostService();
    if( isNewPost ){
      post = await postService.createPost(post);
      showMessage("New Post ID ${post.id} has been created!", context);
    }else{
      post = await postService.updatePost(post);
      showMessage("Post ID ${post.id} has been updated!", context);
    }

    setState(() {
      _processing = false;
      progressColor = Colors.transparent;
    });

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