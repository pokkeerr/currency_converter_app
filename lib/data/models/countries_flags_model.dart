import 'dart:convert';

import 'package:flutter/foundation.dart';

class CountryFlagsModel {
  Map<String, String> countries;
  CountryFlagsModel({
    required this.countries,
  });

  CountryFlagsModel copyWith({
    Map<String, String>? countries,
  }) {
    return CountryFlagsModel(
      countries: countries ?? this.countries,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'countries': countries});

    return result;
  }

  factory CountryFlagsModel.fromMap(Map<String, dynamic> map) {
    return CountryFlagsModel(
      countries: Map<String, String>.from(map['countries']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryFlagsModel.fromJson(String source) =>
      CountryFlagsModel.fromMap(json.decode(source));

  @override
  String toString() => 'CountryFlagsModel(countries: $countries)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CountryFlagsModel && mapEquals(other.countries, countries);
  }

  @override
  int get hashCode => countries.hashCode;
}
