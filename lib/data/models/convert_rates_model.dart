class ConverterRatestModel {
  Map<String, double> rates;
  DateTime date;
  String base;

  ConverterRatestModel(this.rates, this.date, this.base);

  static ConverterRatestModel fromJson(Map<String, dynamic> json) {
    Map<String, double> data = {};
    json["rates"].forEach((k, v) {
      data[k] = double.parse(v.toString());
    });

    return ConverterRatestModel(
        data, DateTime.parse(json['date']), json['base']);
  }

  double getAmountFor(String key) {
    return rates[key] ?? 0.0;
  }
}
