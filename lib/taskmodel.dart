import 'package:cloud_firestore/cloud_firestore.dart';

class Taskmodel {
  List photo;
  String note;
  String customerId;
  String productname;
  String enginetype;
  String horsepower;
  String torque;
  String fuelefficiency;
  String engineoil;
  String taskId;
  DateTime time;
  bool takeTask;
  String task;
  String techId;

  Taskmodel(
      {required this.photo,
      required this.task,
      required this.note,
      required this.customerId,
      required this.engineoil,
      required this.enginetype,
      required this.fuelefficiency,
      required this.horsepower,
      required this.productname,
      required this.torque,
      required this.time,
      required this.takeTask,
      required this.techId,
      required this.taskId});

  Map<String, dynamic> tomap() {
    return {
      'images': photo,
      'note': note,
      'customerId': customerId,
      'engineoil': engineoil,
      'enginetype': enginetype,
      'fuelefficiency': fuelefficiency,
      'horsepower': horsepower,
      'productname': productname,
      'torque': torque,
      'taskId': taskId,
      'time': time,
      'takeTask': takeTask,
      'task': task,
      'techId': techId
    };
  }

  factory Taskmodel.frommap(Map<String, dynamic> map) {
    return Taskmodel(
        photo: map['images'],
        note: map['note'],
        customerId: map['customerId'],
        engineoil: map['engineoil'],
        fuelefficiency: map['fuelefficiency'],
        horsepower: map['horsepower'],
        torque: map['torque'],
        enginetype: map['enginetype'],
        productname: map['productname'],
        taskId: map['taskId'],
        takeTask: map['takeTask'],
        task: map['task'],
        techId: map['techId'],
        time: (map['time'] as Timestamp).toDate());
  }
}
