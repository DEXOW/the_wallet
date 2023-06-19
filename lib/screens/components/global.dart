import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SnackBarNotify {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    Color? bgcolor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgcolor ?? Colors.white,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}

class ModalOverlay extends ModalRoute<void> {
  Widget overlayContent;

  ModalOverlay({required this.overlayContent});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          overlayContent,
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

void frequentCards(String? cardId) {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime today =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime weekAgo = today.subtract(const Duration(days: 6));
  firestore
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    if (value.exists) {
      Map<String, dynamic> frequentCards =
          value.data()!['frequentCards'] as Map<String, dynamic>;
      if (frequentCards.entries.any((element) => element.key == cardId) ==
          false) {
        frequentCards.addAll({
          '$cardId': List.generate(
              7,
              (index) => {
                    'date': DateTime(weekAgo.year, weekAgo.month, weekAgo.day)
                        .add(Duration(days: index)),
                    'count': 0
                  })
        });
        firestore
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'frequentCards': frequentCards});
      }
    }
  }).then((value) {
    firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        Map<String, dynamic> frequentCards =
            value.data()!['frequentCards'] as Map<String, dynamic>;
        if (frequentCards.entries.any((element) => element.key == cardId) ==
            true) {
          List<dynamic> cardData = frequentCards[cardId] as List<dynamic>;
          if ((cardData.asMap().entries.any((element) =>
                  element.value['date'].toDate().day == today.day &&
                  element.value['date'].toDate().month == today.month &&
                  element.value['date'].toDate().year == today.year)) ==
              false) {
            int daysSinceLast = today
                .difference((cardData.last['date'] as Timestamp).toDate())
                .inDays;
            for (int i = 0; i < daysSinceLast; i++) {
              cardData.add({
                'date': Timestamp.fromMillisecondsSinceEpoch(
                    (cardData.last['date'] as Timestamp)
                            .millisecondsSinceEpoch +
                        86400000),
                'count': 0
              });
            }
            while (cardData.length > 7) {
              cardData.removeAt(0);
            }
            firestore
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'frequentCards.$cardId': cardData});
          }
          cardData
              .asMap()
              .entries
              .where((element) =>
                  element.value['date'].toDate().day == today.day &&
                  element.value['date'].toDate().month == today.month &&
                  element.value['date'].toDate().year == today.year)
              .forEach((element) {
            cardData[element.key]['count']++;
            firestore
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'frequentCards.$cardId': cardData});
            return;
          });
        }
      }
    });
  });
}
