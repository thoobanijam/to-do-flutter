import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'note_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('tasksBox');
  await Hive.openBox('notesBox');



  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}


class MainApp extends StatefulWidget {
   MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

String displayText="No Text";
TextEditingController textController =TextEditingController();
List<Map<String, dynamic>> taskList = [];

void saveTasks() async {

  var box = Hive.box('tasksBox');

  print("Before save: ${box.keys}");

  await box.put('tasks', taskList);

  print("After save: ${box.keys}");
  print("Stored Data: ${box.get('tasks')}");
}
//load task
void loadTasks() {

  var box = Hive.box('tasksBox');

  var savedTasks = box.get('tasks');


  print("Saved Tasks From Hive: $savedTasks");


  if(savedTasks != null){

    taskList = List<Map<String,dynamic>>.from(
      savedTasks.map(
        (e)=>Map<String,dynamic>.from(e)
      )
    );


    taskList.sort((a,b){

      return DateTime.parse(b["createdAt"])
          .compareTo(
            DateTime.parse(a["createdAt"])
          );

    });

  }


  setState(() {});

}
List<Map<String, dynamic>> noteList = [];
TextEditingController noteController =TextEditingController();

bool isSearching=false;
TextEditingController searchController =TextEditingController();
List<Map<String,dynamic>> filteredTasks = [];
 
 List<Map<String, dynamic>> footeR =[
  { "icon": Icons.note,
    "name": "Note",},
  {"icon": Icons.check_box,
    "name": "To-do",},
  {"icon": Icons.person,
    "name": "Me",},
 ];

List<Map<String, dynamic>> searchedTask = [

  {
    "icon": Icons.note,
    "name": "Note",
  },

  {
    "icon": Icons.check_box,
    "name": "To-do",
  },

  {
    "icon": Icons.alarm,
    "name": "Reminder",
  },

  {
    "icon": Icons.image,
    "name": "Image",
  },

  {
    "icon": Icons.mic,
    "name": "Record",
  },

  {
    "icon": Icons.draw,
    "name": "Doodle",
  },

  {
    "icon": Icons.table_chart,
    "name": "Table",
  },

  {
    "icon": Icons.video_camera_back,
    "name": "Video",
  },

  {
    "icon": Icons.audio_file,
    "name": "Audio",
  },

];

bool isOutlined =false;
bool isNote =true;
bool isTodo=false;
bool isMe=false;
bool isSlidebarOpen = false;
bool isAutoSync = false;

void searchTask(String value){

  setState(() {

    filteredTasks = taskList
        .where((task){

          return task["task"]
              .toString()
              .toLowerCase()
              .contains(
                value.toLowerCase()
              );

        })
        .toList();

  });

}
  @override
void initState() {
  super.initState();

  loadTasks();
  loadNotes();
}

//load note
void loadNotes() {

  var box = Hive.box('notesBox');

  var savedNotes = box.get('notes');

 print("Saved Notes From Hive: $savedNotes");

  if(savedNotes != null){

    noteList = List<Map<String,dynamic>>.from(
      savedNotes.map(
        (e)=>Map<String,dynamic>.from(e)
      )
    );


    noteList.sort((a,b){

      return DateTime.parse(b["createdAt"])
          .compareTo(
            DateTime.parse(a["createdAt"])
          );

    });

  }


  setState(() {});

}

//save notes
void saveNotes() async {

  var box = Hive.box('notesBox');

  await box.put('notes', noteList);
  await box.flush();

  print("Saved Notes: ${box.get('notes')}");

}
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
        appBar: AppBar(
         
  
         leading: isSearching
         ?null
          :isMe ?
        
      Container(
         
          
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              
              width: 40,
              height: 40,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:Colors.grey,
               
              ),
             child: Stack(
  alignment: Alignment.center,
  children: [
    Icon(
      Icons.person,
      color: Colors.white,
      size: 28,
    ),
  ],
),
           
        )
 : isNote ?
 InkWell(
  onTap: () {
setState(() {
  isSlidebarOpen=false;
});
  },
    
   child: Container(
            width: 50,
            height: 50,
           
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(color:Color.fromARGB(255, 63, 62, 62),
            borderRadius: BorderRadius.circular(7)),
            child:Stack(
              alignment: Alignment.center,
              children: [
   Image.asset(
    "assets/images/y.jpg",
    width: 32,
    height: 32,
    
   ),
              ],
            ),
          ),
 )



