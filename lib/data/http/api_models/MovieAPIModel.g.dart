// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieAPIModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieAPIModel _$MovieAPIModelFromJson(Map<String, dynamic> json) {
  return MovieAPIModel(
    json['poster_path'] as String,
    json['original_title'] as String,
    json['overview'] as String,
    json['vote_average'] as num,
  );
}

Map<String, dynamic> _$MovieAPIModelToJson(MovieAPIModel instance) =>
    <String, dynamic>{
      'poster_path': instance.poster_path,
      'original_title': instance.title,
      'overview': instance.description,
      'vote_average': instance.rating,
    };
