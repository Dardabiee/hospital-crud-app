import 'package:flutter/foundation.dart';

class Hospital{
  final int id;
  final String name;
  final String address;
  final String phone;
  final String type;

  Hospital({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.type,
  });

  factory Hospital.fromJson(Map<String, dynamic> json){
    return Hospital(
      id: json['id'], 
      name: json['name'], 
      address: json['address'], 
      phone: json['phone'], 
      type: json['type']);
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'type': type,
    };
  }
}
