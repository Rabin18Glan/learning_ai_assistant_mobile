import 'package:flutter/material.dart';

/// Color palette for the EduSense AI app
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF3B82F6); // Blue-500
  static const Color primaryDark = Color(0xFF2563EB); // Blue-600
  static const Color primaryLight = Color(0xFF60A5FA); // Blue-400

  // Secondary colors
  static const Color secondary = Color(0xFF8B5CF6); // Violet-500
  static const Color secondaryDark = Color(0xFF7C3AED); // Violet-600
  static const Color secondaryLight = Color(0xFFA78BFA); // Violet-400

  // Accent colors
  static const Color accent = Color(0xFF10B981); // Emerald-500
  static const Color accentDark = Color(0xFF059669); // Emerald-600
  static const Color accentLight = Color(0xFF34D399); // Emerald-400

  // Feedback colors
  static const Color success = Color(0xFF10B981); // Emerald-500
  static const Color warning = Color(0xFFF59E0B); // Amber-500
  static const Color error = Color(0xFFEF4444); // Red-500
  static const Color info = Color(0xFF3B82F6); // Blue-500

  // Neutral colors
  static const Color black = Color(0xFF111827); // Gray-900
  static const Color darkGray = Color(0xFF1F2937); // Gray-800
  static const Color gray = Color(0xFF6B7280); // Gray-500
  static const Color lightGray = Color(0xFFE5E7EB); // Gray-200
  static const Color white = Color(0xFFFFFFFF); // White

  // Background colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceLight = Color(0xFFF9FAFB);
  static const Color surfaceDark = Color(0xFF1F2937);

  // Gradient colors
  static const List<Color> primaryGradient = [
    primary,
    Color(0xFF4F46E5)
  ]; // Blue to Indigo
  static const List<Color> secondaryGradient = [
    secondary,
    Color(0xFFEC4899)
  ]; // Violet to Pink
  static const List<Color> accentGradient = [
    accent,
    Color(0xFF0EA5E9)
  ]; // Emerald to Sky
  static const Color primaryGradientStart = Color(0xFF6A1B9A);
  static const Color primaryGradientEnd = Color(0xFF8E24AA);

  // Card colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1F2937);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF1F2937); // Gray-800
  static const Color textSecondaryLight = Color(0xFF6B7280); // Gray-500
  static const Color textPrimaryDark = Color(0xFFF9FAFB); // Gray-50
  static const Color textSecondaryDark = Color(0xFFD1D5DB); // Gray-300

  // Border colors
  static const Color borderLight = Color(0xFFE5E7EB); // Gray-200
  static const Color borderDark = Color(0xFF374151); // Gray-700
}
