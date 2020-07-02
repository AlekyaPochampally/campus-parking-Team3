import 'package:cpui/firebase/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object base on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anonymous
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString("Anon sign in fail!"));
      return null; 
    }
  }

  //sign in with email & pwd
  Future signInWithEmailPassword(String email, String password )async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString("Sign in failed!"));
      return null; 
    }
  }


  //sign up with email & pwd
  Future signupWithEmailPassword(String email, String password )async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString("Sign up failed!"));
      return null; 
    }
  }

  //sign out
  Future signOut() async{
    try{
       return await _auth.signOut();
    }catch(e){
      print(e.toString("Sign out failed!"));
      return null;
    }
  }
}