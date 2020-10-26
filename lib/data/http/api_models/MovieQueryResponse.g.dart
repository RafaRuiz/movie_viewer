// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieQueryResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieQueryResponse _$MovieQueryResponseFromJson(Map<String, dynamic> json) {
  return MovieQueryResponse(
    (json['results'] as List)
        ?.map((e) => e == null
            ? null
            : MovieAPIModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieQueryResponseToJson(MovieQueryResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
