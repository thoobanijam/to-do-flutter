import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
   final String title;
  final String content;

  const NotePage({super.key,
   required this.title,
    required this.content,});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  int selectedDay = 0;
int selectedHour = 4;
int selectedMinute = 10;
String selectedPeriod = "AM";

bool isRemainder=false;
bool isDelete=false;

  final TextEditingController titleController = TextEditingController();
final TextEditingController noteController = TextEditingController();

  String _getDay(int day) {

    List<String> days = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun"
    ];

    return days[day - 1];
  }
  String _getMonth(int month) {

    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];

    return months[month - 1];
  }


@override
void initState() {
  super.initState();

  titleController.text = widget.title;
  noteController.text = widget.content;
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      
        leading: isRemainder ?
    IconButton(
      icon:Icon(Icons.close),
      onPressed: (){
        setState(() {
          isRemainder=false;
        });
      }, 
    )
        
       :  IconButton(
           icon: Icon(Icons.arrow_back),
          onPressed: (){

        Navigator.pop(context,

        {
"title" :titleController.text,
"content" : noteController.text,
        },
        );
        }
         ),
title: isRemainder ?
Text("Set Remainder",
style: TextStyle(fontSize: 18),
)
: null,

         actions: [
          if(isRemainder)
          TextButton(onPressed: (){

          }, child: Text("Done"),
          style: TextButton.styleFrom(
          backgroundColor: Colors.yellow,
        
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            )
         ),
          )

          else
          IconButton(
            onPressed: (){
             showDialog(
  context: context,
  builder: (context) {
    return Align(
      alignment: Alignment.topRight,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 250,
          margin: EdgeInsets.only(top: 70, right: 10),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                dense: true,
                leading: Icon(Icons.notifications_none),
                title: Text("Reminder"),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    isRemainder=true;
                  });
                },
              ),
              Divider(height: 1),
              ListTile(
                dense: true,
                leading: Icon(Icons.delete_outline),
                title: Text("Delete"),
                onTap: () {
                  showDialog(context: context, 
                  builder: (context){
return
 AlertDialog(
 titlePadding: const EdgeInsets.only(
    top: 30,
    bottom: 10,
    left: 20,
    right: 20,
  ),

  title: const Center(

    child: Text("Delete this note?"),
  ),

  content: Container(
    padding:  EdgeInsets.all(25),
margin: EdgeInsets.all(10),
    child: Column(

  mainAxisSize: MainAxisSize.min,
      children: [

        const Text(
          'This note will be moved to "Recently deleted" and kept for 60 days.',
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 10),

        ElevatedButton(
          onPressed: () {

          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),

          child: const Text("Delete"),
        ),


        const SizedBox(height: 20),


        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },

          child: const Text("Cancel"),
        ),

      ],
    ),
  ),
);

                  },
                  );
                  setState(() {
                    
                  });
                },
              ),
               Divider(height: 1),
               ListTile(
                dense: true,
                leading: Icon(Icons.lock_outline),
                title: Text("Lock"),
               ),
               Divider(height: 1),
               ListTile(
                dense: true,
                leading: Icon(Icons.share_outlined),
                onTap: () {
                  showDialog(context: context, 
                  builder: (context){
return AlertDialog(
  content: Container(
 child:
  Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text("Share as Image"),
      Divider(),
      Text("Share as Word"),
        Divider(),
      Text("Share as plain Text"),
    TextButton(onPressed: (){
      Navigator.pop(context);
    }, 
    child: Text("Cancel",
    ),
    style: TextButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 217, 196, 5),
    ),
    )
    ],
    
    )
  ),
);
                  },);
                },

                title:Text("Share"),
               ),
               Divider(height: 1,),
              
               ListTile(
                dense: true,
                leading: Icon(Icons.file_upload_outlined),

                title:Text("Export"),
                 onTap: () {
                  showDialog(context: context, 
                  builder: (context){
return AlertDialog(
  content: Container(
 child:
  Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text("Share as Image"),
      Divider(),
      Text("Share as Word"),
        Divider(),
      Text("Export as  Text"),
    TextButton(onPressed: (){
      Navigator.pop(context);
    }, 
    child: Text("Cancel",
    ),
    style: TextButton.styleFrom(
      foregroundColor: const Color.fromARGB(255, 217, 196, 5),
    ),
    )
    ],
    
    )
  ),
);
                  },);
                },

               ),
               Divider(height: 1,),

               ListTile(
                dense: true,
                leading: Icon(Icons.widgets_outlined),

                title:Text("General Widget"),
               ),
               Divider(height: 1,),

                ListTile(
                dense: true,
                leading: Icon(Icons.info_outline),

                title:Text("Note Info"),
               ),
               
            ],
          ),
        ),
      ),
    );
  

                });
            }, 
          icon: Icon(Icons.more_vert))
         ],

      ),
     body: isRemainder
