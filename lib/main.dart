import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '3d Animation Drawer',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Let's declare the val variable
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Let's start first by creating the background of the app

          Container(

            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF42A5F5),
                    Color(0xFF2979FF)
                  ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )
            ),
          ),

          //Now let's make the Navigation menu
          SafeArea(
              child: Container(
                width: 200.0,
                padding: EdgeInsets.all(8.0),

                child: Column(
                  children: [
                    DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                                 CircleAvatar(
                                   radius: 50.0,
                                   backgroundImage: NetworkImage('https://images.unsplash.com/photo-1609599006353-e629aaabfeae?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cXVyYW58ZW58MHx8MHx8&w=1000&q=80'),
                                 ),
                            
                            SizedBox(height: 10.0,),
                            Text('Abu Torab',style: TextStyle(fontSize: 19,color: Colors.black,fontWeight: FontWeight.bold),),

                          ],
                        )
                    ),

                    Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: (){},
                              leading: Icon(Icons.home,color: Colors.white,),
                              title: Text('Home',style: TextStyle(color: Colors.white,),),
                            ),

                            ListTile(
                              onTap: (){},
                              leading: Icon(Icons.person,color: Colors.white,),
                              title: Text('Profile',style: TextStyle(color: Colors.white,),),
                            ),

                            ListTile(
                              onTap: (){},
                              leading: Icon(Icons.settings,color: Colors.white,),
                              title: Text('Settings',style: TextStyle(color: Colors.white,),),
                            ),

                            ListTile(
                              onTap: (){},
                              leading: Icon(Icons.logout,color: Colors.white,),
                              title: Text('Log Out',style: TextStyle(color: Colors.white,),),
                            )
                          ],
                        )
                    )
                  ],
                ),
              )
          ),

          //Now let's make our main screen
          //we will wrap our main screen in a tween animation builder
          //which will allow us to animate it

          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0,end: value),

              duration: Duration(microseconds: 500),
              curve: Curves.easeInExpo,

              builder: (_,double val,__){
                //Now let's create a transform widget
                return Transform(
                  alignment: Alignment.center,

                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                        ..setEntry(0, 3, 200 * val) //this line will allow us to translate the screen
                      ..rotateY((pi/6) * val),

                  child: Scaffold(
                    backgroundColor: Color(0xffC90076)
                    ,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: IconButton(onPressed: (){
                        setState(() {
                          value == 0? value = 1 : value = 0;
                        });
                      }, icon: Icon(Icons.menu,color: Colors.white,),),

                      title: Text('Torab Page'),
                      centerTitle: true,
                    ),
                    
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
                        children: [
                          Text('Swift right to open the menu',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),

                          //of course you can add anything inside your screen
                          MaterialButton(onPressed: null,child: Text('Hellow Torab !',style: TextStyle(color: Colors.white),),)
                        ],
                      ),
                    ),
                  ),
                );
              }),

          //Okey now let's make the gesture detector widget that will allow us to open the drawer
          GestureDetector(
            //as you can see using the tap isn't a good solution
            //that's why we will change it with the swipe method
            onHorizontalDragUpdate: (e){

              if(e.delta.dx > 0){
                setState(() {
                  value = 1;
                });
              }else{
                setState(() {
                  value = 0;
                });
              }
            },


            // onTap: (){
            //   setState(() {
            //     value == 0? value = 1 : value = 0; //if the value is equal to 0 then when we tap it will become 1 else it will become 0
            //   });
            // },
          )
        ],
      ),
    );
  }
}


