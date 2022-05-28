class AppException {
  final String message;
  final int statusCode;

  AppException({ this.message = 'خطای نامشخص',  this.statusCode = 1});
}
