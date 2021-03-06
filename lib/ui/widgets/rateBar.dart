import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../core/viewmodels/UserModel.dart';
import '../../core/models/toilet.dart';
import '../../core/services/api.dart';
import '../../locator.dart';
import './button.dart';

class RateBar extends StatefulWidget {
  RateBar(this.toilet, this._api);
  Toilet toilet;
  API _api;
  int myVote;

  @override
  _RateBarState createState() => _RateBarState();
}

class _RateBarState extends State<RateBar> {
  int calculateVote(bool isUpvote) {
    // returns vote value
    // 1 is an upvote
    // 0 counts as a withdrawn, neutral vote
    // -1 is a downvote

    switch (widget.myVote) {
      // i had an upvote
      case 1:
        return isUpvote ? 0 : -1;
      // i had a downvote
      case -1:
        return isUpvote ? 1 : 0;
      // i didn't have a vote
      default:
        return isUpvote ? 1 : -1;
    }
  }

  void castVote(String userId, bool isUpvote) {
    int vote = calculateVote(isUpvote);
    setState(() {
      widget.myVote = vote;
    });

    Map<String, int> votes = widget.toilet.votes;
    votes[userId] = vote;

    Map<String, Map<String, int>> data = new Map<String, Map<String, int>>();
    data["votes"] = votes;
    widget._api.updateDocument(data, widget.toilet.id);
  }

  @override
  Widget build(BuildContext context) {
    final String userId = locator<UserModel>().userId;
    widget.myVote = widget.toilet.votes[userId] ?? 0;
    int upvotes = 0;
    int downvotes = 0;

    widget.toilet.votes.values.forEach((int value) {
      switch (value) {
        case 1:
          upvotes++;
          break;
        case -1:
          downvotes++;
          break;
      }
    });

    return Row(
      children: <Widget>[
        Text(
          FlutterI18n.translate(context, "rate"),
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Button(
            // widget.toilet.upvotes.toString(),
            upvotes.toString(),
            () => castVote(userId, true),
            icon: Icons.thumb_up,
            backgroundColor:
                widget.myVote == 1 ? Colors.black : Colors.grey[600],
            foregroundColor: Colors.white,
            isMini: true,
          ),
        ),
        Button(
          // widget.toilet.downvotes.toString(),
          downvotes.toString(),
          () => castVote(userId, false),
          icon: Icons.thumb_down,
          backgroundColor:
              widget.myVote == -1 ? Colors.black : Colors.grey[600],
          foregroundColor: Colors.white,
          isMini: true,
        ),
      ],
    );
  }
}
