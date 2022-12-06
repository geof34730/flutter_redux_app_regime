class LoginStateParam {
  late String? uuid;
  LoginStateParam({
    required this.uuid,
  });

    factory LoginStateParam.initial() => LoginStateParam(
      uuid:null,
  );
  dynamic toJson(LoginStateParam) {
    return {
      "uuid":uuid,
    };
  }
}