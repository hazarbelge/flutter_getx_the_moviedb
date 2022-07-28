import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  const Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(Map<String?, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }

  final int? id;
  final String? name;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        "name": name,
      };

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
      ];
}
