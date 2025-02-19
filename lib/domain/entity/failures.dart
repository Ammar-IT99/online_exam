class Failures{
  String? errorMessage;
  Failures({required this.errorMessage});

}
class ServerError extends Failures{
  ServerError({required String errorMessage}) : super(errorMessage: errorMessage);


}
class NetworkError extends Failures{
  NetworkError({required String errorMessage}) : super(errorMessage: errorMessage);
}