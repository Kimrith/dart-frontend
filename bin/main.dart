import 'auth_menu.dart';
import 'product_menu.dart';

void main(List<String> arguments) async {
  final authMenu = AuthMenu();
  final productMenu = ProductMenu();

  print("=== Central Management CLI Application Initialized ===");

  while (true) {
    // 1. Force authorization validation
    bool accessGranted = await authMenu.showMenu();

    // 2. Open control loop upon validation confirmation
    if (accessGranted) {
      await productMenu.showMenu();
    }
  }
}