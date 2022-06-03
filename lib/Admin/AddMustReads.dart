import 'package:budget/Admin/adminhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class addMustReads extends StatefulWidget {
  const addMustReads({Key? key}) : super(key: key);

  @override
  _addMustReadsState createState() => _addMustReadsState();
}

class _addMustReadsState extends State<addMustReads> {
  @override
  final TextEditingController Articlename=TextEditingController();
  final TextEditingController Authorname=TextEditingController();
  final TextEditingController Websitename=TextEditingController();
  final TextEditingController SiteLink=TextEditingController();
  final TextEditingController ArticleType=TextEditingController();
  final TextEditingController WebsiteLink=TextEditingController();
  final TextEditingController Imagelink=TextEditingController();
  Widget build(BuildContext context) {
    return
        Scaffold(
          resizeToAvoidBottomInset: false,


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              height:MediaQuery.of(context).size.height,
              color: Colors.deepPurple[200],
              child:Stack(
                  children:<Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child:Material(
                        color: Color.fromRGBO(255,255, 255, 0.4),
                        borderRadius: BorderRadius.all(Radius.circular(200.0)),
                        child: Container(
                          width:500.0,
                          height: 800.0,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      widthFactor: 0.5,
                      heightFactor: 0.5,
                      child:Material(
                        color: Color.fromRGBO(255,255, 255, 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(200.0)),
                        child: Container(
                          width:400.0,
                          height: 800.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Center(
                        child:Container(
                          width: 600,
                          height: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,// fixes the elements in the column to the center
                            children:<Widget>[

                              Container(
                                child: Text(
                                  'Add Must Reads',
                                  style:TextStyle(
                                    fontSize: 30.0,
                                    backgroundColor: Colors.deepPurple[200],
                                    decoration: TextDecoration.none,
                                    color: Colors.white ,

                                  ),),),






                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:Articlename,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Article Name",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:ArticleType,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Article Type",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:Authorname,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Author Name",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:Websitename,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "Website Name",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              Container(

                                width: 250.0,
                                height: 50.0,
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),//rounding the textfield borders
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.lock),
                                      ),
                                      Container(
                                        width:200.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: TextFormField(


                                            controller:SiteLink,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,// Removes the underline below the text
                                              hintText: "WebsiteLink",
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            style:TextStyle(
                                              fontSize: 20.0,
                                              color:Colors.black,
                                            ) ,

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width:150.0,
                                      child: RaisedButton(
                                        onPressed:(){



                                          addMustRead( Articlename.text, ArticleType.text, Authorname.text , Imagelink.text, SiteLink.text, Websitename.text);




                                          Articlename.clear();
                                          Websitename.clear();
                                          SiteLink.clear();
                                          Imagelink.clear();
                                          Authorname.clear();
                                          Websitename.clear();
                                          ArticleType.clear();
                                        },



                                        color:Colors.deepPurple,
                                        textColor:Colors.white ,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                        child: Text(
                                          "Add",
                                          style:TextStyle(
                                            fontSize: 20.0,

                                          ),
                                        ),

                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:150.0,
                                    child: RaisedButton(
                                      onPressed:(){
                                        Navigator.push(context,MaterialPageRoute(builder:(context)=>AdminHome()));
                                      },
                                      color:Colors.deepPurple,
                                      textColor:Colors.white ,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                      child: Text(
                                        "Home",
                                        style:TextStyle(
                                          fontSize: 20.0,

                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ),


                        ),

                      ),
                    ),
                  ]
              ),


            ),
          ],
        ),
      ),);
  }

  Future<void> addMustRead( String Articlename,String ArticleType, String Authorname, String Imagelink,String SiteLink, String Websitename) async {

    CollectionReference users = FirebaseFirestore.instance.collection('Admin');
    final user= FirebaseAuth.instance.currentUser!;
    var now = DateTime.now();
    // Call the user's CollectionReference to add a new user
    return await users.doc("MustReads").collection("MustReads").add({
     "Articlename":Articlename,
      "ArticleType":ArticleType,
      "Authorname":Authorname  ,
      "Wesitename":Websitename,
      "WebsiteLink":SiteLink,
      "ImageLink":Imagelink,
      "dateuploaded":now
    })
        .then((value) { Fluttertoast.showToast(
        msg: 'added successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    })
        .catchError((error) { Fluttertoast.showToast(
        msg: 'Failed to add details: $error.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
    });
  }

}

