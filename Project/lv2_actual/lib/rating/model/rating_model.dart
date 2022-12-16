import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/common/model/model_with_id.dart';
import 'package:lv2_actual/common/utils/data_utils.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  final String id;
  final String user;
  final int rating;
  final String content;
  @JsonKey(fromJson: DataUtils.listsPathsToUrls)
  final List<String> imgUrl;
  RatingModel(
      {required this.id,
      required this.user,
      required this.rating,
      required this.content,
      required this.imgUrl});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
