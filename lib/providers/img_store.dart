import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../settings/setting-data.dart';

class ImgStore extends ChangeNotifier {
  List setImg = [];
  List setImgBase64 = [];
  String img = '';
  File? imgPath;

  final ImagePicker _imagepicker = ImagePicker();

  void pickImageBase64() async {
    final XFile? image = await _imagepicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    Uint8List imagebyte = await image.readAsBytes();
    String base64 = "data:image/png;base64,${base64Encode(imagebyte)}";
    imgPath = File(image.path);

    setImg.add(imgPath);
    setImgBase64.add(base64);
    notifyListeners();
  }

  void removeImg(int x) {
    setImg.remove(setImg[x]);
    setImgBase64.remove(setImgBase64[x]);
    notifyListeners();
  }

  void removeImgAll() {
    setImg.clear();
    setImgBase64.clear();
    img = '';
    notifyListeners();
  }

  Future<void> getUsersMhorKapao(String imageBase64) async {
    String url = '$urlServer/main/api_upload_image/';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "image": imageBase64,
        },
      ),
    );
    var data = await jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["error"] == "") {
        img = data["image"];
      } else {
        debugPrint("Error 1");
      }
    } else {
      debugPrint("Error 2");
    }
    notifyListeners();
  }
}
