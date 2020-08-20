enum ApiMethod { get, post, put, delete }

abstract class IApiInput {
  String endPoint;
  dynamic body;
  ApiMethod method;
  Map<String, String> header;

  IApiInput(this.endPoint, this.method, this.header, this.body);
}

class ApiInput extends IApiInput {
  ApiInput(String endPoint, ApiMethod method, Map<String, String> header,
      dynamic body)
      : super(endPoint, method, header, body);
}
