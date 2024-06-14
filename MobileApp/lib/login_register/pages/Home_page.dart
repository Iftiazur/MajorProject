import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial/login_register/pages/stud_page.dart';
import 'package:trial/login_register/pages/teachH_page.dart';
import 'package:trial/login_register/pages/utils.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  void signIn() {
    setState(() {
      loading = true;
    });

    auth
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text.toString(),
    )
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
        context,
        MaterialPageRoute(builder: ((context) => teachHPage())),
      );
    }).catchError((error) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    }).whenComplete(() {
      setState(() {
        loading = false; // Set loading to false when sign-in completes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset('assets/temp/student logo.jpeg'),
                  SizedBox(
                    height: 50,
                  ),
                  Text('Sign in as Student',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                hintText: 'Email ID',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: Icon(Icons.alternate_email)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Email ID';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'PASSWORD',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: InkWell(
                                  child: Icon(Icons.visibility),
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text('Forgot Password',
                                  style: TextStyle(fontSize: 15)),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signIn();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.blue),
                            child: loading
                                ? CircularProgressIndicator()
                                : Text(
                                    'Login',
                                    style: TextStyle(fontSize: 20),
                                  ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Don't have an account?",
                              style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return StudPage();
                              }));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white),
                            child: Text('Register',
                                style: TextStyle(fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
