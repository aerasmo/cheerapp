import 'package:flutter/material.dart';
import 'package:cheerapp/vars.dart';
import 'package:cheerapp/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
// ADD POST
class AddPost extends StatelessWidget {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController imgurl = TextEditingController();
  final TextEditingController tag = TextEditingController();
  
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  final datenow = DateFormat.yMMMMd('en_US').format(DateTime.now());// 28/03/2020
  @override
  Widget build(BuildContext context) {
    _addPost() {
    return SingleChildScrollView(
      child: Container(
        color: Color(grey),
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container( // add post
          padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
          color: Color(primaryColor),
          child: Row(children: [
            Text('Add post ', style: TextStyle(
              // color: Colors.white70,
              color: Colors.black54,
              fontSize: h2,
            ),),
            Spacer(),
            IconButton(icon: Icon(Icons.cancel), color: Colors.black54,onPressed: () => Navigator.pop(context)),
          ]),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 5, 5),
          child: Text('Title', style: TextStyle(
              fontSize: h2,
            ),
          )
        ),
        Container( // title box
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: kElevationToShadow[5]
            ),
          child: TextField(
              controller: title,
              decoration: InputDecoration(
                // hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
              )
          )
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 5, 5),
          child: Row(children: [
          Text('Description', style: TextStyle(
              fontSize: h2,
            ),
          ),
          Spacer(),
        ],)),
          Container( // description
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: kElevationToShadow[5]
              ),
            child: TextField(
                controller: description,
                maxLines: 3,
                decoration: InputDecoration(
                  // hintText: 'Search',
                  // hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
                )
            )
          ),
        // URL DIRECTORY -------------------------------------------
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
          child: Row(children: [
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('Image Url', style: TextStyle(
                fontSize: h2,
              ),
            ),
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.attach_file), onPressed: null,)
        ],)),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: kElevationToShadow[5]
            ),
          child: TextField(
              controller: imgurl,
              decoration: InputDecoration(
                // hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
              )
          )
        ),
         // TAG -------------------------------------------
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 5, 5),
          child: Text('Hobby / Tag ', style: TextStyle(
              fontSize: h2,
            ),
          )
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: kElevationToShadow[5]
            ),
          child: TextField(
              controller: tag,
              decoration: InputDecoration(
                // hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
              )
          )
        ),
        Row(
          children: [
            Spacer(),
            //THIS
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('profile').doc('user').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: new Text("Loading"));
                  }
                  var pdata = snapshot.data;
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(primaryColor))
                    ),
                    child: Text("Post",
                      style: TextStyle(
                        color: Colors.black87,
                      )
                    ), 
                    onPressed: () {
                      if(title.text != "") {
                        print("Adding post to DB");
                        posts.add({
                          'username': pdata['username'],
                          'name': pdata['name'],
                          'profile': pdata['profile'],
                          'title': title.text,
                          'description': description.text,
                          'cheers': 0,
                          'date': datenow,
                          'tag': tag.text,
                          'image': imgurl.text,
                          'liked': false
                        }).whenComplete(() => Navigator.pop(context));
                      }

                    }
                    
                   ),
                );
              }
            ),
          ],
        ),
        ]
        )
      ),
    );
  }
    return Header(_addPost, 0, false);
  }

}
class Home extends StatefulWidget {


  // final CollectionReference posts = FirebaseFirestore.instance.collection('postsbeta');
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // UPDATE TO POSTS
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {


      // CollectionReference posts = FirebaseFirestore.instance.collection('postsbeta');
    _firestore() {
      return StreamBuilder<QuerySnapshot>(
          stream: posts.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Text("There is no Post");
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Post(snapshot.data.docs[index]);
              }
            );
          });
      }
      return Header(_firestore, 0, true);

    }
}
class HomeTemplate extends StatelessWidget {
  final Function func;

