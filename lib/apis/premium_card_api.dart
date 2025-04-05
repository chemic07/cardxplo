import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:cardxplo/constants/appwrite_constants.dart';
import 'package:cardxplo/core/failure.dart';
import 'package:cardxplo/core/providers.dart';
import 'package:cardxplo/core/type_defs.dart';
// import 'package:cardx/core/utils.dart';

import 'package:cardxplo/models/premium_card_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final premiumCardApiProvider = FutureProvider((ref) async {
  final database = ref.watch(appwriteDatabaseProvider);
  return PremiumCardApi(db: database);
});

abstract class IPremiumCardApi {
  FutureEither<Document> savePremiumCard(
    PremiumCardModel premiumCard,
  );
}

class PremiumCardApi implements IPremiumCardApi {
  final Databases _db;
  PremiumCardApi({required Databases db}) : _db = db;

  @override
  FutureEither<Document> savePremiumCard(
    PremiumCardModel premiumCard,
  ) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.premiumcardsCollection,
        documentId: ID.unique(),
        data: premiumCard.toMap(),
      );

      return right(document);
    } on AppwriteException catch (e, stacktrace) {
      return left(Failure(e.message ?? "Unknown", stacktrace));
    } catch (e, stacktrace) {
      return left(Failure(e.toString(), stacktrace));
    }
  }
}