      :  isTodo
         ?Container(
          width: 38,height: 38,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(226, 96, 94, 94)
          ),
          child: Stack(
            alignment: Alignment.center,
           children: [
             Icon(Icons.circle_rounded,
            color: const Color.fromARGB(255, 201, 184, 34),
            size: 35,

            ),
            Icon(Icons.check,
            color: const Color.fromARGB(225, 0, 0, 0),

            )
           ],
           
          ),
          
         )

      
      

         : null,
          
          
          title:isSearching
          ?
      
            Row(
              children: [
                
                Expanded(
                  
                  child: TextField(
                    
                    controller: searchController,
decoration: InputDecoration(border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),

),
prefixIcon: Icon(Icons.search,
color:Colors.grey,
),
labelText: "Search",
fillColor: Colors.grey,
filled: true


),
autofocus: true,
onChanged: searchTask,
                ),
                
                ),
                if(isSearching)
    TextButton(onPressed: (){
setState(() {
  isSearching=false;
  searchController.clear();
  filteredTasks=taskList;
});
    }, child: Text("Cancel",style: TextStyle(
      color: const Color.fromARGB(255, 177, 160, 4),
    ),
    )),
   

              ],
            
             
          
          )

   
          
          
          
          
          
         : Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    if (isNote)
      InkWell(
        
        onTap: (){
setState(() {
  isSlidebarOpen= true;
});
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "All",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 2),
            Icon(
              Icons.arrow_right,
              size: 22,
            ),
          ],
        ),
        
      )
    else
      Text(
        isTodo ? "To-Do" : "Sign in to vivo account",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),

    Text(
      isNote
          ? "${noteList.length} ${noteList.length == 1 ? "note" : "notes"}"
          : isTodo
              ? "${taskList.length} to-dos"
              : "Welcome to Notes",
      style: const TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 108, 107, 107),
      ),
    ),
  ],
),
          actions: [
          if(!isSearching)
           IconButton(
            onPressed: (){
setState(() {
  isSearching=true;
              filteredTasks = taskList;
});
           },
           icon: Icon(Icons.search),
           ),
if(!isSearching)
          Builder(
            builder: (dialogContext){
              return  IconButton(
               
               
            onPressed: (){
            showDialog(
              context: dialogContext,
             builder: (context){
return AlertDialog(
  title: Center(
    child: Text("Sort to-do list",
    style: TextStyle(fontWeight: FontWeight.bold,
    ),
    ),
    
  ),
  content:Container(
    padding: EdgeInsets.all(5),
    margin: EdgeInsets.all(5),
    child: Column(
      mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
      padding: EdgeInsets.all(5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
            width: 250, // fixed space for text
            child: Text(
              "By reminder time (latest first)",
            ),
          ),
           Icon(Icons.circle_outlined,
           color:const Color.fromARGB(255, 106, 104, 104)),
            ],
          ),
           Divider(),
          
        ],
      ),
    ),
     Container(
    padding: EdgeInsets.all(5),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Row(
      children: [
       SizedBox(
        width: 250,
        child:Text("By remainder time(earlier first)"),
       )  ,
       
         Icon(Icons.circle_outlined,
       color:const Color.fromARGB(255, 106, 104, 104))
      ],
    ),
     
     Divider(),
      ],
     ),
     ),
    Container(
    padding: EdgeInsets.all(5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    Row(
      children: [
        
         SizedBox(width: 250,
         child: Text("By remainder time(newest first)"),),
         Icon(Icons.circle_outlined,
         color:const Color.fromARGB(255, 106, 104, 104)
         )
      ],
    ),
    Divider(),
      ],
    ),
    ),
     Container(
    padding: EdgeInsets.all(5),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Row(
        children: [
          SizedBox(
            width: 250,
            child:   Text("By remainder time(oldest first)"),
          ),
          Icon(Icons.circle_outlined,
          color:const Color.fromARGB(255, 106, 104, 104))
        ],
       ),

         Divider(),
      ],
     ),
     ),
    Container(
    padding: EdgeInsets.all(5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: [
         Row(
          children: [
            SizedBox(
              width: 250,
              child:  Text("Custom drag"),
            ),
            Icon(Icons.circle_outlined,
             color:const Color.fromARGB(255, 106, 104, 104)
            )
          ],
         ),
          
      ],
    ),
    ),
    ],
      ),
  ),
    actions: [
Center(
  child: TextButton( onPressed:(){
Navigator.pop(context);
  }, child: Text("Cancel",
  style: TextStyle(color:const Color.fromARGB(255, 226, 203, 4)),
  ))
)
      
      
    ],
  );
             },

             
             );

            }
           , icon: Icon(Icons.menu),
           );
            }
            )
          ],
        ),
        
        
        body:  isMe ?
        Column(

          children: [
          
            Container(
padding: EdgeInsets.all(25),
margin: EdgeInsets.all(20),
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.white,
),
  child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text("My Record",style: TextStyle( fontSize: 16,
              fontWeight: FontWeight.bold),),
              Row(
                children: [
                  Column(
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${noteList.length}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
               SizedBox(width: 10),
               Column(
                children: [
                   Text(
                    "To-do",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${taskList.length}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
               ),
                ],
              ),
    ],
   ),
            ),
           
           SizedBox(height:1),
           //data sync
           Container(
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.all(8),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Data Sync"),
                Text("Learn more",style: TextStyle(color:const Color.fromARGB(255, 236, 213, 8)),)
              ],
             ),
           ),
          
          //auto-sync container
         
          Container(
            padding: EdgeInsets.all(25),
            margin: EdgeInsets.all(10),
            
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color:Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
              children: [
                Expanded(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Auto-sync notes",style: TextStyle( fontSize: 16,
              fontWeight: FontWeight.bold,),),
                          SizedBox(height: 5),
                      Text("Note are automatically synced to the cloud in real time,so you can view and edit them across all yours device",
                      style: TextStyle(fontSize: 12,
              color: Colors.grey,),)
                    ],
                  ),
                ),
