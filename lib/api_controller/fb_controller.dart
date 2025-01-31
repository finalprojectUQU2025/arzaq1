import 'package:arzaq_app/model/auction_timer.dart';
import 'package:arzaq_app/model/fb_response.dart';
import 'package:arzaq_app/model/supplier_models/supply_auction_details.dart';
import 'package:arzaq_app/utils/firebase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FbFirestoreController with FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<FbResponse> createOffer(AllOffer offer,
      String collection) async {
    return _firestore
        .collection(collection)
        .add(offer.toMap())
        .then((value) => successResponse)
        .catchError((error) => errorResponse);
  }

  Stream<QuerySnapshot<AllOffer>> readOffers(String collection) async* {
   try{
     yield* _firestore
         .collection(collection).orderBy('offerAmount', descending: true)
         .withConverter<AllOffer>(
       fromFirestore: (snapshot, options) => AllOffer.fromJson(snapshot.data()!),
       toFirestore: (value, options) => value.toMap(),
     )
         .snapshots();
   }catch(e){
     print('00$e');
   }
  }


  Future<void> createAuctionTime(String auctionId,bool isVegetable) async {
    final now = DateTime.now();
    var startTime = isVegetable?DateTime(now.year, now.month, now.day, 9, 0, 0):DateTime(now.year, now.month, now.day, 10, 0, 0);
    if (startTime.isBefore(now)) {
      startTime = startTime.add(Duration(days: 1));
    }
    final endTime = startTime.add(Duration(minutes: 5));

    final formattedStartTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(startTime);
    final formattedEndTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(endTime);

    await _firestore.collection('auctions').doc(auctionId).set({
      'startTime': formattedStartTime,
      'endTime': formattedEndTime,
      'status': 'scheduled',
    });
  }

  Future<void> updateAuctionTime(String auctionId,{bool isVegetable = true,required DateTime endTime,required DateTime startTime}) async {
    /*final now = DateTime.now();
    var startTime = isVegetable?DateTime(now.year, now.month, now.day, 9, 0, 0):DateTime(now.year, now.month, now.day, 10, 0, 0);
    final endTime = startTime.add(Duration(minutes: 5));
    if (startTime.isBefore(now)) {
      startTime = startTime.add(Duration(days: 1));
    }*/

    final formattedStartTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(startTime);
    final formattedEndTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(endTime);

    await _firestore.collection('auctions').doc(auctionId).set({
      'startTime': formattedStartTime,
      'endTime': formattedEndTime,
      'status': 'scheduled',
    });
  }



  Stream<DocumentSnapshot<AuctionTimer>> readAuctionTime( String documentId) async* {
    yield* _firestore
        .collection('auctions')
        .doc(documentId)
        .withConverter<AuctionTimer>(
      fromFirestore: (snapshot, options) => AuctionTimer.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }


}