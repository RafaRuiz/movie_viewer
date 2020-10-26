import 'package:json_annotation/json_annotation.dart';

part 'MovieAPIModel.g.dart';

@JsonSerializable()
class MovieAPIModel {
  @JsonKey(name: "poster_path")
  final String poster_path;
  @JsonKey(name: "original_title")
  final String title;
  @JsonKey(name: "overview")
  final String description;
  @JsonKey(name: "vote_average")
  final num rating;

  MovieAPIModel(
    this.poster_path,
    this.title,
    this.description,
    this.rating,
  );

  String get image => "http://image.tmdb.org/t/p/w500/$poster_path";

  factory MovieAPIModel.fromJson(Map<String, dynamic> json) => _$MovieAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieAPIModelToJson(this);
}
