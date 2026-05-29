import 'dart:io';
import 'package:untitled1/services/auth_service.dart';

class AuthMenu {
  final _authService = AuthService();

  Future<bool> showMenu() async {
    while (true) {
      print("\n================ AUTHENTICATION ================");
      print("1. Login Account");
      print("2. Register New Account");
      print("3. Shutdown Application");
      stdout.write("Select action: ");

      // Null-protected input reading
      String choice = stdin.readLineSync()?.trim() ?? "";

      if (choice == '1') {
        print("\n--- LOGIN FORM ---");
        stdout.write("Email Address: ");
        String email = stdin.readLineSync()?.trim() ?? "";
        stdout.write("Password: ");
        String password = stdin.readLineSync()?.trim() ?? "";

        if (email.isEmpty || password.isEmpty) {
          print("⚠️ Inputs cannot be empty!");
          continue;
        }

        print("Authenticating with server...");
        String result = await _authService.login(email, password);
        print(result);

        if (result.startsWith("Success")) {
          return true;
        }
      }
      else if (choice == '2') {
        print("\n--- REGISTRATION FORM ---");
        stdout.write("Username: ");
        String username = stdin.readLineSync()?.trim() ?? "";
        stdout.write("Email Address: ");
        String email = stdin.readLineSync()?.trim() ?? "";
        stdout.write("Password: ");
        String password = stdin.readLineSync()?.trim() ?? "";
        stdout.write("Date of Birth (YYYY-MM-DD): ");
        String dob = stdin.readLineSync()?.trim() ?? "";

        if (username.isEmpty || email.isEmpty || password.isEmpty || dob.isEmpty) {
          print("⚠️ All registration fields are required!");
          continue;
        }

        print("Saving account to system...");
        String result = await _authService.register(username, email, password, dob);
        print(result);
      }
      else if (choice == '3') {
        print("Application stopped successfully.");
        exit(0);
      }
      else {
        print("❌ Unknown instruction. Please select option 1, 2, or 3.");
      }
    }
  }
}