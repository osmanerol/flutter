class Photo {
  int id;
  String path;

  Photo({this.path});

  Map<String, dynamic> toMap() {
    var map=Map<String, dynamic>();
    map['path']=path;
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id=map['id'];
    path=map['path'];
  }

}