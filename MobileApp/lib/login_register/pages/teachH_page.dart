import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trial/dashboard_page.dart';
import 'package:trial/login_register/pages/teachR_page.dart';
import 'package:trial/login_register/pages/utils.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class teachHPage extends StatefulWidget {
  const teachHPage({Key? key});

  @override
  _teachHPageState createState() => _teachHPageState();
}

class _teachHPageState extends State<teachHPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  void signIn() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true; // Set loading to true when sign-in starts
      });

      auth
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text.toString(),
      )
          .then((value) {
        Utils().toastMessage(value.user!.email.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => DashboardScreen())));
      }).catchError((error) {
        debugPrint(error.toString());
        Utils().toastMessage(error.toString());
      }).whenComplete(() {
        setState(() {
          loading = false; // Set loading to false when sign-in completes
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset('assets/temp/teacher1 logo.png'),
                SizedBox(height: 20),
                Text(
                  'Sign in as Teacher',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email ID',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.alternate_email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                              onTap: () {
                                // Implement logic for visibility toggle
                              },
                              child: Icon(Icons.visibility),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Implement forgot password logic
                            },
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: signIn,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(fontSize: 20),
                              ),
                              if (loading)
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 35),
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return teachRPAge();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
