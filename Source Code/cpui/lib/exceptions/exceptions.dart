class CpExceptions implements Exception {
  final _message;
  final _prefix;

  CpExceptions([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CpExceptions {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CpExceptions {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CpExceptions {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CpExceptions {
  InvalidInputException([String message]) : super(message, "Invalid Input: ");
}
