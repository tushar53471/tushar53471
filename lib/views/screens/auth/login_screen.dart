import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login Customer"s Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.yellow.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    letterSpacing: 5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Need An Account?'),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Register',
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
