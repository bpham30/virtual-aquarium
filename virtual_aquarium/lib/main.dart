import 'package:flutter/material.dart';

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

class _AquariumScreenState extends State<AquariumScreen> {
  //default color & speed
  Color color = Colors.blue;
  double speed = 1.0;

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
              color: Colors.blue,
              child: const Center(
                child: Text('Aquarium Container', ),
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
                   DropdownMenuItem<Color>(value: Colors.blue, child: Text('Blue 🔵')),
                   DropdownMenuItem<Color>(value: Colors.green, child: Text('Green 🟢')),
                   DropdownMenuItem<Color>(value: Colors.red, child: Text('Red 🔴')),
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
}

