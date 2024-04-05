class Datamodel {
  int? id;
  String name;
  String remark;
  String mono;
  String amount;
  String date;
  String time;
  String type;
  String recivedate;

  Datamodel(
      {required this.recivedate,
      required this.remark,
      required this.name,
      required this.type,
      required this.time,
      required this.date,
      required this.amount,
      required this.mono,
      this.id});

  factory Datamodel.name({required Map data}) {
    return Datamodel(
        recivedate: data['recivedate'],
        remark: data['remark'],
        name: data['name'],
        type: data['type'],
        time: data['time'],
        date: data['date'],
        amount: data['amount'],
        mono: data['mono'],
        id: data['id']);
  }
}
