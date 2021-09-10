import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerPage extends StatefulWidget {
  const FilePickerPage({Key? key}) : super(key: key);

  @override
  _FilePickerPageState createState() => _FilePickerPageState();
}

class _FilePickerPageState extends State<FilePickerPage> {
  String? _directoryPath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: size.height,
            width: size.width,
            child: ListView(
              children: [
                ElevatedButton(
                  onPressed: _pickAFile,
                  child: const Text('Select file'),
                ),
                Text(_directoryPath ?? ""),
              ],
            )),
      ),
    );
  }

  _pickAFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        onFileLoading: (status) => print(status),
      );

      setState(() {
        _directoryPath = result?.paths.first;
      });
    } catch (ex) {
      print('Exception:  $ex' );
    }
  }
}
