import 'package:crud_hospital_app/data/data_sources/data_api_service.dart';
import 'package:crud_hospital_app/data/models/hospital_model.dart';
import 'package:flutter/material.dart';

class HospitalProvider with ChangeNotifier{
  final api = HospitalApiService();

  List<Hospital> _hospitals = [];
  List<Hospital> get hospitals => _hospitals;

  bool isLoading = false;

  Future<void> loadHospitals() async{
    isLoading = true;
    notifyListeners();

    try{
      _hospitals = await api.fetchHospitals();
    }catch(e){
      print('Error loading hospitals: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}