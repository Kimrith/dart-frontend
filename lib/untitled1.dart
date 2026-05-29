// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class Category {
//   final int id;
//   final String imageUrl;
//   final String categoryName;
//
//   Category({
//     required this.id,
//     required this.imageUrl,
//     required this.categoryName,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['id'],
//       imageUrl: json['imageUrl'],
//       categoryName: json['categoryName'],
//     );
//   }
// }
//
// void main() async {
//   print('Fetching data...');
//
//   final String url = 'http://localhost:5167/api/Categories';
//
//   try {
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       List data = jsonDecode(response.body);
//
//       List<Category> categories = data
//           .map((item) => Category.fromJson(item))
//           .toList();
//
//       print('\n--- Success ---');
//
//       for (Category cat in categories) {
//         print('ID: ${cat.id}');
//         print('Category: ${cat.categoryName}');
//         print('Image: ${cat.imageUrl}');
//         print('----------------');
//       }
//     } else {
//       print(
//           'Failed to get data. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }