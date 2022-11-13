import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class StarDevFirebaseUser {
  StarDevFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

StarDevFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<StarDevFirebaseUser> starDevFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<StarDevFirebaseUser>(
      (user) {
        currentUser = StarDevFirebaseUser(user);
        return currentUser!;
      },
    );
