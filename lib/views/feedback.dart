import 'package:flutter/material.dart';
import 'package:pdb/common/styles.dart';
import 'package:pdb/widgets/pdb_appbar.dart';
class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PDBAppBar(title: 'Feedback',showCommentButton: false,),
      body: Form(
        key: _formKey,
        autovalidate: true,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: 'Name',
                  hintText: 'Enter your first and last name'),
              maxLines: 1,
              maxLength: 100,
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Enter your email address'),
              maxLines: 1,
              maxLength: 200,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => isValidEmail(value) ? null : 'Please enter a valid email address',
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: const Icon(Icons.subject),
                  labelText: 'Subject',
                  hintText: 'Enter message subject'),
              maxLines: 1,
              maxLength: 100,
              keyboardType: TextInputType.text,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: const Icon(Icons.message),
                  labelText: 'Feedback',
                  hintText: 'Enter Feedback'),
              maxLines: 4,
              maxLength: 500,
              keyboardType: TextInputType.text,
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
bool isValidEmail(String input) {
  final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return regex.hasMatch(input);
}