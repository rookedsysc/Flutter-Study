// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      id: json['id'] as String,
      user: json['user'] as String,
      rating: json['rating'] as int,
      content: json['content'] as String,
      imgUrl: DataUtils.listsPathsToUrls(json['imgUrl'] as List<String>),
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'rating': instance.rating,
      'content': instance.content,
      'imgUrl': instance.imgUrl,
    };
