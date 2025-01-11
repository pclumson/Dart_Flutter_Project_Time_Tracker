class Project {
  final String id;
  final String name;

  Project({

    required this.id,
    required this.name

  });

  // Convert a JSON object to an Project instance
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(

      id: json['id'],
      name: json['name'],

    );
  }

  // Convert a Project instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'name': name,

    };

}
