import 'dart:io';
import 'package:untitled1/services/product_service.dart';
import 'package:untitled1/models/product.dart';

class ProductMenu {
  final _productService = ProductService();

  Future<void> showMenu() async {
    while (true) {
      print("\n================ SYSTEM MAIN DASHBOARD ================");
      print("1. Display All Products");
      print("2. Create New Product Entity");
      print("3. Update Existing Product"); // 👈 Added this
      print("4. Remove Product by ID");    // 👈 Shifted down to 4
      print("5. Log Out Session");         // 👈 Shifted down to 5
      stdout.write("Select action: ");

      String choice = stdin.readLineSync()?.trim() ?? "";

      if (choice == '1') {
        print("\n========================= CURRENT INVENTORY TABLE =========================");
        List<Product> products = await _productService.getAllProducts();

        if (products.isEmpty) {
          print(" No product records found or database connection dropped.");
        } else {
          // 1. Define specific, predictable columns block widths
          const int idWidth = 6;
          const int nameWidth = 22;
          const int stockWidth = 10;
          const int priceWidth = 12;
          const int descWidth = 25;

          // 2. Print Table Header Row Border
          print("+" + "-" * (idWidth + nameWidth + stockWidth + priceWidth + descWidth + 8) + "+");

          // 3. Print Table Header Titles
          String header = "|"
              + " ID".padRight(idWidth) + " | "
              + " PRODUCT NAME".padRight(nameWidth) + " | "
              + " STOCK".padRight(stockWidth) + " | "
              + " PRICE".padRight(priceWidth) + " | "
              + " DESCRIPTION".padRight(descWidth) + " |";
          print(header);

          // 4. Print Table Sub-Header Separator Border line
          print("+" + "-" * (idWidth + nameWidth + stockWidth + priceWidth + descWidth + 8) + "+");

          // 5. Populate Data Rows systematically inside loops
          for (var p in products) {
            // Trim long descriptions gracefully so they don't break row lines
            String displayDesc = p.productDescription;
            if (displayDesc.length > descWidth - 3) {
              displayDesc = displayDesc.substring(0, descWidth - 3) + "...";
            }

            String row = "|"
                + " ${p.id}".padRight(idWidth) + " | "
                + " ${p.productName}".padRight(nameWidth) + " | "
                + " ${p.stock}".padRight(stockWidth) + " | "
                + " \$${p.qty.toStringAsFixed(2)}".padRight(priceWidth) + " | "
                + " $displayDesc".padRight(descWidth) + " |";
            print(row);
          }

          // 6. Print Bottom Closing Table Line
          print("+" + "-" * (idWidth + nameWidth + stockWidth + priceWidth + descWidth + 8) + "+");
          print(" Total Records Found: ${products.length}");
        }
      }
      else if (choice == '2') {
        print("\n--- NEW PRODUCT REGISTRATION ---");
        stdout.write("Name of Product: ");
        String name = stdin.readLineSync()?.trim() ?? "";
        stdout.write("Warehouse Stock: ");
        int stock = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
        stdout.write("Item Quantity / Price Value: ");
        double qty = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;
        stdout.write("Brief Description: ");
        String desc = stdin.readLineSync()?.trim() ?? "";

        if (name.isEmpty) {
          print("⚠️ Product Name is strictly required.");
          continue;
        }

        print("Sending payload data to central database server...");
        bool success = await _productService.createProduct(name, stock, qty, desc);
        if (success) {
          print("✅ Product entry successfully saved to database!");
        } else {
          print("❌ Transaction aborted: Could not process values.");
        }
      }
      // 🟢 NEW UPDATE CODE SECTION BLOCK
      else if (choice == '3') {
        print("\n--- UPDATE PRODUCT ENTITY ---");
        stdout.write("Enter Target Product ID to update: ");
        int? id = int.tryParse(stdin.readLineSync() ?? "");

        if (id == null) {
          print("⚠️ Invalid format. ID must be an integer.");
          continue;
        }

        stdout.write("New Product Name: ");
        String name = stdin.readLineSync()?.trim() ?? "";
        stdout.write("New Warehouse Stock: ");
        int stock = int.tryParse(stdin.readLineSync() ?? "") ?? 0;
        stdout.write("New Price Value: ");
        double qty = double.tryParse(stdin.readLineSync() ?? "") ?? 0.0;
        stdout.write("New Description: ");
        String desc = stdin.readLineSync()?.trim() ?? "";

        if (name.isEmpty) {
          print("⚠️ Product Name cannot be left blank.");
          continue;
        }

        print("Sending update query requests to server tables...");
        bool success = await _productService.updateProduct(id, name, stock, qty, desc);
        if (success) {
          print("✅ Product details successfully synchronized!");
        } else {
          print("❌ Update aborted: Target ID not found or server refused modification.");
        }
      }
      else if (choice == '4') {
        print("\n--- REMOVE INVENTORY RECORD ---");
        stdout.write("Target Product Identifier ID: ");
        int? id = int.tryParse(stdin.readLineSync() ?? "");

        if (id == null) {
          print("⚠️ Invalid format. ID must be a valid integer code number.");
          continue;
        }

        print("Executing deletion sequence...");
        bool success = await _productService.deleteProduct(id);
        if (success) {
          print("✅ Record wiped from server tables.");
        } else {
          print("❌ Request failed: Target ID does not exist or server error.");
        }
      }
      else if (choice == '5') {
        print("Ending session loop...");
        break;
      }
      else {
        print("❌ Invalid command. Try again.");
      }
    }
  }
}