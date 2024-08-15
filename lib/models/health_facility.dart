class HealthFacility {
  final String indicator;
  final String facilityType;
  final int totalNoOfFacilities;
  final int facilitiesReportingNilPerformance;
  final String performance;
  final double valueReported;
  final String subDistrict;
  final String facility;

  HealthFacility({
    required this.indicator,
    required this.facilityType,
    required this.totalNoOfFacilities,
    required this.facilitiesReportingNilPerformance,
    required this.performance,
    required this.valueReported,
    required this.subDistrict,
    required this.facility,
  });

  factory HealthFacility.fromJson(Map<String, dynamic> json) {
    return HealthFacility(
      indicator: json['indicator'] as String,
      facilityType: json['facility_type'] as String,
      totalNoOfFacilities: json['total_no__of_facilities__'] is String
          ? int.parse(json['total_no__of_facilities__'] as String)
          : json['total_no__of_facilities__'] as int,
      facilitiesReportingNilPerformance:
          json['facilities_reporting_nil_performance___numbers_'] is String
              ? int.parse(
                  json['facilities_reporting_nil_performance___numbers_']
                      as String)
              : (json['facilities_reporting_nil_performance___numbers_'] as num)
                  .toInt(),
      performance: json[
              'details_of_maximum_and_minimum_performing_facilities___performance']
          as String,
      valueReported: json[
                  'details_of_maximum_and_minimum_performing_facilities___value_reported']
              is String
          ? double.parse(json[
                  'details_of_maximum_and_minimum_performing_facilities___value_reported']
              as String)
          : (json['details_of_maximum_and_minimum_performing_facilities___value_reported']
                  as num)
              .toDouble(),
      subDistrict: json[
              'details_of_maximum_and_minimum_performing_facilities___sub_district']
          as String,
      facility: json[
              'details_of_maximum_and_minimum_performing_facilities___facility']
          as String,
    );
  }
}
