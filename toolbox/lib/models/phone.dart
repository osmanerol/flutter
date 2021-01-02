class Phone {
  int id;
  String name;
  String number;

  Phone({this.name, this.number});

  Map<String, dynamic> toMap() {
    var map=Map<String, dynamic>();
    map['name']=name;
    map['phone_number']=number;
    return map;
  }

  Phone.fromMap(Map<String, dynamic> map) {
    id=map['id'];
    name=map['name'];
    number=map['phone_number'];
  }

}