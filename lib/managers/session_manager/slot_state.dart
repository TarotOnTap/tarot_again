// part of 'session_manager.dart';
//
// @freezed
// sealed class SlotState with _$SlotState {
//   const factory SlotState.notDealt({
//     required int slotIndex,
//     @Default("") String slotName,
//   }) = SlotStateNotDealt;
//
//   // const factory SlotState.dealt({
//   //   required int slotIndex,
//   //   @Default("") String slotName,
//   //   required bool faceUp,
//   //   required DealtCard card,
//   // }) = SlotStateDealtNoAssets;
//
//   const factory SlotState.dealt({
//     required int slotIndex,
//     @Default("") String slotName,
//     required bool faceUp,
//     required DealtCard card,
//     @JsonKey(includeFromJson: false, includeToJson: false) AssetGenImage? image,
//     @JsonKey(includeFromJson: false, includeToJson: false) String? description,
//     @JsonKey(includeFromJson: false, includeToJson: false)
//     String? uprightMeaning,
//     @JsonKey(includeFromJson: false, includeToJson: false)
//     String? reversedMeaning,
//   }) = SlotStateDealt;
//
//   factory SlotState.fromJson(Map<String, dynamic> json) =>
//       _$SlotStateFromJson(json);
// }
