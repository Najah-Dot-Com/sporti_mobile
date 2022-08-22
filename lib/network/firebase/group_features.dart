import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sporti/feature/model/comment_data.dart';
import 'package:sporti/feature/model/group_data.dart';

class GroupFeatures {
  GroupFeatures._();

  static final GroupFeatures instance = GroupFeatures._();

  factory GroupFeatures() => instance;

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //collections
  final String _group = 'group';
  final _groupImage = "groupImage";
  final _comments = "comments";

  //filed
  final String _timeStamp = 'timeStamp';
  final String _isActive = 'isActive';
  final String _url = 'url';

  //this for comments
  static const String profilePicKey = 'profilePic';
  static const String nameKey = 'name';
  static const String uidKey = 'uid';
  static const String textKey = 'text';
  static const String commentIdKey = 'commentId';
  static const String datePublishedKey = 'datePublished'; //datePublishedKey
  static const String timeStampKey = 'timeStamp';

  Future<bool> createGroup(
    String title,
    String description,
  ) async {
    try {
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      GroupData post = GroupData(
          desc: description,
          url: "https://cdn-icons-png.flaticon.com/512/685/685686.png",
          isActive: true,
          title: title,
          id: id,
          timeStamp: FieldValue.serverTimestamp());
      _fireStore.collection(_group).doc(id).set(post.toJson());

      return true;
    } catch (err) {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGroup(
      {bool isActive = false}) {
    if (isActive) {
      return FirebaseFirestore.instance
          .collection(_group)
          .where(_isActive, isEqualTo: isActive)
          .orderBy(_timeStamp, descending: true)
          .snapshots();
    }
    return FirebaseFirestore.instance
        .collection(_group)
        .orderBy(_timeStamp, descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getGroupComments({GroupData? group}) {
    var timestamp = Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 7)));
    Logger().d(timestamp);
    return FirebaseFirestore.instance
        .collection(_group)
        .doc(group?.id.toString())
        .collection(_comments)
         .where(timeStampKey, isGreaterThanOrEqualTo:timestamp/* DateFormat("yyyy-MM-dd hh:mm").format(DateTime.now().subtract(const Duration(days: 7)))*/)
        .orderBy(timeStampKey, descending: true)
        .snapshots();
  }

  updateGroupState(GroupData data) async {
    bool active = data.isActive!;
    active = !active;
    await _fireStore
        .collection(_group)
        .doc(data.id)
        .update({_isActive: active});
  }

  updateGroupImage(GroupData data) async {
    await _fireStore.collection(_group).doc(data.id).update({_url: data.url});
  }

  Future<String> uploadImage(Uint8List file, String groupId) async {
    Reference ref = _storage.ref().child(_groupImage).child(groupId);

    // if(isPost) {
    //   String imageId =  DateTime.now().toString();
    //   ref = ref.child(imageId);
    // }

    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Post comment
  Future<bool> postComment(
      {required String postId,
      required String text,
      required String uid,
      required String name,
      required String profilePic}) async {
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = DateTime.now().millisecondsSinceEpoch.toString();
        var commentData = CommentData(
          profilePic: profilePic,
          name: name,
          uid: uid,
          text: text,
          commentId: commentId,
          datePublished: DateTime.now(),
          timeStamp: FieldValue.serverTimestamp(),
        );
        _fireStore
            .collection(_group)
            .doc(postId)
            .collection(_comments)
            .doc(commentId)
            .set(commentData.toJson());
        return true;
      } else {
        return false;
      }
    } catch (err) {
      Logger().e(err);
      return false;
    }
    // return res;
  }

  void deleteComment(CommentData comment, GroupData group) {
    _fireStore
        .collection(_group)
        .doc(group.id.toString())
        .collection(_comments)
        .doc(comment.commentId.toString()).delete();
  }
}
