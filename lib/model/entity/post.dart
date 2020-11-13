

class Post{
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> data){
    return Post(
      userId: data['userId'],
      id: data['id'],
      title: data['title'],
      body: data['body']
    );
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> data = {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body
    };
    return data;
  }

}