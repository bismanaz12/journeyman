class Taskmodel {
  List photo;
  String note;

  Taskmodel({required this.photo, required this.note});

  Map<String, dynamic> tomap() {
    return {'images': photo, 'note': note};
  }

  factory Taskmodel.frommap(Map<String, dynamic> map) {
    return Taskmodel(
      photo: map['images'],
      note: map['note'],
    );
  }
}
