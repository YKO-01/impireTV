import 'package:dio/dio.dart';
import '../models/api_response.dart';
import '../models/match.dart';
import '../models/team.dart';
import '../models/league.dart';
import '../models/standing.dart';

class ApiFootballService {
  static const String baseUrl = 'https://api-koora-production.up.railway.app/api/football';
  
  late final Dio _dio;

  ApiFootballService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<List<Match>> getLiveMatches() async {
    try {
      final response = await _dio.get('/live');
      final apiResponse = ApiResponse<List<Match>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Match.fromJson(e as Map<String, dynamic>)).toList(),
      );
      
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Failed to fetch live matches');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Match>> getTodayMatches() async {
    try {
      final response = await _dio.get('/today');
      final apiResponse = ApiResponse<List<Match>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Match.fromJson(e as Map<String, dynamic>)).toList(),
      );
      
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Failed to fetch today\'s matches');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Match>> getYesterdayMatches() async {
    try {
      final response = await _dio.get('/yesterday');
      final apiResponse = ApiResponse<List<Match>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Match.fromJson(e as Map<String, dynamic>)).toList(),
      );
      
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Failed to fetch yesterday\'s matches');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Match>> getTomorrowMatches() async {
    try {
      final response = await _dio.get('/tomorrow');
      final apiResponse = ApiResponse<List<Match>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Match.fromJson(e as Map<String, dynamic>)).toList(),
      );
      
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Failed to fetch tomorrow\'s matches');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Team>> getTeams() async {
    try {
      final response = await _dio.get('/teams');
      final apiResponse = ApiResponse<List<Team>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Team.fromJson(e as Map<String, dynamic>)).toList(),
      );
      
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Failed to fetch teams');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<Standing>> getStandings() async {
    try {
      final response = await _dio.get('/standings');
      final apiResponse = ApiResponse<List<Standing>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => Standing.fromJson(e as Map<String, dynamic>)).toList(),
      );
      
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Failed to fetch standings');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<List<League>> getLeagues() async {
    try {
      final response = await _dio.get('/leagues');
      final apiResponse = ApiResponse<List<League>>.fromJson(
        response.data,
        (json) => (json as List).map((e) => League.fromJson(e as Map<String, dynamic>)).toList(),
      );
      
      if (apiResponse.success && apiResponse.data != null) {
        return apiResponse.data!;
      }
      throw Exception(apiResponse.message ?? 'Failed to fetch leagues');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<bool> checkHealth() async {
    try {
      final response = await _dio.get('/health');
      return response.statusCode == 200;
    } on DioException {
      return false;
    }
  }

  Exception _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return Exception('Connection timeout. Please check your internet connection.');
    } else if (error.type == DioExceptionType.connectionError) {
      return Exception('No internet connection. Please check your network.');
    } else if (error.response != null) {
      return Exception('Server error: ${error.response?.statusCode}');
    } else {
      return Exception('An unexpected error occurred: ${error.message}');
    }
  }
}


