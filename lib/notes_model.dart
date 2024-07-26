
class Teacher {
  int? id;
  late String name;
  late String designation;
  late String dept;

  Teacher({
    this.id,
    required this.name,
    required this.designation,
    required this.dept,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'dept': dept,
    };
  }

  // Convert a Map to a Teacher Object
  Teacher.fromMap(Map<String, dynamic> map) {
    id          = map['id'];
    name        = map['name'];
    designation = map['designation'];
    dept        = map['dept'];
  }
} // end of class