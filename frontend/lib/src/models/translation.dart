class TranslationRequest {
  TranslationRequest({
    required this.text,
    required this.sourceLanguage,
    required this.targetLanguage,
    this.tone,
    this.detailLevel,
    this.includeExamples = true,
  });

  final String text;
  final String sourceLanguage;
  final String targetLanguage;
  final String? tone;
  final String? detailLevel;
  final bool includeExamples;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'text': text,
      'source_language': sourceLanguage,
      'target_language': targetLanguage,
      if (tone != null) 'tone': tone,
      if (detailLevel != null) 'detail_level': detailLevel,
      'include_examples': includeExamples,
    };
  }
}

class TranslationSegment {
  TranslationSegment({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  factory TranslationSegment.fromJson(Map<String, dynamic> json) {
    return TranslationSegment(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );
  }
}

class TranslationResponse {
  TranslationResponse({
    required this.translation,
    required this.segments,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  final String translation;
  final List<TranslationSegment> segments;
  final String sourceLanguage;
  final String targetLanguage;

  factory TranslationResponse.fromJson(Map<String, dynamic> json) {
    final segmentsJson = json['segments'] as List<dynamic>? ?? <dynamic>[];

    return TranslationResponse(
      translation: json['translation'] as String? ?? '',
      sourceLanguage: json['source_language'] as String? ?? '',
      targetLanguage: json['target_language'] as String? ?? '',
      segments: segmentsJson
          .map((dynamic item) =>
              TranslationSegment.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
