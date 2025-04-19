class Note {
  final int? id;
  final String title;
  final String description;
  bool isExpanded;

  Note({
    this.id,
    required this.title,
    required this.description,
    this.isExpanded = false,
  });

  // Zum Speichern in der Datenbank
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  // Zum Wiederherstellen aus der Datenbank
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  // Optional für Updates
  Note copyWith({int? id, String? title, String? description}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isExpanded: this.isExpanded,
    );
  }
}
