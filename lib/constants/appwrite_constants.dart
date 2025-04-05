class AppwriteConstants {
  static const String projectId = "67e9585c000dd79adfa2";
  static const String endPoint = "https://cloud.appwrite.io/v1";
  static const String databaseId = "67e95c01003961839688";
  static const String documentId = "67e95cad001cadf513bf";
  static const String usersCollectionId = "67e95cad001cadf513bf";
  static const String cardsCollectionId = "67ebf735001d12e16a97";
  static const String bucketId = "67ec1a68003dcca4ada0";
  static const String premiumcards ="67eff31d0026c7c02a05";

  static String imageUrl(String imageId) {
    return "$endPoint/storage/buckets/$bucketId/files/$imageId/view?project=$projectId&mode=admin";
  }
}
