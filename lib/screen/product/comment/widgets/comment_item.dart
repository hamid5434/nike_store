import 'package:flutter/material.dart';
import 'package:nike_store/models/comment/comment.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, required this.comment}) : super(key: key);
  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              spreadRadius: 1,
              blurRadius: 10,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(comment.title!),
                  Text(
                    comment.email!,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Text(
                comment.date!,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Text(comment.content!),
        ],
      ),
    );
  }
}
