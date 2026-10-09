// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: implementation_imports
//

import 'dart:convert';
import 'dart:io' as io show Directory, File;

import 'package:tarot_again/util/flutter_util.dart';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/src/widgets/_window.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tarot_again/util/util.dart';
import 'package:flutter_quill/flutter_quill.dart';
// import 'package:flutter_quill_example/quill_delta_sample.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart' as path;

class JournalEditor extends StatefulWidget with Logging {
  JournalEditor({super.key}) {
    verbose("JournalEditor constructor called");
  }

  // final WindowController windowController;

  @override
  State<JournalEditor> createState() => _JournalEditorState();
}

class _JournalEditorState extends State<JournalEditor> with Logging {
  // final WindowController windowController = WindowController(
  //   size: const Size(800, 600),
  //   title: 'Tarot Again app',
  //   delegate: WindowControllerDelegate(),
  // );
  // final WindowSettings settings = RegularWindowSettings();

  final QuillController _controller = () {
    return QuillController.basic(
      config: QuillControllerConfig(
        clipboardConfig: QuillClipboardConfig(
          enableExternalRichPaste: true,
          onImagePaste: (imageBytes) async {
            if (kIsWeb) {
              // Dart IO is unsupported on the web.
              return null;
            }
            // Save the image somewhere and return the image URL that will be
            // stored in the Quill Delta JSON (the document).
            final newFileName =
                'image-file-${DateTime.now().toIso8601String()}.png';
            final newPath = path.join(
              io.Directory.systemTemp.path,
              newFileName,
            );
            final file = await io.File(newPath)
                .writeAsBytes(imageBytes, flush: true);
            return file.path;
          },
        ),
      ),
    );
  }();

  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();

  @override
  void initState() {
    verbose("_JournalEditorState initState called");
    super.initState();
    // Load document
    _controller.document = Document(); // empty document
  }

  @override
  Widget build(BuildContext context) {
    verbose("_JournalEditorState build() called");
    // final windowController = WindowScope.of(context).windowController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quill Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.output),
            tooltip: 'Print Delta JSON to log',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'The JSON Delta has been printed to the console.',
                  ),
                ),
              );
              debugPrint(jsonEncode(_controller.document.toDelta().toJson()));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            QuillSimpleToolbar(
              controller: _controller,
              config: QuillSimpleToolbarConfig(
                embedButtons: FlutterQuillEmbeds.toolbarButtons(),
                showClipboardPaste: true,
                showDirection: true,
                customButtons: [
                  QuillToolbarCustomButtonOptions(
                    icon: const Icon(Icons.add_alarm_rounded),
                    onPressed: () {
                      _controller.document.insert(
                        _controller.selection.extentOffset,
                        TimeStampEmbed(DateTime.now().toString()),
                      );

                      _controller.updateSelection(
                        TextSelection.collapsed(
                          offset: _controller.selection.extentOffset + 1,
                        ),
                        ChangeSource.local,
                      );
                    },
                  ),
                ],
                buttonOptions: QuillSimpleToolbarButtonOptions(
                  base: QuillToolbarBaseButtonOptions(
                    afterButtonPressed: () {
                      final isDesktop = {
                        TargetPlatform.linux,
                        TargetPlatform.windows,
                        TargetPlatform.macOS,
                      }.contains(defaultTargetPlatform);
                      if (isDesktop) {
                        _editorFocusNode.requestFocus();
                      }
                    },
                  ),
                  linkStyle: QuillToolbarLinkStyleButtonOptions(
                    validateLink: (link) {
                      // Treats all links as valid. When launching the URL,
                      // `https://` is prefixed if the link is incomplete (e.g., `google.com` → `https://google.com`)
                      // however this happens only within the editor.
                      return true;
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: QuillEditor(
                focusNode: _editorFocusNode,
                scrollController: _editorScrollController,
                controller: _controller,
                config: QuillEditorConfig(
                  placeholder: 'Start writing your notes...',
                  padding: const EdgeInsets.all(16),
                  embedBuilders: [
                    ...FlutterQuillEmbeds.editorBuilders(
                      imageEmbedConfig: QuillEditorImageEmbedConfig(
                        imageProviderBuilder: (context, imageUrl) {
                          // https://pub.dev/packages/flutter_quill_extensions#-image-assets
                          if (imageUrl.startsWith('assets/')) {
                            return AssetImage(imageUrl);
                          }
                          return null;
                        },
                      ),
                      videoEmbedConfig: QuillEditorVideoEmbedConfig(
                        customVideoBuilder: (videoUrl, readOnly) {
                          // To load YouTube videos https://github.com/singerdmx/flutter-quill/releases/tag/v10.8.0
                          return null;
                        },
                      ),
                    ),
                    TimeStampEmbedBuilder(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    verbose("_JournalEditorState dispose() called");
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    // widget.windowController.dispose();
    super.dispose();
  }
}

class TimeStampEmbed extends Embeddable {
  const TimeStampEmbed(String value) : super(timeStampType, value);

  static const String timeStampType = 'timeStamp';

  static TimeStampEmbed fromDocument(Document document) =>
      TimeStampEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class TimeStampEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'timeStamp';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded),
        Text(embedContext.node.value.data as String),
      ],
    );
  }
}