  HomeTemplate(this.func);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomPadding: false,
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
            
    ),
    body: this.func(),
    floatingActionButton: FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, '/add'),
      child: Icon(
        Icons.add,
        color: Colors.black87
      ),
      backgroundColor: Color(primaryColor)
    ),
    bottomNavigationBar: NavBar(0)
  ); 
  }
}
class Post extends StatefulWidget {
  final _post;

  Post(this._post);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Color iconColor = Colors.black87;
  @override
  Widget build(BuildContext context) {
    final _post = this.widget._post;
    print("building post");
    // print(this.widget._post);
    // print(this._post['user']);
    // print(this._post['date']);
    // print(this._post['title']);
    // print(this._post['image']);
    if (_post.data().containsKey("liked")) {
      
      if (_post['liked']) {
          print("liked" + _post["title"]);
          iconColor = Color(secondaryColor);
      } else {
        iconColor = Colors.black87;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Color(postColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],

      ),
      width: 320,
      // margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // icon
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(this.widget._post['profile'], width: 45, height: 45)),
            // username
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this.widget._post['name'], style: TextStyle(fontSize: 18)),
                  Text("@" + this.widget._post['username'], style: TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),
            // dateposted
            Spacer(flex:1),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(this.widget._post['date']),
                  PostTag(this.widget._post)
                ],
              ),
            ),
          ],
          ),
          // post description
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 10, 10),
            child: Text(this.widget._post['title'],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 22)
            ),
          ),
          //post image
          PostDescription(this.widget._post),
          PostImg(this.widget._post),

          
          Row(children: [
            Container(
              child: 
              IconButton(
                icon: Icon(Icons.tag_faces), 
                color: iconColor, iconSize: 28, 
                onPressed: () {
                  setState(()  {
                    if (!(iconColor == Color(secondaryColor))) {
                      iconColor = Color(secondaryColor);
                      this.widget._post.reference.updateData({
                        'cheers': this.widget._post['cheers'] + 1,
                        'liked': true
                      });
                      
                    } else {
                      iconColor = Colors.black87;
                      this.widget._post.reference.updateData({
                        'cheers': this.widget._post['cheers'] - 1,
                        'liked': false
                      });
                    }
                  });
                }),
              ),
            Text(this.widget._post['cheers'].toString()),
            Container(child: IconButton(icon: Icon(Icons.comment), color: Colors.black87, iconSize: 28, onPressed: (){})),
            Spacer(flex: 1,),
            Container(child: IconButton(icon: Icon(Icons.report), color: Colors.black54, iconSize: 28, onPressed: (){})),
          ]),
        ],
      ),
    );
  }
    // return _actual(widget._post);
    // return _beta(_post);
    // return Text("Hello world");

  _actual (_post){
    Color iconColor = Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: Color(postColor),
        // border: Border.all(
        //    color: Colors.black,
        //     width: 2,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],

      ),
      width: 320,
      // margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            // icon
            Image.asset(_post['profile']),
            // username
            Text("@" + _post['username']),
            // dateposted
            Spacer(flex:1),
            Text(_post['date'])
            // Text(this._post['date'])
          ],
          ),
          // post description
          Container(
            padding: EdgeInsets.all(10),
            child: Text(_post['title'],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20)
            ),
          ),
          //post image
          PostDescription(_post),
          PostImg(_post),

          
          Row(children: [
            Container(
              child: 
              IconButton(
                icon: Icon(Icons.tag_faces), 
                color: iconColor, iconSize: 28, 
                onPressed: () {
                  setState(()  {
                    if (!(iconColor == Color(primaryColor))) {
                      print("color cjhange");
                      iconColor = Color(primaryColor);
                      print(iconColor);
                    }
                  });
                }),
              ),
            Text(_post['cheers'].toString()),
            Container(child: IconButton(icon: Icon(Icons.comment), color: Colors.black87, iconSize: 28, onPressed: (){})),
            Spacer(flex: 1,),
            Container(child: IconButton(icon: Icon(Icons.report), color: Colors.black54, iconSize: 28, onPressed: (){})),

            
            
            
            // cheer icon
            // comment icon
            // report button

          ]),
        ],
      ),
    );
  }
}

