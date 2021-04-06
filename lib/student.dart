import 'dart:convert';
class Student{
  //Student({this.Naam , this.Klas});
  Student (Map<String, dynamic> json)
  {
    this.Naam = json["Naam"];
    this.Klas = json["Klas"];
  }
  String Naam;
  String Klas;
}