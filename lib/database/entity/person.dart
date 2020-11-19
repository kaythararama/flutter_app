
class Person{
  int id;
  String name;
  String address;
  DateTime dob;
  double weight;

  Person({this.id,this.name,this.address, this.dob, this.weight});

  factory Person.fromMap(Map<String, dynamic> data){
    return Person(
      id: data['id'],
      name: data['name'],
      address: data['address'],
      dob: data['dob']!=null? DateTime.fromMillisecondsSinceEpoch(data['dob']) : null,
      weight: data['weight']
    );
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'address': address,
      'dob': dob!=null? dob.millisecondsSinceEpoch : null,
      'weight': weight
    };
    return data;
  }
}