? Column(
    
    children: [

    


      Center(
        child: SizedBox(
          height: 150,

          child: Row(

            mainAxisSize: MainAxisSize.min,

            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,


            children: [



              // DATE (Jul 23)
              SizedBox(
                width: 100,
                height: 150,

                child: ListWheelScrollView.useDelegate(

                  itemExtent: 50,

                  perspective: 0.01,

                  diameterRatio: 1.5,


                  onSelectedItemChanged: (index){

                    setState(() {

                      selectedDay = index;

                    });

                  },


                  childDelegate:
                  ListWheelChildBuilderDelegate(

                    childCount: 30,


                    builder: (context,index){


                      DateTime date =
                      DateTime.now()
                      .add(Duration(days:index));



                      bool isSelected =
                      selectedDay == index;



                      return Center(

                        child: Text(

                          "${_getMonth(date.month)} ${date.day}",


                          style: TextStyle(

                            fontSize: 20,


                            fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,


                            color: isSelected
                            ? Colors.black
                            : Colors.grey.shade400,


                          ),

                        ),

                      );

                    },

                  ),

                ),

              ),




              // HOUR (04)
              SizedBox(

                width: 50,

                height:150,


                child: ListWheelScrollView.useDelegate(

                  itemExtent:50,

                  perspective:0.01,

                  diameterRatio:1.5,


                  onSelectedItemChanged:(index){

                    setState(() {

                      selectedHour=index+1;

                    });

                  },


                  childDelegate:
                  ListWheelChildBuilderDelegate(

                    childCount:12,


                    builder:(context,index){


                      int hour=index+1;


                      bool isSelected =
                      selectedHour == hour;



                      return Center(

                        child: Text(

                          hour
                          .toString()
                          .padLeft(2,"0"),


                          style:TextStyle(

                            fontSize:22,


                            fontWeight:isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,


                            color:isSelected
                            ? Colors.black
                            : Colors.grey.shade400,


                          ),

                        ),

                      );

                    },

                  ),

                ),

              ),




              // :
              SizedBox(

                width:25,

                height:150,


                child:Center(

                  child:Text(

                    ":",

                    style:TextStyle(

                      fontSize:25,

                      fontWeight:FontWeight.bold,

                    ),

                  ),

                ),

              ),




              // MINUTE (03)
              SizedBox(

                width:55,

                height:150,


                child: ListWheelScrollView.useDelegate(

                  itemExtent:50,

                  perspective:0.01,

                  diameterRatio:1.5,


                  onSelectedItemChanged:(index){

                    setState(() {

                      selectedMinute=index;

                    });

                  },


                  childDelegate:
                  ListWheelChildBuilderDelegate(

                    childCount:60,


                    builder:(context,index){


                      bool isSelected =
                      selectedMinute == index;



                      return Center(

                        child:Text(

                          index
                          .toString()
                          .padLeft(2,"0"),


                          style:TextStyle(

                            fontSize:22,


                            fontWeight:isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,


                            color:isSelected
                            ? Colors.black
                            : Colors.grey.shade400,


                          ),

                        ),

                      );

                    },

                  ),

                ),

              ),




              // AM PM
              SizedBox(

                width:65,

                height:150,


                child:ListWheelScrollView.useDelegate(

                  itemExtent:50,

                  perspective:0.01,

                  diameterRatio:1.5,


                  onSelectedItemChanged:(index){

                    setState(() {

                      selectedPeriod =
                      index==0
                      ? "AM"
                      : "PM";

                    });

                  },


                  childDelegate:
                  ListWheelChildBuilderDelegate(

                    childCount:2,


                    builder:(context,index){


                      String period =
                      index==0
                      ? "AM"
                      : "PM";



                      bool isSelected =
                      selectedPeriod == period;



                      return Center(

                        child:Text(

                          period,


                          style:TextStyle(

                            fontSize:22,


                            fontWeight:isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,


                            color:isSelected
                            ? Colors.black
                            : Colors.grey.shade400,


                          ),

                        ),

                      );

                    },

                  ),

                ),

              ),


            ],

          ),

        ),

      ),
      SizedBox(height: 20,),
Container(

  padding: EdgeInsets.all(20),
  margin: EdgeInsets.all(20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color:Colors.white,
  ),
  width: double.infinity,
  height: 130,
  
  child: Row(
    
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text("Remainder mode",style: TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(width: 40,),
     
      Column(
        
        children: [
          
          
Row(
  children: [
    Padding(padding: EdgeInsetsGeometry.symmetric(
      horizontal: 10,
      vertical: 5,
    ),),
    Icon(Icons.circle_outlined,
    color: const Color.fromARGB(255, 238, 216, 18),
    fontWeight: FontWeight.bold,
    ),
SizedBox(width: 10,),
    Text("Notification remainder")
  ],
),
SizedBox(height: 20,),
Row(
  children: [
     Padding(padding: EdgeInsetsGeometry.symmetric(
    horizontal: 1,
      vertical: 5,
    ),),
    Icon(Icons.circle_outlined,
    color:Colors.grey,
    fontWeight: FontWeight.bold,
    ),
   SizedBox(width: 10,),
    Text("Alarm remainder",style: TextStyle(),)
  ],
),

        ],
      ),
    ],
  ),
),
    ],

  )     : Padding(
        padding: EdgeInsets.all(20),
        child: Column(
           children: [
       TextField(
        controller: titleController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: "Title",
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
       ),
SizedBox(height: 10,),

Expanded(
  child: TextField(
controller: noteController,
textCapitalization: TextCapitalization.sentences,
expands: true,
maxLines: null,
keyboardType: TextInputType.multiline,
decoration:InputDecoration(
  border: InputBorder.none,
),
  ),),
           ],
        ),
      ),
    );
  }
}