class Dump {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String ocrText;
  final String category;
  final String subcategory;
  final List<String> tags;
  final double confidence;
  final DateTime createdAt;
  final bool isPinned;
  final bool hasReminder;
  final List<String> suggestionProviders;
  final bool isTrashed;
  final DateTime? trashedAt;

  Dump({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.ocrText,
    required this.category,
    required this.subcategory,
    required this.tags,
    required this.confidence,
    required this.createdAt,
    required this.isPinned,
    required this.hasReminder,
    required this.suggestionProviders,
    this.isTrashed = false,
    this.trashedAt,
  });

  factory Dump.fromJson(Map<String, dynamic> json) {
    return Dump(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      ocrText: json['ocrText'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      tags: List<String>.from(json['tags'] as List),
      confidence: (json['confidence'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isPinned: json['isPinned'] as bool,
      hasReminder: json['hasReminder'] as bool,
      suggestionProviders: List<String>.from(json['suggestionProviders'] as List),
      isTrashed: json['isTrashed'] as bool? ?? false,
      trashedAt: json['trashedAt'] != null ? DateTime.parse(json['trashedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'ocrText': ocrText,
      'category': category,
      'subcategory': subcategory,
      'tags': tags,
      'confidence': confidence,
      'createdAt': createdAt.toIso8601String(),
      'isPinned': isPinned,
      'hasReminder': hasReminder,
      'suggestionProviders': suggestionProviders,
      'isTrashed': isTrashed,
      'trashedAt': trashedAt?.toIso8601String(),
    };
  }

  Dump copyWith({
    String? id,
    String? title,
    String? thumbnailUrl,
    String? ocrText,
    String? category,
    String? subcategory,
    List<String>? tags,
    double? confidence,
    DateTime? createdAt,
    bool? isPinned,
    bool? hasReminder,
    List<String>? suggestionProviders,
    bool? isTrashed,
    DateTime? trashedAt,
  }) {
    return Dump(
      id: id ?? this.id,
      title: title ?? this.title,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      ocrText: ocrText ?? this.ocrText,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      tags: tags ?? this.tags,
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
      isPinned: isPinned ?? this.isPinned,
      hasReminder: hasReminder ?? this.hasReminder,
      suggestionProviders: suggestionProviders ?? this.suggestionProviders,
      isTrashed: isTrashed ?? this.isTrashed,
      trashedAt: trashedAt ?? this.trashedAt,
    );
  }

  int get daysLeftInTrash {
    if (!isTrashed || trashedAt == null) return 0;
    final daysSinceTrashed = DateTime.now().difference(trashedAt!).inDays;
    return 60 - daysSinceTrashed;
  }
}
