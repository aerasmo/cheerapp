import 'package:flutter/material.dart';
import 'package:cheerapp/vars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Hobby extends StatelessWidget {
  final _hobby;

  Hobby(this._hobby);
  @override
  Widget build(BuildContext context) {
    if (this._hobby["added"]) {
      return _addedHobby(context);
    }
    return Container();
  }
  _addedHobby(BuildContext context) {
    return 
    InkWell(
        onTap: () => Navigator.pushNamed(context, '/search'),
        child: Container(
        width: 330,
        margin: EdgeInsets.only(top: 15),
        color: Color(postColor),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
          child: Row(children: [
            Text(this._hobby["name"], style: TextStyle(fontSize: 16)),
            Spacer(),
            IconButton(icon: 
            Icon(Icons.remove_circle), 
              onPressed: () {
                this._hobby.reference.updateData({
                  'added': false
                });
              })
            ],),
        ),
      ),
    );
  }
}
class PostMini extends StatelessWidget {
  final _post;

  PostMini(this._post);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('profile').doc('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: new Text("Loading"));
        }
        var pdata = snapshot.data;
        if (pdata['username'] == this._post['username']) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
            color: Color(postColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              PostMiniImg(this._post),
              Container(
                width: 200,
                padding: EdgeInsets.fromLTRB(20, 10 , 20, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: [
                  Container(child: Text(this._post['title'])),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("Cheers: " + this._post['cheers'].toString())),
                  Container(child: Text(this._post['date'])),
                ]),
              ),
              Spacer(),
              // DELETE ITEM
              Container(
                alignment: Alignment.center,
                width: 50,
                margin: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    print("Deleting an item");
                    this._post.reference.delete();
                  }
                  , 
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(primaryColor))),
                  child: Icon(Icons.delete, size: 18, color: Colors.black54)
                  ),
              )
            ],),
                  );
        }
        return Container();
        
      }
    );
  }
}
class PostTag extends StatelessWidget {
  final post;

  PostTag(this.post);
  @override
  Widget build(BuildContext context) {
    if (post.data().containsKey("tag")) {
      if (this.post["tag"] == "") {
      }
      else {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(secondaryColor),

          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
          margin: EdgeInsets.only(top: 2.5),
          child: Text(post["tag"], style: TextStyle(fontSize: 12, color: Colors.white70))
        );
      }
    }
    return Container(
      
    );
  }
}
class PostMiniImg extends StatelessWidget {
  final post;

  PostMiniImg(this.post);
  @override
  Widget build(BuildContext context) {
    if (post.data().containsKey("image")) {
      if (this.post["image"] == "") {
        
      }
      else if (this.post["image"].contains(new RegExp(r'post'))) {
      return Container(
            width: 80,  
            child: Image.asset(this.post["image"], height: 80)
            );
      } else {
        return Container(
            width: 80,
            child: Image.network(this.post["image"], height: 80)
          );
      }
    } 
      // return null;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Icon(Icons.not_accessible, size: 40),
    );

    
      
  }
}
class LikedPost extends StatelessWidget {
  final _post;

  LikedPost(this._post);
  @override
  Widget build(BuildContext context) {
    if (this._post["liked"]) {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(10, 15, 10, 5),
        color: Color(postColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          PostMiniImg(this._post),
          Container(
            width: 200,
            padding: EdgeInsets.fromLTRB(20, 10 , 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
              Container(child: Text(this._post['title'])),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("@" + this._post['username'].toString())),
              Container(child: Text(this._post['date'])),
            ]),
          ),
          Spacer(),
          
        ],),
        );
      }
      return Container();
  }
}

class PostImg extends StatelessWidget {
  final post;

  PostImg(this.post);
  @override
  Widget build(BuildContext context) {
    if (post.data().containsKey("image")) {
      if (this.post["image"] == "") {
        
      }
      else if (this.post["image"].contains(new RegExp(r'post'))) {
      return Container(
            alignment: Alignment.center,
            child: Image.asset(this.post["image"])
          );
      } else {
        return Container(
            alignment: Alignment.center,
            child: Image.network(this.post["image"])
          );
      }
    } 
      // return null;
    return Container();

    
      
  }
}
class Avatar extends StatelessWidget {
  final post;

