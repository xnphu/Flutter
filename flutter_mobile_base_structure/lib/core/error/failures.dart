abstract class Failure {
  String message;
  Failure({this.message});
}

class RemoteFailure extends Failure {
  dynamic data;
  RemoteFailure({String msg, this.data}) : super(message: msg);
}

class CacheFailure extends Failure {
  CacheFailure({String msg}) : super(message: msg);
}

class UnknownFailure extends Failure {
  UnknownFailure({String msg}) : super(message: msg);
}

const UNKNOWN_ERROR_MESSAGE = 'Lỗi không xác định';
const LOGOUT_ERROR_MESSAGE = 'Lỗi không thể đăng xuất';
const INTERNET_ERROR_MESSAGE = 'Bạn vui lòng kiểm tra kết nối mạng';
const SOCKET_ERROR_MESSAGE = 'Không thể kết nối đến server.';
const SERVER_ERROR_MESSAGE = 'Server đang bảo trì. Vui lòng quay lại lúc khác';
const USER_NAME_OR_PASSWORD_ERROR_MESSAGE =
    "Tài khoản hoặc mật khẩu không chính xác";
const TOKEN_EMPTY_ERROR = 'Access Token không khả dụng';

const UNAUTHORIZED_ERROR_CODE = "Unauthorized";
const UNSETTING_BIOMETRIC_ERROR_CODE_MESSAGE =
    "Đăng nhập bằng nhận dạng sinh trắc học chưa được cài đặt";

const MESSAGE_IS_LOCKED_MESSAGE = "Tin nhắn đã bị khoá";

const MESSAGE_IS_LOCKED_KEY = "message_is_locked";
