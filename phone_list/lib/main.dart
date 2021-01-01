import 'package:flutter/material.dart';
import 'package:phone_list/contact_page.dart';
import 'package:phone_list/model/contact.dart';

void main() {
  runApp(MaterialApp(
    title: 'Phone List',
    home: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  final List<Contact> contacts=Contact.contacts;

  @override
  Widget build(BuildContext context) {
    return ContactPage();
  }
}