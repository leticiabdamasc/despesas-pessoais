class Transaction {
  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });
  late final int id;
  late final String title;
  late final double value;
  late final DateTime date;

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['value'] = value;
    _data['date'] = date;
    return _data;
  }
}
