import 'package:flutter/material.dart';

import '../api/translator_api.dart';
import '../models/translation.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => _TranslatorPageState();
}

class _TranslatorPageState extends State<TranslatorPage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _sourceLanguageController = TextEditingController(text: 'fr');
  final _targetLanguageController = TextEditingController(text: 'en');
  final TranslatorApi _api = TranslatorApi();

  String? _selectedTone = 'friendly';
  String? _selectedDetail = 'detailed';
  bool _includeExamples = true;
  bool _isLoading = false;
  TranslationResponse? _lastResponse;
  String? _errorMessage;

  @override
  void dispose() {
    _textController.dispose();
    _sourceLanguageController.dispose();
    _targetLanguageController.dispose();
    _api.close();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final request = TranslationRequest(
      text: _textController.text.trim(),
      sourceLanguage: _sourceLanguageController.text.trim(),
      targetLanguage: _targetLanguageController.text.trim(),
      tone: _selectedTone,
      detailLevel: _selectedDetail,
      includeExamples: _includeExamples,
    );

    try {
      final response = await _api.translate(request);
      setState(() {
        _lastResponse = response;
      });
    } on TranslatorApiException catch (error) {
      setState(() {
        _errorMessage =
            'Erreur API (${error.statusCode})\n${error.body}'.trim();
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Erreur inattendue: $error';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Translator (mock)'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _textController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Texte à traduire',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Merci de saisir un texte';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _sourceLanguageController,
                        decoration: const InputDecoration(
                          labelText: 'Langue source',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Obligatoire';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _targetLanguageController,
                        decoration: const InputDecoration(
                          labelText: 'Langue cible',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Obligatoire';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedTone,
                        decoration: const InputDecoration(
                          labelText: 'Ton',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'friendly',
                            child: Text('Amical'),
                          ),
                          DropdownMenuItem(
                            value: 'formal',
                            child: Text('Formel'),
                          ),
                          DropdownMenuItem(
                            value: 'professional',
                            child: Text('Professionnel'),
                          ),
                          DropdownMenuItem(
                            value: 'simple',
                            child: Text('Simple'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedTone = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedDetail,
                        decoration: const InputDecoration(
                          labelText: 'Niveau de détail',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'summary',
                            child: Text('Résumé'),
                          ),
                          DropdownMenuItem(
                            value: 'standard',
                            child: Text('Standard'),
                          ),
                          DropdownMenuItem(
                            value: 'detailed',
                            child: Text('Détaillé'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedDetail = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  title: const Text('Inclure des exemples'),
                  value: _includeExamples,
                  onChanged: (value) {
                    setState(() {
                      _includeExamples = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _submit,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.translate),
                  label: Text(_isLoading ? 'Traduction...' : 'Traduire'),
                ),
                const SizedBox(height: 24),
                if (_errorMessage != null)
                  Card(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ),
                if (_lastResponse != null) ...[
                  Text(
                    'Traduction (${_lastResponse!.sourceLanguage} → ${_lastResponse!.targetLanguage})',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  SelectableText(_lastResponse!.translation),
                  const SizedBox(height: 16),
                  if (_lastResponse!.segments.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Segments',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ..._lastResponse!.segments.map(
                          (segment) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    segment.title,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(segment.content),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
