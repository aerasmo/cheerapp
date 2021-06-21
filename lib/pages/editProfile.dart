import 'package:flutter/material.dart';
import 'package:cheerapp/vars.dart';
import 'package:cheerapp/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController wmmh = TextEditingController();
  TextEditingController aboutme = TextEditingController();
  TextEditingController puser = TextEditingController();
  TextEditingController profilecover = TextEditingController();
  TextEditingController profilename = TextEditingController();
  TextEditingController profilepic = TextEditingController();


  @override
  Widget build(BuildContext context) {

    _builder() {
      return new StreamBuilder(
          stream: FirebaseFirestore.instance.collection('profile').doc('user').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: new Text("Loading"));

            }
            var pdata = snapshot.data;
            profilename = TextEditingController(text: pdata['name']);
            aboutme = TextEditingController(text: pdata['about']);
            wmmh = TextEditingController(text: pdata['wmmh']);
            profilecover= TextEditingController(text: pdata['cover']);
            profilepic = TextEditingController(text: pdata['profile']);
            puser = TextEditingController(text: pdata['username']);
            
              return SingleChildScrollView(
                child: Container(
                  color: Color(grey),
                  margin: EdgeInsets.all(10),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container( // add post
                    padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                    color: Color(primaryColor),
                    child: Row(children: [
                      Text('Edit Profile ', style: TextStyle(
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
                    child: Text('Profile Name', style: TextStyle(
                        fontSize: h2,
                      ),
                    )
                  ),
                  Container( // Name
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: kElevationToShadow[5]
                      ),
                    child: TextField(
                        
                        controller: profilename,
                        decoration: InputDecoration(
                          // hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
                        )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 5, 5),
                    child: Text('Username', style: TextStyle(
                        fontSize: h2,
                      ),
                    )
                  ),
                  Container( // userame
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: kElevationToShadow[5]
                      ),
                    child: TextField(
                        
                        controller: puser,
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
                    Text('About me', style: TextStyle(
                        fontSize: h2,
                      ),
                    ),
                    Spacer(),
                    ],)
                  ),
                    Container( // description
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: kElevationToShadow[5]
                        ),
                      child: TextField(
                          controller: aboutme,
                          maxLines: 3,
                          decoration: InputDecoration(
                            // hintText: 'Search',
                            // hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
                          )
                      )
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 5, 5),
                      child: Row(children: [
                      Text('What makes me happy', style: TextStyle(
                          fontSize: h2,
                        ),
                      ),
                      Spacer(),
                      ],)
                    ),
                      Container( // description
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: kElevationToShadow[5]
                          ),
                        child: TextField(
                            controller: wmmh,
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
                      child: Text('Profile Avatar URL', style: TextStyle(
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
                        controller: profilepic,
                        decoration: InputDecoration(
                          // hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(15, 11, 15,11)
                        )
                    )
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
                    child: Row(children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('Cover photo URL', style: TextStyle(
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
                        controller: profilecover,
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
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color(primaryColor))
                          ),
                          child: Text("Save",
                            style: TextStyle(
                              color: Colors.black87,
                            )
                          ), 
                          onPressed: () {
                            if(profilename.text != "") {
                              print("Adding post to DB");
                              pdata.reference.updateData({
                                'username': puser.text,
                                'name': profilename.text,
                                'wmmh': wmmh.text,
                                'about': aboutme.text,
                                'cover': profilecover.text,
                                'profile': profilepic.text,
                              }).whenComplete(() => Navigator.pop(context));
                            }
                          }
                          
                        ),
                      ),
                    ],
                  ),
                  ]
                  )
                ),
              );
          }
      );
    }



    return Header(_builder, 2, false);
  }
}
