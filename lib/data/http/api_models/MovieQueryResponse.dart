import 'package:json_annotation/json_annotation.dart';
import 'package:movie_viewer/data/http/api_models/MovieAPIModel.dart';

part 'MovieQueryResponse.g.dart';

@JsonSerializable()
class MovieQueryResponse {
  @JsonKey(name: "results")
  final List<MovieAPIModel> results;

  MovieQueryResponse(this.results);

  factory MovieQueryResponse.fromJson(Map<String, dynamic> json) => _$MovieQueryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieQueryResponseToJson(this);
}
