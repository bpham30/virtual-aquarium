import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virtual Aquarium',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AquariumScreen(),
     
    );
  }
}

//ui for aquarium
class AquariumScreen extends StatefulWidget {
  const AquariumScreen({super.key});

  @override
  _AquariumScreenState createState() => _AquariumScreenState();
}

class _AquariumScreenState extends State<AquariumScreen> with TickerProviderStateMixin {

  //store fish in a list
  List<Fish> fishList = [];

  //default color & speed
  Color color = Colors.blue;
  double speed = 1.0;
  

  //logic for adding fish
  void _addFish() {
    if (fishList.length <10) {
      setState(() {
        fishList.add(Fish(color: color, speed: speed, vsync: this, onRemove: (fish) => _removeFish(fish)));
      });
    }
  }

  //logic for removing fish
  void _removeFish(Fish fish) {
    setState(() {
      fish.dispose();
      fishList.remove(fish);
    });
  }
  //display ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Virtual Aquarium 🐟' , style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold), ),
        backgroundColor: Colors.blue,
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            //300 x 300 container
          Padding(padding: const EdgeInsets.only(top: 16), child:   Container(
              width: 300,
              height: 300,
              color: Colors.lightBlue,
            
               child: Stack(
                //display fish
              children: fishList.map((fish) => fish.build()).toList(),
            ),
           
            ),),

            //slider to control speed
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Speed: ', style: TextStyle(fontSize: 16),),
                SliderTheme(data: const SliderThemeData(thumbColor: Colors.blue, activeTrackColor: Colors.blue), child: Slider(value: speed, min: .5, max: 5.0, onChanged: (value) {
                  setState(() {
                    speed = value;
                  });
                }),)
              ],
            ),

          //color picker
        Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Color: ', style: TextStyle(fontSize: 16),),
               DropdownButton<Color>(
                 value: color,
                 items: const [
                   DropdownMenuItem<Color>(value: Colors.red, child: Text('Red 🔴')),
                   DropdownMenuItem<Color>(value: Colors.green, child: Text('Green 🟢')),
                   DropdownMenuItem<Color>(value: Colors.blue, child: Text('Blue 🔵')),
                   DropdownMenuItem<Color>(value: Colors.yellow, child: Text('Yellow 🟡')),
                 ],
                 onChanged: (Color? newColor) {
                   if(newColor != null) {
                      setState(() {
                        color = newColor;
                      });
                   }
                 },
               )
              ],
            ),

            //add fish btn
             Padding(padding: const EdgeInsets.only(top: 16), child: 
            ElevatedButton(
              onPressed: () {
                //add fish functionality
                _addFish();
              },
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Add Fish 🐟', style: TextStyle(fontSize: 16, color: Colors.white),),
            ),),

            //save settings btn
             Padding(padding: const EdgeInsets.only(top: 16), child: 
            ElevatedButton(
              onPressed: () {
                //save settings functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Save Settings', style: TextStyle(fontSize: 16 , color: Colors.white),),
            ),),
          ] 
        ),
      ),
    );
    
  }
  @override
  void dispose() {
    //remove all fish controllers
    for (var fish in fishList) {
      fish.dispose();
    }
    super.dispose();
  }
}

//fish class 
class Fish {
  //color & speed
  final Color color;
  final double speed;
  
  //animation controller
  final TickerProvider vsync;
  late AnimationController controller;

  //remove fish function
  final Function(Fish) onRemove;

 //random x & y directions for fish
  double x = Random().nextDouble() * 2 - 1;
  double y = Random().nextDouble() * 2 - 1; 

  //init positions for pish
  double pX = Random().nextDouble() * 250;
  double pY = Random().nextDouble() * 250;

  //constructor
  Fish({required this.color, required this.speed, required this.vsync, required this.onRemove}) {
    controller = AnimationController(vsync: vsync, duration: const Duration(seconds: 5))..repeat();
  }

  //build fish as colored circle
  Widget build() {
    return AnimatedBuilder(animation: controller, builder: (context,child) {
      //movement logic
      //update pos vased on random directions
      pX += x * speed;
      pY += y * speed;

      //if fish hits wall, change direction
      if (pX < 0 || pX > 280) {
        x = -x;
      }
      if (pY < 0 || pY > 280) {
        y = -y;
      }
      //return fish 
      return Positioned(
        left: pX. clamp(0, 280),
        top: pY. clamp(0, 280),
        child: GestureDetector(
          onTap: () => onRemove(this),
          child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle
          ),
      ),
        )
      );
    });
  }

  //dispose controller
  void dispose() {
    controller.dispose();
  }
}

