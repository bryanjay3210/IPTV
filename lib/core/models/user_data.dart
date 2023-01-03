import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

@freezed
class UserData with _$UserData {
  const factory UserData({
    required String customerId,
    required String accessToken,
    required String expiresIn,
    required String tokenType,
    required String scope,
    required String timezone,
    required bool cc,
    required bool community,
    required bool beta,
    required String? latestVersion,
    required String? urlLink,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
