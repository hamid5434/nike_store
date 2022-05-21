import 'package:nike_store/common/http_client.dart';
import 'package:nike_store/data/source/comment_data_source.dart';
import 'package:nike_store/models/comment/comment.dart';

final commentRepository = CommentRepository(
  dataSource: CommentRemoteDataSource(httpClient: httpClient),
);

abstract class ICommentRepository {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRepository implements ICommentRepository {
  final ICommentDataSource dataSource;

  CommentRepository({required this.dataSource});

  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    List<CommentEntity> comments =
        await dataSource.getAll(productId: productId);
    return comments;
  }
}
