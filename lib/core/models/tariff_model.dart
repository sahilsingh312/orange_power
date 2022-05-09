class MyTariffModel {
  late double value_exec_vat;
  late double value_inc_vat;
  late String valid_from;
  late String valid_to;

  MyTariffModel({required this.value_exec_vat, required this.value_inc_vat, required this.valid_from, required this.valid_to});

  MyTariffModel.fromJson(
    Map<String, dynamic> json,
  ) {
    value_exec_vat = json['value_exc_vat'];
    value_inc_vat = json['value_inc_vat'];
    valid_from = json['valid_from'];
    valid_to = json['valid_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value_exc_vat'] = this.value_exec_vat;
    data['value_inc_vat'] = this.value_inc_vat;
    data['valid_from'] = this.valid_from;
    data['valid_to'] = this.valid_to;
    return data;
  }
}
