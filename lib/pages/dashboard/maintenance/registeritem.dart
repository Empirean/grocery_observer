import 'package:flutter/material.dart';

class RegisterItem extends StatefulWidget {
  const RegisterItem({Key? key}) : super(key: key);

  @override
  _RegisterItemState createState() => _RegisterItemState();
}

class _RegisterItemState extends State<RegisterItem> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(

            ),
            TextFormField(

            ),
            TextButton(
                onPressed: () {

                },
                child: const Text("Confirm")
            )
          ],
        ),
      ),
    );
  }
}
