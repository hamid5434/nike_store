import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/bloc/comment/comment_bloc.dart';
import 'package:nike_store/data/repo/comment_repository.dart';
import 'package:nike_store/screen/product/comment/widgets/comment_item.dart';
import 'package:nike_store/widgets/widgets.dart';

class CommentList extends StatelessWidget {
  const CommentList({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentBloc bloc =
            CommentBloc(repository: commentRepository, productId: productId);
        bloc.add(CommentStarted());
        return bloc;
      },
      child: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CommentSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return CommentItem(comment: state.comments[index]);
                },
                childCount: state.comments.length,
              ),
            );
          } else if (state is CommentError) {
            return SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: AppErrorWidget(
                  onTab: () {
                    BlocProvider.of<CommentBloc>(context).add(CommentStarted());
                  },
                  exception: state.exception,
                ),
              ),
            );
          } else {
            throw Exception('state not support');
          }
        },
      ),
    );
  }
}
