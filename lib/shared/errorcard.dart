import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({Key? key, required this.errorText}) : super(key: key);

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.red,
          ),
        ),
        child: ListTile(
          title: Text(errorText,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