  Avatar(this.post);
  @override
  Widget build(BuildContext context) {
    if (post.data().containsKey("profile")) {
      if (this.post["profile"] == "") {
        
      }
      else if (this.post["profile"].contains(new RegExp(r'profile'))) {
      return Container(
            alignment: Alignment.center,
            child: Image.asset(this.post["profile"], width: 100)
            
          );
      } else {
        return Container(
            alignment: Alignment.center,
            child: Image.network(this.post["profile"], width: 100)
        );
      }
    } 
      // return null;
    return Container();
  }
}
class Cover extends StatelessWidget {
  final post;

  Cover(this.post);
  @override
  Widget build(BuildContext context) {
    if (post.data().containsKey("cover")) {
      if (this.post["cover"] == "") {
        
      }
      else if (this.post["cover"].contains(new RegExp(r'profile'))) {
        return Image.asset(this.post["cover"]);
        
      } else {
        return Image.network(this.post["cover"]);
      }
    } 
      // return null;
    return Container();
  }
  
}
class PostDescription extends StatelessWidget {
  final post;

  PostDescription(this.post);
  @override
  Widget build(BuildContext context) {
    if (post.data().containsKey("description")) {
      if (this.post["description"] != '') {
        return _description();
      }
    }
    return Container();
  }
  _description () {
    return Container(
            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
            width: double.infinity,
            color: Color(primaryColor),
            child: Text(this.post["description"])
          );
  }
}
class LikedPostMiniImg extends StatelessWidget {
  final post;

  LikedPostMiniImg(this.post);
  @override
  Widget build(BuildContext context) {
    if (post.data().containsKey("image")) {
      if (this.post["image"] == "") {
        
      }
      else if (this.post["image"].contains(new RegExp(r'post'))) {
      return Container(
            width: 80,  
            child: Image.asset(this.post["image"], height: 80)
            );
      } else {
        return Container(
            width: 80,
            child: Image.network(this.post["image"], height: 80)
          );
      }
    } 
      // return null;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Icon(Icons.not_accessible, size: 40),
    );

    
      
  }
}

class NavBar extends StatelessWidget {
  final _index;

 
  // switch(_index) {
  //     case 0:
  //     child = FlutterLogo(colors: Colors.orange);
  //     break;

  //     case 1:
  //       child = FlutterLogo();
  //       break;
  // }
  NavBar(this._index);
  @override
  Widget build(BuildContext context) {
    var _route;
    return 
      BottomNavigationBar(items: 
        const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),     
        ],
        selectedItemColor: Color(secondaryColor),
        currentIndex: this._index,
        onTap: (int index) {
            print(index);
            switch(index) {
              case 0:
                _route = '/home';
                break;

              case 1:
                _route = '/search';
                break;
              
              case 2:
                _route = '/profile';
                break;
            };
            Navigator.pushNamed(context, _route);

        }
      );          
  }
}

class Header extends StatelessWidget {
  final Function _func;
  final int _index;
  final bool hasAdd;
  Header(this._func, this._index, this.hasAdd);
  @override
  Widget build(BuildContext context) {
    if (this.hasAdd) {
      return Scaffold(

        backgroundColor: Color(navColor),
        appBar: 
        AppBar(
          iconTheme: IconThemeData(
            color: Colors.black54, //change your color here
          ),
          title: Text("CheerAPP",
            style: TextStyle(
            color: Colors.black54,
            fontSize: 23.0
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(primaryColor),
          //TODO app bar stuff
          actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false),
                  child: Icon(
                    Icons.logout,
                    size: 26.0,

                  ),
                )
              ),
            ]
            // -----------------------------------
        ),
        bottomNavigationBar: NavBar(this._index),
        body: this._func(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add'),
          child: Icon(
            Icons.add,
            color: Colors.black87
          ),
          backgroundColor: Color(primaryColor)
        ),
      ); 
    }
    return Scaffold(
    
        backgroundColor: Color(navColor),
        appBar: 
        AppBar(
          iconTheme: IconThemeData(
            color: Colors.black54, //change your color here
          ),
          title: Text("CheerAPP",
            style: TextStyle(
            color: Colors.black54,
            fontSize: 23.0
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(primaryColor),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false),
                child: Icon(
                  Icons.logout,
                  size: 26.0,

                ),
              )
            ),
          ]
        ),
        bottomNavigationBar: NavBar(this._index),
        body: this._func(),

      ); 
  }
}
