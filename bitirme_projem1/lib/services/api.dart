import 'package:dio/dio.dart';

class API {

  // Burada dio nesnesini oluşturduk, istek gönderip cevap almak için
  final dio = Dio();

  // Burası ana adresimiz. Her yerde tek tek yazmak yerine burada yani en dışta 1 kez yazdık
  final String baseUrl = "";


  // Kayıtlı kullanıcıların giriş yapması için fonksiyon oluşturdum
  // Required yazarak mail ve şifreyi zorunlu tuttum
  loginUser({required String mail, required String passwords}) async {
    try {

      final String endUrl = "$baseUrl/login";

      final parameters = {
        "email": mail,
        "password": passwords,
      };

      final response = await dio.post(endUrl, data: FormData.fromMap(parameters));

      return response.data; // Map yapısı şeklinde döndürmesi için burada data yazdım
    }
    catch(e) {
      return e;
    }
  }

  registerUser({
    required String name,
    required String mail, 
    required String passwords, 
    required int Id,
    }) async {
    try {

      final String endUrl = "$baseUrl/register";

      final parameters = {
        "name" : name,
        "email": mail,
        "password": passwords,
        "password_confirmation" : passwords,
        "id" : Id,
      };

      final response = await dio.post(endUrl, data: parameters);

      return response.data; // Map yapısı şeklinde döndürmesi için burada data yazdım
    }
    catch(e) {
      return e;
    }
  }

}