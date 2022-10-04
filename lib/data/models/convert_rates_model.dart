import 'dart:convert';

class ConverterRatesModel {
  Map<String, double> rates;
  DateTime date;
  String base;

  ConverterRatesModel(this.rates, this.date, this.base);

  static ConverterRatesModel fromJson(Map<String, dynamic> json) {
    Map<String, double> data = {};
    json["rates"].forEach((k, v) {
      data[k] = double.parse(v.toString());
    });

    return ConverterRatesModel(
        data, DateTime.parse(json['date']), json['base']);
  }

  Map<String, dynamic> toDBMap(double amount) => {
        "rates": json.encode(rates),
        "id": DateTime.parse(
                '${date.toString().split(' ').first} ${DateTime.now().toString().split(" ").last}')
            .millisecondsSinceEpoch,
        "base": base,
        "date": date.toString(),
        "amount": amount
      };

  static ConverterRatesModel fromDBMap(Map<dynamic, dynamic> map) {
    return ConverterRatesModel(
        Map<String, double>.from(json.decode(map['rates'])),
        DateTime.parse(map['date']),
        map['rates']);
  }

  double getAmountFor(String key) {
    return rates[key] ?? 0.0;
  }
}
