// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/health_facility.dart';

class ApiService {
  static Future<List<HealthFacility>> fetchHealthFacilities() async {
    final response = await http.get(Uri.parse(
        'https://api.data.gov.in/resource/7e7fe5e5-2ee1-478b-9687-4636c547348f?api-key=579b464db66ec23bdd000001cdd3946e44ce4aad7209ff7b23ac571b&format=json&limit=60'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['records'];
      return jsonData.map((data) => HealthFacility.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load facilities');
    }
  }
}
