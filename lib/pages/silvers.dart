// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cheerapp/vars.dart';

class SilverHome extends StatelessWidget {
  List _buildList (int count) {
    List <Widget> listItems = List();

    for (int i = 0; i < count ; i ++) {
      listItems.add(
          Container(
            child: Card(
              
              color: Colors.grey.shade800,
              child: Text(
                'Card ${i.toString()}',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[200]

                )
              )
            ,)
        ));
    }
    return listItems;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(navColor),
    appBar: 
    AppBar(
      title: Text("TEST",
        style: TextStyle(
        color: Colors.black54,
        fontSize: 23.0
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(primaryColor),
            
    ),
    body: _slivers(),
    );
  }
  _slivers() {
    return 
    CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: Container(
            // padding: EdgeInsets.all(10),
            child: FlexibleSpaceBar(
              background: Image.asset('posts/yuri-peace.jpg', fit: BoxFit.cover),
            ),
          ),

        ),
        SliverList(
          delegate: SliverChildListDelegate(_buildList(20)),
        )
      ],  
    );
  }
}