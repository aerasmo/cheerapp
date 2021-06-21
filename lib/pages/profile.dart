import 'package:flutter/material.dart';
import 'package:cheerapp/vars.dart';
import 'package:cheerapp/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class MyPosts extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
      
//     );
//   }
// }

double topMargin = 0;
//todo widget for about info container
class About extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
      final _about = [
      Container(
        padding: EdgeInsets.fromLTRB(25, 15, 15, 10),
        child: // info text 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
          Row(children: [
            Text('About Me', style: TextStyle(fontSize: h2), textAlign: TextAlign.left,),
            Spacer(),
            Text('Edit Profile'),
            IconButton(icon: Icon(Icons.edit, size: 20), 
            onPressed: () => Navigator.pushNamed(context, '/edit'),)
          ],),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('profile').doc('user').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                 return Center(child: new Text("Loading"));

              }
              var pdata = snapshot.data;
              return Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(pdata['about'], 
                  style: TextStyle(color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,),
              );
            }
          ),
        ],)
      ),
      Container(
        padding: EdgeInsets.fromLTRB(25, 10, 15, 20),
        child: // info text 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
          Row(children: [
            Text('What Makes Me Happy', style: TextStyle(fontSize: h2), textAlign: TextAlign.left,),
          ],),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('profile').doc('user').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: new Text("Loading"));
              }
              var pdata = snapshot.data;
              return Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(pdata['wmmh'], 
                  style: TextStyle(color: Colors.black, fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,),
              );
            }
          ),
          ]
        )
      )
    ];
    return 
      ProfileTabs(_about);
  }
}
class ProfileTabs extends StatefulWidget {
  final _colitems;

  ProfileTabs(this._colitems);

  @override
  _ProfileTabsState createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  @override
  Widget build(BuildContext context) {
    return _builder(widget._colitems);

    }

    _builder(items) {
      return 
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
               return items[index];
            }
          );
    }
}

class Hobbies extends StatelessWidget {
  final CollectionReference hobbiesRef = FirebaseFirestore.instance.collection('hobbies');
  
  // final _hobbies = [
  //   Hobby(hobbies[0]),
  //   Hobby(hobbies[1]),
  //   Hobby(hobbies[2]),
  // ];
  @override
  Widget build(BuildContext context) {
    // return ProfileTabs(_posts);
      _hobbies() {
      return StreamBuilder<QuerySnapshot>(
          stream: hobbiesRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Text("There is no Post");
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return Hobby(snapshot.data.docs[index]);
              }
            );
          });
      }
      return _hobbies();
  }
}
class Posts extends StatelessWidget {

  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  // final _posts = [
  //   PostMini(data[0]),
  //   PostMini(data[1]),
  //   PostMini(data[2]),
  // ];
  @override
  Widget build(BuildContext context) {
    // return ProfileTabs(_posts);
      _userposts() {
      return StreamBuilder<QuerySnapshot>(
          stream: posts.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Text("There is no Post");
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return PostMini(snapshot.data.docs[index]);
              }
            );
          });
      }
      return _userposts();
  }
}
class Likes extends StatelessWidget {
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  // TODO fetch from database
  // final _posts = [
  //   LikedPost(data[3]),
  //   LikedPost(data[1]),
  //   LikedPost(data[2]),
  //   LikedPost(data[2]),


  // ];
  @override
  Widget build(BuildContext context) {
    // return ProfileTabs(_posts);
      _likedposts() {
      return StreamBuilder<QuerySnapshot>(
          stream: posts.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Text("There is no Post");
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return LikedPost(snapshot.data.docs[index]);
              }
            );
          });
      }
      return _likedposts();
  }
}
// tab pages
class ProfileTabPages extends StatelessWidget {
  static final List<Tab> tabs = <Tab> [
    Tab(child: About()),
    Tab(child: Hobbies(),),
    Tab(child: Posts(),),
    Tab(child: Likes(),),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}


class ProfileScaffold extends StatelessWidget {

  final Function func;

  ProfileScaffold(this.func);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: ProfileTabPages.tabs.length,
      child: Scaffold(
      
      resizeToAvoidBottomPadding: false, // fixes?
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
      body: this.func(),
      bottomNavigationBar: NavBar(2)
      ),
    ); 
  }
}

//----------------------------------------------------------------------------
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController _controller;
  // final CollectionReference profile = FirebaseFirestore.instance.collection('profile');

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }
  _scrollListener() {
    if (_controller.offset > 195.00) {
      setState(() {
        topMargin = 50;
      });
    } 
    // print(topMargin);
    if (_controller.offset <= 195.00) {
      setState(() {
        topMargin = 0;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

  _profileHeader() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('profile').doc('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: new Text("Loading"));
        }
        var pdata = snapshot.data;
        print(pdata['name']);
        return Container(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                height: 150,
                child: Stack(
                  
                  children: [
                  Container(
                    width: double.infinity,
                    child: FittedBox(
                      child: Cover(pdata), 
                      fit: BoxFit.fill),
                  ),
                  // Align(
                    // alignment: Alignment.topRight,
                    // child: IconButton(icon: Icon(Icons.edit), color: Colors.black87, onPressed: (){},)
                  // ),
                  Align( // profile line
                    alignment: Alignment.bottomRight,
                      child: Container(
                      width: double.infinity,
                      height: 25,
                      color: Color(secondaryColor),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: 
                
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text("@" + pdata['username'],
                            style: TextStyle(
                              color: Colors.white70
                            ),
                          
                          ),
                        )
                      ),
                    ),
                  ),
                  // image
                  Positioned(
                    top: 55,
                    left: 25,
                    child: 
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                        ]
                      ),
                      child: Avatar(pdata)
                      
                      )
                  ),


                ],
                overflow: Overflow.visible,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(22, 10, 20, 10),

                color: Color(primaryColor),
                child: Row(children: [
                  Text(pdata['name'], style: TextStyle(fontSize: 20),),
                  Spacer(flex:4),
                  Text("Followers:  " + pdata['followers'].toString()),
                  Spacer(flex:1),
                  Text("Following:  " + pdata['following'].toString()),
                ]),
              ),
            ]
          )
        );
      }
    );
  }

  _profile(){
    return CustomScrollView(
          controller: _controller,
          slivers: [
            SliverToBoxAdapter(
              child: _profileHeader()
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: ProfileHeader(
                minExtent: 60,
                maxExtent: 60,
              ),
            ),

          SliverFillRemaining(
            child: 
              Container(
                margin: EdgeInsets.only(top: topMargin),
                child: TabBarView(
                  children: ProfileTabPages.tabs
                ),
              ),
          ),
        ]
      );
    }
      return ProfileScaffold(_profile);
  }
}
class ProfileHeader implements SliverPersistentHeaderDelegate {
  ProfileHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  _profileHeader() {
    return Container(
            color: Colors.white,
            child:
            TabBar(
              indicatorColor: Color(secondaryColor),
              labelColor: Colors.black87,
              tabs: [
              Tab(text: "About"),
              Tab(text: "Hobbies",),
              Tab(text: "Posts",),
              Tab(text: "Likes",),
            ],)
        );
  }
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsCurrent) {
    return _profileHeader();
  }
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
  @override
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => null;
  @override
  TickerProvider get vsync => null;

}
