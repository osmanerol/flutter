class ToDo {
  int id;
  String description;

  ToDo({this.description});

  Map<String, dynamic> toMap() {
    var map=Map<String, dynamic>();
    map['description']=description;
    return map;
  }

  ToDo.fromMap(Map<String, dynamic> map) {
    id=map['id'];
    description=map['description'];
  }

}