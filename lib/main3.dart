import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';

void main()
{
  runApp(Myap() );
}
class Myap extends StatefulWidget {
  @override
  _MyapState createState() => _MyapState();
}

class _MyapState extends State<Myap> {
  
  static const apiKey='AIzaSyARWosDPjz9rJt48P8z1tO8VdsEPPjbQL8';
  static const nlat= 45.521563;
  static const nlong=-122.677433;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
@override 
void didChangeDependencies() async {
  super.didChangeDependencies();
  print( await searchnear('hospitals'));
}

Future<List<String>> searchnear(String keyword) async {
  var dio=Dio();
  var url='https://maps.googleapis.com/maps/api/place/nearbysearch/json';
  var parameters={
    'key':apiKey,
    'location':'$nlat,$nlong',
    'radius': '800',
    'keyword': keyword,
  };
var response = await dio.get(url, queryParameters: parameters);
return response.data['results'].map<String>((result)=>result['name'].toString()).toList();




}





}