import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  // Update this to your running .NET API port
  final String baseUrl = "https://localhost:7063/api/Auth";

  Future<String> register(String userName, String email, String password, String dob) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "userName": userName,
          "email": email,
          "password": password,
          "dateOfBirth": dob,
        }),
      );

      // Protect against null or empty response body
      if (response.body.isEmpty) return "Error: Server returned an empty response.";
      final responseData = jsonDecode(response.body) as Map<String, dynamic>?;

      if (response.statusCode == 200) {
        return "Success: ${responseData?['message'] ?? 'Registration successful!'}";
      } else {
        return "Error: ${responseData?['message'] ?? 'Registration failed.'}";
      }
    } catch (e) {
      return "Connection Error: Unable to communicate with the authentication server.";
    }
  }

  Future<String> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.body.isEmpty) return "Error: Server returned an empty response.";
      final responseData = jsonDecode(response.body) as Map<String, dynamic>?;

      if (response.statusCode == 200) {
        return "Success: ${responseData?['message'] ?? 'Login successful!'}";
      } else {
        return "Error: ${responseData?['message'] ?? 'Invalid credentials.'}";
      }
    } catch (e) {
      return "Connection Error: Unable to communicate with the authentication server.";
    }
  }
}