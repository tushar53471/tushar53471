import 'package:firebase_auth/firebase_auth.dart';

class Authcontroller {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<String> signUpUsers(String email, String fullName, String phoneNumber,
      String password) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        //Create the users

        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        res = 'success';
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (e) {}

    return res;
  }
}
