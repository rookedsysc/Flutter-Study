import 'package:json_annotation/json_annotation.dart';
import 'package:lv2_actual/common/model/model_with_id.dart';
import 'package:lv2_actual/common/utils/data_utils.dart';
import 'package:lv2_actual/rating/component/rating_card.dart';
import 'package:lv2_actual/user/model/user_model.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(
    fromJson: DataUtils.listsPathsToUrls,
  )
  final List<String> imgUrls;
  RatingModel(
      {required this.id,
      required this.user,
      required this.rating,
      required this.content,
      required this.imgUrls});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
