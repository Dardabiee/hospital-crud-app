import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hospital_model.dart';
import '../../core/config.dart';

class HospitalApiService {
  final client = http.Client();

  Future<List<Hospital>> fetchHospitals() async {
    final response = await client.get(Uri.parse('$baseUrl/hospitals'));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Hospital.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hospitals');
    }
  }

  Future<void> addHospital(Hospital hospital) async {
    await client.post(
      Uri.parse('$baseUrl/hospitals'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(hospital.toJson()),
    );
  }

  Future<void> deleteHospital(int id) async {
    await client.delete(Uri.parse('$baseUrl/hospitals/$id'));
  }

  Future<void> updateHospital(int id, Hospital hospital) async {
    await client.put(
      Uri.parse('$baseUrl/hospitals/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(hospital.toJson()),
    );
  }
}
