import 'package:flutter/material.dart';
import 'package:cheerapp/vars.dart';
import 'package:cheerapp/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';


class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Color(grey),
      height: 55,
      child: Row(
        children: [
          Spacer(flex:3),
          Container(
            width: 310,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: kElevationToShadow[5]
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
              )
            ),
          ),
          IconButton(icon: Icon(Icons.search), onPressed: null),
          Spacer()
        ],
      ),
    );
  }
}
class Search extends StatefulWidget {
  // UPDATE TO POSTS
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Header(_search, 1, false);
  }
  _scrollListener() {
    print(_controller.offset);
    // if (_controller.offset > 195.00) {
    //   setState(() {
    //     topMargin = 50;
    //   });
    // } 
    // // print(topMargin);
    // if (_controller.offset <= 195.00) {
    //   setState(() {
    //     topMargin = 0;
    //   });
    // }
  }
  _search() {
    //TODO sample UI
    return CustomScrollView(
      controller: _controller,

      slivers: [
          SliverToBoxAdapter(child: SearchBar(),),
          SliverToBoxAdapter(child: Hobbies(),),
          // SearchBar(),
          // Hobbies(),
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: RecommendedHeader(
              minExtent: 60,
              maxExtent: 60,
            )
            ),
           SliverFillRemaining(
            child: Recommended() 
          ),
        ] 
      );
  }
}
class Recommended extends StatelessWidget {
  final CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return  Container(
            child: StreamBuilder<QuerySnapshot>(
            stream: posts.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return new Text("There is no Post");
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Post(snapshot.data.docs[index]);
                }
              );
            }
            )
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
     return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('profile').doc('user').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: new Text("Loading"));
        }
        var pdata = snapshot.data;
      if ((!_post['liked']) & (pdata['username'] != _post['username'])) {
          print("liked" + _post["title"]);
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
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
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
                  padding: EdgeInsets.all(10),
                  child: Text(this.widget._post['title'],
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20)
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
      return Container();
    }
  );
  }
}
          // Text("Recommended Posts", style: TextStyle(fontSize: 24),),

class RecommendedHeader implements SliverPersistentHeaderDelegate {
  RecommendedHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  _recommendedHeader() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 60,
      decoration: BoxDecoration(
        color: Color(navColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Text("Recommended Posts", style: TextStyle(fontSize: 24)));
  }
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsCurrent) {
    return _recommendedHeader();
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


class Hobbies extends StatelessWidget {
  final CollectionReference hobbiesRef = FirebaseFirestore.instance.collection('hobbies');
  @override

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            height: 60,
            decoration: BoxDecoration(
              color: Color(navColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 6,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            
            child:  Text("Discover Hobbies", style: TextStyle(fontSize: 24),)),
          Container(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              height: 200,
              child: _hobbies(context)
            ),
          ),

        ],
      ),
    );      
  }
  _hobbies(context) {
    print("wtf");
    return StreamBuilder<QuerySnapshot>(
        stream: hobbiesRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return new Text("There is no Post");
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return HobbyThumbnail(snapshot.data.docs[index]);
            }
          );
        }
    );
  }
}
class HobbyThumbnail extends StatefulWidget {
  final hobby;
  HobbyThumbnail(this.hobby);

  @override
  _HobbyThumbnailState createState() => _HobbyThumbnailState();
}

class _HobbyThumbnailState extends State<HobbyThumbnail> {
  @override
  Widget build(BuildContext context) {
    print(this.widget.hobby);
    if (this.widget.hobby['added']){
      return Container();
    }
    return Container(
      width: 130,
      padding:EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.widget.hobby['name'], style: TextStyle(fontSize: 19),),
          // Text(this.hobby['image']),
          Container(
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(this.widget.hobby['image'])
            )
          ),
          Container(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  this.widget.hobby.reference.updateData({
                    'added': true
                  });
                });

              }, 
              child: Text("Follow"))
          ,)
        ],
      ),
    );
  }
}

// class SearchHeader extends StatelessWidget {
//   final Function func;

//   SearchHeader(this.func);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
    
//     backgroundColor: Color(navColor),
//     appBar: 
//     AppBar(
//       iconTheme: IconThemeData(
//         color: Colors.black54, //change your color here
//       ),
//       title: Text("CheerAPP",
//         style: TextStyle(
//         color: Colors.black54,
//         fontSize: 23.0
//         ),
//       ),
//       centerTitle: true,
//       backgroundColor: Color(primaryColor),
            
//     ),
//     body: this.func(),
//     // floatingActionButton: FloatingActionButton(
//     //   onPressed: () {},
//     //   child: Icon(
//     //     Icons.add,
//     //     color: Colors.black87
//     //   ),
//     //   backgroundColor: Color(primaryColor)
//     // ),
//     bottomNavigationBar: NavBar(1),
//   ); 
//   }
// }