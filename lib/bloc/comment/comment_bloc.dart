import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/comment_repository.dart';
import 'package:nike_store/models/comment/comment.dart';

part 'comment_event.dart';

part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository repository;
  final int productId;

  CommentBloc({required this.repository, required this.productId})
      : super(CommentLoading()) {
    on<CommentEvent>((event, emit) async {
      if (event is CommentStarted) {
        emit(CommentLoading());
        try {
          final comments = await repository.getAll(productId: productId);
          emit(CommentSuccess(comments: comments));
        } catch (e) {
          emit(CommentError(
              exception: e is AppException
                  ? e
                  : AppException(message: e.toString(), statusCode: 1)));
        }
      }
    });
  }
}
