
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:proj112/main2.dart';
import 'package:proj112/main3.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:splashscreen/splashscreen.dart';

void main()
{
  runApp(MaterialApp(
    home:h1(),
  ));
}
class h1 extends StatefulWidget {
  @override
  _h1State createState() => _h1State();
}

class _h1State extends State<h1> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/applogo.jpeg',width: 200,height: 200,),
      nextScreen: starthome(),
      splashTransition: SplashTransition.rotationTransition,
      animationDuration: Duration(seconds: 5),
      )
      
    );
  }
}
class starthome extends StatefulWidget {
  @override
  _starthomeState createState() => _starthomeState();
}

class _starthomeState extends State<starthome> {
  
  
  
String p1="";
var p2;
var c1;
 
  
  List _results;
  String _name="";
File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    debugPrint("-----------------------------");
    // Tflite.close();
    loadmodel();
    applymodel(File(pickedFile.path));
    
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  
  
  loadmodel() async {
    debugPrint("yooooo111111");
    // Tflite.close();
    var resultant= await Tflite.loadModel(labels:"assets/labels.txt", model:"assets/model33.tflite");
    print("resultttt: $resultant $_name");


  }
  
  
  applymodel(File file) async {
    var res= await Tflite.runModelOnImage(path: file.path);
    debugPrint("yiiiiii");
    setState(() {
      _results=res;
      debugPrint("$res");
      String str= _results[0]["label"];
      _name=str.substring(2);
      p1=_results[0]["label"];
      p2=_results[0]["confidence"];
      p2=p2.toStringAsFixed(4);
   
    });
  }


@override
void initState(){
  super.initState();
  
  loadmodel();
  debugPrint("reeeee---------------------------------------");
}
/*
@override
void dispose() {
  // you can add to close tflite if error is caused by tflite
  // Tflite.close();
  //controller?.dispose(); // this is to dispose camera controller if you are using live detection
  super.dispose();
}

*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[400],
        title: Text('Evash'),
      ),
      body: Container(
        child:Column(
          children: [
        SizedBox(height: 30,width: 30,),
      Container( 
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          height:350,
          width:350,
          child:
        _image == null
            ? Text('Please select an image.',
          textAlign: TextAlign.center,
            style: TextStyle(
              color:Colors.blueAccent,
              fontSize: 30,

            ),
            )
            : Image.file(_image),
          ),
          _image == null? Text(" "):
          Text("Result : $p1 \n Accuracy : $p2 ",
          style: TextStyle(
            color:Colors.blueAccent,
            fontSize: 30 
          ),
          ),
          RaisedButton(
            
            onPressed: (){
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => MyLocation()));

    },
    child: Text('Maps'),
          )
         
          ]
      ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
      
    );
  }
}