class Contact {
  int id;
  String name;
  String phoneNumber;
  String avatar;
  Contact({this.name, this.phoneNumber, this.avatar});

  static List<Contact> contacts=[
    Contact(name: 'Ali Yılmaz', phoneNumber: '0555 555 55 55', avatar:'' ),
    Contact(name: 'Veli Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Ahmet Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Mehmet Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Mustafa Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Hasan Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Hüseyin Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Davut Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Ekrem Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
    Contact(name: 'Recep Yılmaz', phoneNumber: '0555 555 55 55', avatar:''),
  ];

  Map<String, dynamic> toMap() {
    var map=Map<String, dynamic>();
    map['name']=name;
    map['phone_number']=phoneNumber;
    map['avatar']=avatar;
    return map;
   }

  Contact.fromMap(Map<String, dynamic> map) {
    id=map['id'];
    name=map['name'];
    phoneNumber=map['phone_number'];
    avatar=map['avatar'];
  }
}