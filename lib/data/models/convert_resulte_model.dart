class ConverterResultModel {
  String? amount;
  String? baseCurrencyCode;
  String? baseCurrencyName;
  String? status;
  String? updatedDate;

  ConverterResultModel(
      {amount, baseCurrencyCode, baseCurrencyName, rates, status, updatedDate});

  ConverterResultModel.fromJson(Map<String, dynamic> json) {
    amount = json["amount"];
    baseCurrencyCode = json["base_currency_code"];
    baseCurrencyName = json["base_currency_name"];
    status = json["status"];
    updatedDate = json["updated_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["amount"] = amount;
    data["base_currency_code"] = baseCurrencyCode;
    data["base_currency_name"] = baseCurrencyName;
    data["status"] = status;
    data["updated_date"] = updatedDate;
    return data;
  }
}
