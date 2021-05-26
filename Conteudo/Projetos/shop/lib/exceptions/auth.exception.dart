class AuthException implements Exception{

  static const Map<String, String> erros = {
    "EMAIL_EXISTS" : "E-mail ja cadastrado!",
    "OPERATION_NOT_ALLOWED": "Operação não permitida!",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Muita tentativas, tente mais tarde!",
    "EMAIL_NOT_FOUND":"E-mail/Senha invalidos!",
    "INVALID_PASSWORD":"E-mail/Senha invalidos!",
    "USER_DISABLED":"Usuario desativado!"
  };

  final  String key;

  const AuthException(this.key);

  @override
    String toString() {
      if(erros.containsKey(key)){
        return erros[key];
      }
      return "Ocorreu um erro na autenticação";
    }
}