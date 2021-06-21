import 'package:flutter/material.dart';
import 'package:cheerapp/pages/login.dart';
import 'package:cheerapp/pages/home.dart';
import 'package:cheerapp/vars.dart';
import 'package:cheerapp/pages/profile.dart';
import 'package:cheerapp/pages/editProfile.dart';
import 'package:cheerapp/pages/search.dart';
import 'package:cheerapp/pages/silvers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
// global variables 

// colors


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  // var _infoIndex = 0;

  // void clickt() {
  //   setState(() {
  //     _infoIndex = 1;
  //   });
  //   print("Clicked a button");
  // }
  @override
  Widget build(BuildContext context) {
      // var info = [
      //   '',
      //   'Logged In!'
      // ];
    _generateUserPosts(String colname, List data) {
      final CollectionReference user_posts = FirebaseFirestore.instance.collection(colname);
      for (var i = 0; i < data.length; i++) {
        user_posts.add({
          'username': data[i]['user'], 
          // 'profile': 
          'date': data[i]['date'],
          'title': data[i]['title'],
          'description': data[i]['desc'],
          'image': data[i]['image'],
          'cheers': data[i]['cheers'],
          'tag': data[i]['tag'],
          
        }).whenComplete(() => print("Added data to database"));
      }
    }
        _generateHobbies() {
      final CollectionReference hobbiesRef= FirebaseFirestore.instance.collection('hobbies');
      for (var i = 0; i < hobbies.length; i++) {
        hobbiesRef.add({
          'name': hobbies[i]['name'],
          'image': hobbies[i]['imgurl'],
          'added': false
        }).whenComplete(() => print("Added hobby to database"));
      }
    }
    // _generateUserPosts('userposts', upost);
    // _generateHobbies();
    return MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/silvers': (context) => SilverHome(),
      '/add': (context) => AddPost(),
      '/edit': (context) => EditProfile(),
      '/home': (context) => Home(),
      '/search': (context) => Search(),
      '/profile': (context) => Profile(),
    },
    title: 'Cheer APP',
    theme: ThemeData(
        fontFamily: 'MagicDreams', 
        // primaryColor: Color(primaryColor),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(primary: Color(primaryColor))),
        // textTheme: TextTheme(
        //   bodyText1: TextStyle(color: Colors.black), 
        //   bodyText2: TextStyle(color: Colors.black)
        // ),
    ),
    // home: Login()
    // home: Profile()
    // routes: {
      // '/': (context) => Home()
      // '/search': (context) => Search()
      // '/profile': (context) => Profile()
    // }
    );

  }


}
