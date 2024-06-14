import 'package:flutter/material.dart';
import 'package:trial/login_register/pages/teachH_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 40),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Choose your Role',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 52),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/main');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(69))),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/temp/student logo.jpeg',
                            width: 240,
                            height: 200,
                          ),
                          Text(
                            'Student',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(height: 55),
              SizedBox(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return teachHPage();
                        },
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(69)))),
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/temp/teacher1 logo.png',
                            width: 250,
                            height: 240,
                          ),
                          Text(
                            'Teacher',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
