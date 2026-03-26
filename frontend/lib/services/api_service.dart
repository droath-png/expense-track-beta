import 'dart:convert';
import 'package:http/http.dart' as http;
import '../project/classes/input_model.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/api';
  String? _token;
  
  // Set token (call after login)
  void setToken(String token) {
    _token = token;
  }
  
  String? get token => _token;
  
  // Get headers with auth
  Map<String, String> _getHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }
  
  // Auth: Register
  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: _getHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token'];
      return data;
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }
  
  // Auth: Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _getHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token'];
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
  
  // Transactions: Get all
  Future<List<InputModel>> getTransactions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/transactions'),
      headers: _getHeaders(),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List transactions = data['transactions'];
      return transactions.map((t) => InputModel.fromApiJson(t)).toList();
    } else {
      throw Exception('Failed to load transactions: ${response.body}');
    }
  }
  
  // Transactions: Create
  Future<InputModel> createTransaction(InputModel transaction) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions'),
      headers: _getHeaders(),
      body: jsonEncode(transaction.toApiJson()),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return InputModel.fromApiJson(data['transaction']);
    } else {
      throw Exception('Failed to create transaction: ${response.body}');
    }
  }
  
  // Transactions: Update
  Future<InputModel> updateTransaction(String id, InputModel transaction) async {
    final response = await http.put(
      Uri.parse('$baseUrl/transactions/$id'),
      headers: _getHeaders(),
      body: jsonEncode(transaction.toApiJson()),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return InputModel.fromApiJson(data['transaction']);
    } else {
      throw Exception('Failed to update transaction: ${response.body}');
    }
  }
  
  // Transactions: Delete
  Future<void> deleteTransaction(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/transactions/$id'),
      headers: _getHeaders(),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete transaction: ${response.body}');
    }
  }
  
  // Transactions: Delete all
  Future<void> deleteAllTransactions() async {
    final response = await http.delete(
      Uri.parse('$baseUrl/transactions'),
      headers: _getHeaders(),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete all transactions: ${response.body}');
    }
  }
  
  // Categories: Get all
  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: _getHeaders(),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['categories']);
    } else {
      throw Exception('Failed to load categories: ${response.body}');
    }
  }
  
  // Categories: Create
  Future<Map<String, dynamic>> createCategory(Map<String, dynamic> category) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categories'),
      headers: _getHeaders(),
      body: jsonEncode(category),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['category'];
    } else {
      throw Exception('Failed to create category: ${response.body}');
    }
  }
  
  // Categories: Delete
  Future<void> deleteCategory(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/categories/$id'),
      headers: _getHeaders(),
    );
    
    if (response.statusCode != 200) {
      throw Exception('Failed to delete category: ${response.body}');
    }
  }
}
