import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/widgets/pdb_appbar.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PDBAppBar(title: 'Contact',showCommentButton: false,),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  icon:const Icon(Icons.person),
                  labelText:'Name',
                  hintText: 'Enter your first and last name'
              ),
              maxLines: 1,
              maxLength: 100,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon:const Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Enter your email address'
              ),
              maxLines: 1,
              maxLength: 200,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon:const Icon(Icons.subject),
                  labelText: 'Subject',
                  hintText: 'Enter message subject'
              ),
              maxLines: 1,
              maxLength: 100,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon:const Icon(Icons.message),
                  labelText: 'Message',
                  hintText: 'Enter message subject'
              ),
              maxLines: 4,
              maxLength: 500,
            ),
            new Container(
              padding: const EdgeInsets.only(left: 40.0, top: 20.0),
              child: new RaisedButton(
                child: const Text('Submit',),
                color: kDBPrimaryColor,
                onPressed: (){},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
