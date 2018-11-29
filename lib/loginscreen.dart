import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;
  bool obscure = true;
  String _email, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();
  void _changeObscure() {
    setState(() {
          obscure = !obscure;
        });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFa7c045),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 14.0, left: 10.0),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.0),
                onPressed: Navigator.of(context).pop,
              ),
            ),
            SizedBox(height: 10.0,),
            Center(child: Image.asset('assets/logo.png', height: 40.0, )),
            SizedBox(height: 50.0,),
            Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: loggedIn == false
                ? Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 40.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 38.0),
                          child: new RichText(
                            text: new TextSpan(
                              text: 'ai deja un cont? ',

                              style: TextStyle(
                                fontSize: 14.0,
                                color: const Color(0xFFa9abae),
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                  text: 'log in ',
                                  style: new TextStyle(
                                    color: const Color(0xFFa9abae),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                new TextSpan(
                                  text: ' aici!',
                                  style: TextStyle(
                                    color: const Color(0xFFa9abae),
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.all(15.0),
                          height: 50.0,
                          padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 15.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: const Color(0xFFa9abae), style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: const Color(0xFFa9abae)
                              ),
                              labelText: "e-mail",
                              contentPadding: EdgeInsets.all(0.0),
                            ),
                            validator: (str) =>
                                !str.contains('@') ? "Not a Valid Email!" : null,
                            onSaved: (str) => _email = str,
                          ),
                          
                        ),
                        
                        Container(
                          margin: EdgeInsets.all(15.0),
                          height: 50.0,
                          padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 15.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: const Color(0xFFa9abae), style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "parola",
                              suffixIcon: IconButton(
                                 onPressed: () => _changeObscure(),
                                 icon: Icon(Icons.remove_red_eye, color: const Color(0xFFa9abae), ),
                              ),
                              labelStyle: TextStyle(
                                color: const Color(0xFFa9abae)
                              ),
                              contentPadding: EdgeInsets.all(0.0),
                              
                            ),
                            validator: (str) =>
                                str.length <= 7 ? "Not a Valid Password!" : null,
                            onSaved: (str) => _password = str,
                            obscureText: obscure,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15.0),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            height: 50.0,
                            
                            child: RaisedButton(
                              
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              color: const Color(0xFF810055),
                              child: Text(
                                "login",
                                style: TextStyle(
                                  color: Colors.white,
                                ),  
                              ),
                              onPressed: onPressed,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 38.0),
                          child: new RichText(
                            text: new TextSpan(
                              text: 'ai uitat ',
                              style: TextStyle(
                                color: const Color(0xFF810055),
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                  text: 'parola ',
                                  style: new TextStyle(
                                    color: const Color(0xFF810055),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                new TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: const Color(0xFF810055),
                                    
                                    
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0,)
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      children: <Widget>[
                        Text("Welcome $_email"),
                        RaisedButton(
                          child: Text("Log Out"),
                          onPressed: () {
                            setState(() {
                              loggedIn = false;
                            });
                          },
                        )
                      ],
                    ),
                  )
                ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {
    var form = formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {
        loggedIn = true;
      });

      var snackbar = SnackBar(
        content:
            Text('Email: $_email, Password: $_password'),
        duration: Duration(milliseconds: 5000),
      );

      mainKey.currentState.showSnackBar(snackbar);
    }
  }
}


