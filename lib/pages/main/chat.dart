import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../widgets/message.dart';
import '../../providers/img_store.dart';
import '../../settings/setting-data.dart';
import '../../settings/shared/data-shared.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map> msgAll = [];
  ScrollController scorllController = ScrollController();

  bool showSteam = false;
  String urlPath = urlServer;
  String urlPort = urlServerPort;
  late Uri url =
      Uri.parse('ws://${urlPath.split('//')[1]}:$urlPort/ws/delivery/1/');

  late WebSocketChannel _channel;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    first();
    super.initState();
  }

  void first() async {
    try {
      log('pass');
      setState(() {
        showSteam = true;
      });
      _channel = WebSocketChannel.connect(url);
    } catch (e) {
      log('error (first): $e');
      first();
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    var imgStore = context.read<ImgStore>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before_rounded,
            size: 30,
            color: brightness ? const Color(0xFF505050) : Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Chat Room',
          style: TextStyle(
            color: brightness ? const Color(0xFF505050) : Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: chatMessage(),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Consumer(
                    builder:
                        (BuildContext context, ImgStore value, Widget? child) {
                      return value.imgPath.toString().isEmpty
                          ? Container()
                          : imgMessage(value);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Expanded(
                  child: Form(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Send a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: imgStore.pickImageBase64,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD281),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD281),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget imgMessage(ImgStore data) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.18,
      padding: const EdgeInsets.all(15),
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...data.setImg.map((val) {
              return GestureDetector(
                onDoubleTap: () {
                  data.removeImg(data.setImg.indexOf(val));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Image.file(val),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  data.removeImg(data.setImg.indexOf(val));
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF505050),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget chatMessage() {
    return !showSteam
        ? const Text('Server Down | reconnect...')
        : StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (['ConnectionState.done']
                  .contains(snapshot.connectionState.toString())) {
                first();
                return const Text('ConnectionState.done | reconnect...');
              }
              if (snapshot.error != null) {
                first();
                return const Text('error | reconnect...');
              }

              if (snapshot.hasData) {
                var temp = jsonDecode(snapshot.data);

                msgAll.insert(0, temp);
                if (msgAll.length > 1) {
                  scorllController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              }

              return snapshot.hasData
                  ? GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: scorllController,
                              physics: const BouncingScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: msgAll.length,
                              itemBuilder: (context, index) {
                                return MessageBox(
                                  msg: msgAll[index]["message"],
                                  img: msgAll[index]["img"] ?? '',
                                  sender: msgAll[index]["name_send"],
                                  sentByMe: msgAll[index]["name_send"] ==
                                          UserData.userName &&
                                      msgAll[index]["id"] == UserData.userID,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                    );
            },
          );
  }

  void _sendMessage() async {
    var providerR = context.read<ImgStore>();

    if (_controller.text.isNotEmpty) {
      if (providerR.setImg.isNotEmpty) {
        await providerR.getUsersMhorKapao(providerR.setImgBase64[0].toString());
      }

      var formatDate = DateFormat('dd/MM/yyyy, HH:mm').format(DateTime.now());
      String text = jsonEncode({
        "message": _controller.text,
        "img": providerR.img.toString(),
        "id": UserData.userID,
        'name_send': UserData.userName,
        'time': formatDate,
      });

      _channel.sink.add(text);
      _controller.clear();
      providerR.removeImgAll();
    } else {
      if (providerR.setImg.isNotEmpty) {
        await providerR.getUsersMhorKapao(providerR.setImgBase64[0].toString());

        var formatDate = DateFormat('dd/MM/yyyy, HH:mm').format(DateTime.now());

        String text = jsonEncode({
          "message": '',
          "id": UserData.userID,
          'name_send': UserData.userName,
          'time': formatDate,
          "img": providerR.img.toString(),
        });

        _channel.sink.add(text);
        providerR.removeImgAll();
      }
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