Switch(value: isAutoSync, 
onChanged: (value){
  setState(() {
    isAutoSync=value;
  });
   print("Auto Sync: $isAutoSync");
}
)
              ],
            ),
          ),
          //edit motes
           
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    Text("Edit notes on your PC or iPad",style: TextStyle(
                      fontWeight:FontWeight.w400
                    ),),
                    Icon(Icons.chevron_right )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    Text("Recently deleted",style: TextStyle(
                      fontWeight:FontWeight.w400
                    ),),
                    Icon(Icons.chevron_right )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                  children: [
                    
                    Text("Settings",style: TextStyle(
                      fontWeight:FontWeight.w400
                    ),),
                    Icon(Icons.chevron_right )
                  ],
                ),
              ],
            ),
          ),
          ],
        )
        
        
       : isNote
        ? Column(
children: [
Container(
  padding: EdgeInsets.all(10),
  margin: EdgeInsets.all(10),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
  color: const Color.fromARGB(255, 224, 220, 220),
  ),
  child: Row(
    children: [
    Image.asset(
  "assets/images/notes.webp",
  width: 50,
  height: 50,
),
SizedBox(width: 20,),
Container(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Welcome to Notes",
    style: TextStyle(fontWeight: FontWeight.bold,
    fontSize: 20,
    
    ),),
    Text("Feature overview",style: TextStyle(color:const Color.fromARGB(255, 225, 203, 6)),),
  
  ],
  ),
),
    ],
  ),
),
  Expanded(
  child: ListView.builder(
    itemCount: noteList.length,
    itemBuilder: (context, index) {

      return Column(
        
        children: [

          ListTile(
            title: Text(
              noteList[index]["title"]??"",
            ),

            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noteList[index]["content"]??"",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                 SizedBox(height:5),
                  Text(
      noteList[index]["createdAt"]??"",
      style: TextStyle(
        color: Colors.grey,
        fontSize: 12,
      ),),
              ],
            ),
            

            onTap: () async {

              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotePage(
                    title: noteList[index]["title"]!,
                    content: noteList[index]["content"]!,
                  ),
                ),
              );


             if (result != null) {

  setState(() {

    noteList.add({

      "title": result["title"],

      "content": result["content"],

      "createdAt": DateTime.now().toString(),

    });

  });

  saveNotes();
}
            },


            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),

              onPressed: () {
                setState(() {
                  noteList.removeAt(index);
                });
                  saveNotes();
              },
            ),
          ),

          const Divider(),

        ],
      );

    },
  ),
)     
],

        )
       
  
        
       : isSearching
        ?Column(
children: [
 
  Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(20),
    alignment: Alignment.centerLeft,
    child: Text("Search for specific content",style: TextStyle(
        color:Colors.grey,
        fontWeight: FontWeight.bold,
        
        
      ),),
  ),
    Expanded(
      
      child: GridView.builder(
        itemCount: searchedTask.length,
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
crossAxisSpacing: 1,
mainAxisSpacing: 2,
),

        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.all(25),
            child: Column(
              
             children: [
               Icon(searchedTask[index]["icon"]),  SizedBox(height: 8),
             Text(searchedTask[index]["name"]),
             ],
            ),
          );
        }),
    )
],
        )
       
       : isTodo
       ?Column(
         children: [
         Row(
                   children: [
                    Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: textController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(60),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                 labelText: "Enter a Task",
                ),
              ),
              
            ),
           
          ),
           TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
                onPressed: (){
                  if(textController.text.isEmpty){
 return;
}
setState(() {
 taskList.add({

  "task": textController.text,

  "createdAt": DateTime.now().toString(),

});

  textController.clear();
});
saveTasks();
              },
              child: Text("ADD")
              ),

                   ],
                   ),
          
