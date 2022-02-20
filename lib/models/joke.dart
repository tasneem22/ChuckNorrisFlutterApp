import 'package:json_annotation/json_annotation.dart';

part 'joke.g.dart';

@JsonSerializable(explicitToJson: true)
class Joke {
  Joke(this.categories, this.created_at, this.icon_url, this.id,
      this.updated_at, this.value);

  List<String> categories;
  late String created_at, icon_url, id, updated_at, url, value;
  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);

  Map<String, dynamic> toJson() => _$JokeToJson(this);
}
