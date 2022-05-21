import 'package:dio/dio.dart';
import 'package:nike_store/common/http_reponse_validator_dart.dart';
import 'package:nike_store/models/comment/comment.dart';

abstract class ICommentDataSource {
  Future<List<CommentEntity>> getAll({required int productId});
}

class CommentRemoteDataSource
    with HttpResponseValidator
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource({required this.httpClient});

  @override
  Future<List<CommentEntity>> getAll({required int productId}) async {
    final response = await httpClient.get('/comment/list?product_id=$productId');
    validateResponse(response);
    List<CommentEntity> comments = CommentEntitys.fromJson(response.data).list;
    return comments;
  }
}
