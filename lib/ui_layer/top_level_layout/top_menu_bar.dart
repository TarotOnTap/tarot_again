import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarot_again/util/util.dart';

Future<void> saveGeneratedLayout() async {
  final directory = await getDownloadsDirectory();

  String? outputFile = await FilePicker.platform.saveFile(
    initialDirectory: directory?.path,
    dialogTitle: 'Please select an output file:',
    fileName: '',
  );

  if (outputFile != null) {
    await sl<LayoutManager>().generateLayoutsFile(outputFile);
  }
}

/// this class builds the menu bar
class TopMenuBar extends StatelessWidget {
  const TopMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: MenuBar(
            children: <Widget>[
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'MenuBar Sample',
                        applicationVersion: '1.0.0',
                      );
                    },
                    child: const MenuAcceleratorLabel('&About'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Saved!')));
                    },
                    child: const MenuAcceleratorLabel('&Save'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Quit!')));
                    },
                    child: const MenuAcceleratorLabel('&Quit'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&File'),
              ),
              SubmenuButton(
                menuChildren: <Widget>[
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Magnify!')));
                    },
                    child: const MenuAcceleratorLabel('&Magnify'),
                  ),
                  MenuItemButton(
                    onPressed: () {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Minify!')));
                    },
                    child: const MenuAcceleratorLabel('Mi&nify'),
                  ),
                ],
                child: const MenuAcceleratorLabel('&View'),
              ),
              if (kDebugMode)
                SubmenuButton(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () => unawaited(saveGeneratedLayout()),
                      child: const MenuAcceleratorLabel("Generate Layouts"),
                    ),
                  ],
                  child: const MenuAcceleratorLabel("Dev"),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