Flexible(
  child: ListView.builder(
    itemCount: taskList.length,
    itemBuilder: (context,index){
    return Container(
       margin: EdgeInsets.all(10),

  padding: EdgeInsets.all(5),

  decoration: BoxDecoration(
    color: Colors.lightGreen[200],
    borderRadius: BorderRadius.circular(10),
  ),
      child:  Container(
  margin: EdgeInsets.all(10),

  padding: EdgeInsets.all(5),

  decoration: BoxDecoration(
    color: Colors.lightGreen[200],
    borderRadius: BorderRadius.circular(10),
  ),

  child: Row(
    children: [

     Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 children: [

 Text(
  taskList[index]["task"],
 ),

 Text(
  taskList[index]["createdAt"],
  style: TextStyle(
   fontSize:12,
   color:Colors.grey,
  ),
 )

 ],
),
    Spacer(), 
      IconButton(
        onPressed: () {
          setState(() {
            taskList.removeAt(index);
          });
          saveTasks();
        },

        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),

    ],
  ),
),
    );
  
  },
  ),
),
         ],
       
        )
        
        
        
        :Container(),
      
        floatingActionButton: isNote
    ? FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 213, 195, 29),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(50),
        ),
        onPressed: () async  {
         setState(() {
         
           isNote=true;
            isTodo=false;
      isMe=false;
         isSearching=false;
       
      
         });

         final result = await Navigator.push(
          context, MaterialPageRoute(
            builder: (context) =>NotePage(
              title: "",
  content: "",
            ),
         ));

         
 if (result != null) {
            setState(() {

               noteList.add({
      "title": result["title"],
      "content": result["content"],
      "createdAt": DateTime.now().toString(),
    });

            });
            saveNotes(); 
        }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
          
        )
      )
    : null,

floatingActionButtonLocation:
    FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
      height: 60,
     
      
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: footeR.length,
      itemBuilder: (context, index) {
Color itemColor = Colors.grey;

        if(footeR[index]["name"] == "Note" && isNote){
          itemColor = const Color.fromARGB(255, 226, 205, 22);
        }
        else if(footeR[index]["name"] == "To-do" && isTodo){
 itemColor =const Color.fromARGB(255, 226, 205, 22);
        }
         else if(footeR[index]["name"] == "Me" && isMe){
 itemColor = const Color.fromARGB(255, 226, 205, 22);
        }
        return InkWell(
onTap: () {
  if (footeR[index]["name"] == "Note" ) {
  
    setState(() {
      isNote=true;
      isTodo=false;
      isMe=false;
         isSearching=false;
      
    });
    
  }

 else if (footeR[index]["name"] == "To-do") {
    setState(() {
      isTodo=true;
      isNote=false;
      isMe=false;
      isSearching=false;
    });
    
  }


  else if (footeR[index]["name"] == "Me"){
    setState(() {
      isMe=true;
      isNote=false;
      isTodo=false;
      isSearching=false;
    });
  }
        
},
    



          child: Container(
             width: 150,
            child: Column(
              children: [
            Icon(footeR[index]["icon"],
            color: itemColor,
            ),
            Text(footeR[index]["name"],
                   style: TextStyle(
             color: itemColor,
                   ),
            ),
                   
                  ],
            ),
          ),
        );
      },
      )
    
      
    ),  
      ); 
    
  }
}
