import 'package:flutter/material.dart';
import 'package:grocery_observer/services/authentication.dart';

import '../../shared/errorcard.dart';
import '../../shared/fields.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String _email = "";
  String _password = "";
  String _lastname = "";
  String _firstname = "";
  String _errorText = "";
  bool _passwordVisibility = true;
  int stepIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            scrollDirection: Axis.vertical,
            child: Card(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black
                  )
              ),
              child: Column(
                children: [
                  Visibility(
                    visible: _errorText.isNotEmpty ? true : false,
                    child: ErrorCard(errorText: _errorText),
                  ),
                  Stepper(
                    currentStep: stepIndex,
                    onStepCancel: () {
                      if (stepIndex > 0) {
                        setState(() {
                          stepIndex -= 1;
                        });
                      }
                      else {
                        setState(() {
                          widget.toggleView();
                        });
                      }

                    },
                    onStepContinue: () async {

                      if (stepIndex == 0) {
                        if (_email.isEmpty) {
                          setState(() {
                            _errorText = "Invalid email format";
                          });
                          return;
                        }
                        if (_password.length < 6) {
                          setState(() {
                            _errorText = "Password must be longer than 5 characters";
                          });
                          return;
                        }
                      }

                      if (stepIndex == 1) {
                        if (_lastname.isEmpty) {
                          setState(() {
                            _errorText = "Enter your lastname";
                          });
                          return;
                        }
                        if (_firstname.isEmpty) {
                          setState(() {
                            _errorText = "Enter your firstname";
                          });
                          return;
                        }

                        dynamic result = await AuthenticationService().signUpEmail(
                            lastName: _lastname,
                            firstName: _firstname,
                            email: _email,
                            password: _password
                        );

                        if (result is String){
                          setState(() {
                            _errorText = result.replaceAll(RegExp('\\[.*?\\]'), '').trim();
                          });
                          return;
                        }

                      }

                      if (stepIndex <= 0) {
                        setState(() {
                          stepIndex += 1;
                          _errorText = "";
                        });
                      }
                    },
                    onStepTapped: (int index) {
                      setState(() {
                        stepIndex = index;
                      });

                    },
                    steps: [
                      Step(
                          title: const Text("Email and password"),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: fieldStyle.copyWith(
                                      hintText: "sample@example.com",
                                      labelText: "email"
                                  ),
                                  onChanged: (val) {
                                    _email = val;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  obscureText: _passwordVisibility,
                                  decoration: fieldStyle.copyWith(
                                    hintText: "password",
                                    labelText: "Password",
                                    suffixIcon:
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisibility = !_passwordVisibility;
                                          });
                                        },
                                        icon: Icon(_passwordVisibility ? Icons.visibility : Icons.visibility_off )
                                    ),
                                  ),
                                  onChanged: (val) {
                                    _password = val;
                                  },
                                ),
                              ),
                            ],
                          )
                      ),
                      Step(
                          title: const Text("Your name"),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: fieldStyle.copyWith(
                                      hintText: "lastname",
                                      labelText: "lastname"
                                  ),
                                  onChanged: (val) {
                                    _lastname = val;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  decoration: fieldStyle.copyWith(
                                      hintText: "firstname",
                                      labelText: "firstname"
                                  ),
                                  onChanged: (val) {
                                    _firstname = val;
                                  },
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      const Text(
                          "Already have an account?"
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              widget.toggleView();
                            });
                          },
                          child: const Text("Login")
                      ),
                      Expanded(child: Container()),
                    ],
                  )
                ],
              ),
            ),
              /*
              child: Card(
                shape: const RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.black
                    )
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: fieldStyle.copyWith(
                            hintText: "sample@example.com",
                            labelText: "email"
                        ),
                        onChanged: (val) {
                          _email = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        obscureText: _passwordVisibility,
                        decoration: fieldStyle.copyWith(
                          hintText: "password",
                          labelText: "Password",
                          suffixIcon:
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _passwordVisibility = !_passwordVisibility;
                                });
                              },
                              icon: Icon(_passwordVisibility ? Icons.visibility : Icons.visibility_off )
                          ),
                        ),
                        onChanged: (val) {
                          _password = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: fieldStyle.copyWith(
                            hintText: "lastname",
                            labelText: "lastname"
                        ),
                        onChanged: (val) {
                          _lastname = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: fieldStyle.copyWith(
                            hintText: "firstname",
                            labelText: "firstname"
                        ),
                        onChanged: (val) {
                          _firstname = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                                if (_formKey.currentState!.validate()){
                                  dynamic result = await AuthenticationService().signUpEmail(
                                      lastName: _lastname,
                                      firstName: _firstname,
                                      email: _email,
                                      password: _password
                                  );

                                  if (result is String){
                                    setState(() {
                                        _errorText = result;
                                    });
                                  }
                                }
                            },
                            child: const Text("Register")),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        const Text(
                            "Already have an account?"
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                widget.toggleView();
                              });
                            },
                            child: const Text("Login")
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            */
          ),
        ),
      ),
    );
  }
}