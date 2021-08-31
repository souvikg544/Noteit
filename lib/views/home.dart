//import 'dart:js';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteit/helper/drawer.dart';

import 'package:noteit/services/database.dart';

 
class myhome extends StatefulWidget {
   String userName;
   String userEmail;
   String userimage;
   myhome({required this.userName,required this.userEmail,required this.userimage});

   @override
   _myhomeState createState() => _myhomeState();

 }
 
  

 
 class _myhomeState extends State<myhome> {
   String date="";
   String uId = "General";
   

   
        
   @override
  void initState() {
    var now=DateTime.now();
    //date="${now.day}th ${HelperFunctions.getmonth(now.month)}";
    
    setState(() {
   
    });
    super.initState();
  }

  Widget taskList(String uid){
    Stream <QuerySnapshot> taskstream=FirebaseFirestore.instance.collection("users")
        .doc(uId)
        .collection("tasks")
        .snapshots();
     DatabaseServices().getTasks(uid).then((val){
          taskstream=val;
          });
    

    return StreamBuilder<QuerySnapshot>(
      stream: taskstream,
      builder: (context, snapshot){
        return snapshot.hasData ?
        ListView.builder(
          scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 16),
            itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                return TaskTile(
                  snapshot.data!.docs[index].get("isCompleted"),
                  snapshot.data!.docs[index].get("task"),
                  snapshot.data!.docs[index].id,
                  uid
                );
              }): Container();
      },
    );

  }

   @override
   Widget build(BuildContext context) {
 
     final myController = TextEditingController();
     final control1 = TextEditingController();
     

     return Scaffold(
       drawer:mydrawer(
         url: widget.userimage,
         username: widget.userName,
         email: widget.userEmail
         
       ),
       appBar:AppBar(
       leading:Image.asset("images/Background.png"),
       title: Text("NoteIt"),
       backgroundColor: Colors.deepPurple,
       ),
       body:Padding(
           padding: const EdgeInsets.all(10.0),
           
             child: SingleChildScrollView(
               scrollDirection:Axis.vertical,
               child: Container(
                 //width: 600,
                 child: Column(
                   children: [
                    //Text("Hey ${widget.userName}...Stay the beautiful person you are!",style: TextStyle(color:Color(0xff364958),fontSize:18,fontWeight: FontWeight.bold),),
                    //Text(date,style: TextStyle(color:Color(0xff364958),fontSize:18,),),
                    
                    TextFormField(
                        controller: control1,
                          decoration: InputDecoration(
                            labelText: "Room code to share with your friend"
                            ), 
                      ),
                      SizedBox(height: 10,),
                       ElevatedButton(
                       child: Text("Enter"),
                       onPressed: (){
                        if(control1.text !=null || control1.text.toString().trim() !=""){
                          uId=control1.text;
                          setState(() {
                            uId=control1.text;
                          });
                        
                        }
                       }
                       ),
             
                      TextFormField(
                        controller: myController,
                          decoration: InputDecoration(
                            labelText: "Notes"
                            ), 
                      ),
                    
                       SizedBox(height: 10,),
                      ElevatedButton(
                       child: Text("Add"),
                       onPressed: (){
                        if(myController.text !=null || myController.text.toString().trim() !=""){
                          Map <String,dynamic>taskmap={
                            "task":myController.text.toString(),
                            "isCompleted":false
                          };
                          DatabaseServices().createtask(uId,taskmap);
                          myController.text="";
                    
                        }
                       },
                      ),
                      taskList(uId)
                      
                      
                   ],   
                 )
                 
                 
               ),
             ),
           ),
        
     );
   }
  
 }


class TaskTile extends StatefulWidget {
  final bool isCompleted;
  final String task;
  final String documentId;
  final String uId;
  TaskTile(this.isCompleted,this.task,this.documentId,this.uId);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      //height:50,
      child: Card(
        shadowColor: Colors.blue,
        elevation: 3.0,
        color: Colors.lightBlue,
        
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:Row(
              children: [
                GestureDetector(
                  onTap: (){
                
                    Map<String,dynamic> taskMap = {
                      "isCompleted" : !widget.isCompleted
                    };
                
                    DatabaseServices().updateTask(widget.uId, taskMap, widget.documentId);
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87, width: 1),
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child:
                    widget.isCompleted ?
                    Icon(Icons.check, color: Color(0xff063701),) : Container(),
                  ),
                ),
                
                SizedBox(width:4,),
                  Text(
                      widget.task,
                      style: TextStyle(
                        color: widget.isCompleted ? Colors.black87 :
                            Colors.black87.withOpacity(0.7) ,
                        fontSize: 13,
                        fontWeight:FontWeight.w500,
                        decoration: widget.isCompleted ?
                            TextDecoration.lineThrough :
                            TextDecoration.none
                      ),
                    ),
                 
                Spacer(),
                GestureDetector(
                  onTap: (){
                    DatabaseServices().deleteTask(widget.uId, widget.documentId);
                  },
                  child: Icon(
                    Icons.close, size: 13, color: Colors.black87.withOpacity(0.7)
                  ),
                )
              ],
            
          ),
        ),
      ),
    );
  }
}
