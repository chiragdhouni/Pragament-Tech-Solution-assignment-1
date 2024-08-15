// lib/providers/data_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pragament_assgn/services/api_services.dart';
import '../models/health_facility.dart';

final healthFacilitiesProvider =
    FutureProvider<List<HealthFacility>>((ref) async {
  return ApiService.fetchHealthFacilities();
});
