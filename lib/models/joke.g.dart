// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Joke _$JokeFromJson(Map<String, dynamic> json) => Joke(
      (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
      json['created_at'] as String,
      json['icon_url'] as String,
      json['id'] as String,
      json['updated_at'] as String,
      json['value'] as String,
    )..url = json['url'] as String;

Map<String, dynamic> _$JokeToJson(Joke instance) => <String, dynamic>{
      'categories': instance.categories,
      'created_at': instance.created_at,
      'icon_url': instance.icon_url,
      'id': instance.id,
      'updated_at': instance.updated_at,
      'url': instance.url,
      'value': instance.value,
    };
