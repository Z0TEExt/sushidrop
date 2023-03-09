import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../settings/setting-data.dart';
import '../animations/my_animation_dailog.dart';

class MessageBox extends StatefulWidget {
  final String msg;
  final String img;
  final String sender;
  final bool sentByMe;

  const MessageBox({
    super.key,
    required this.msg,
    required this.img,
    required this.sender,
    required this.sentByMe,
  });

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    var query = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment:
              widget.sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!widget.sentByMe)
              const SizedBox(
                height: 50,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/icon.jpg'),
                  backgroundColor: Colors.black,
                ),
              ),
            Container(
              padding: EdgeInsets.only(
                left: widget.sentByMe ? 0 : 15,
                right: widget.sentByMe ? 15 : 0,
              ),
              alignment: widget.sentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: widget.sentByMe
                      ? const Color(0xFFFFD281)
                      : Theme.of(context).backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.msg != '')
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: query.width * 0.4,
                        ),
                        child: Text(
                          widget.msg,
                          style: TextStyle(
                            fontSize: 18,
                            color: brightness == Brightness.light
                                ? const Color(0xFF505050)
                                : Colors.white,
                          ),
                        ),
                      ),
                    if (widget.msg != '' && widget.img != '')
                      const SizedBox(height: 10),
                    if (widget.img != '')
                      GestureDetector(
                        onTap: () async {
                          await showDialog(
                            barrierDismissible: true,
                            barrierColor: const Color.fromARGB(60, 0, 0, 0),
                            context: context,
                            builder: (context) {
                              return GestureDetector(
                                child: FunkyOverlay(
                                  showMyAnimationDialog: imageDialog(
                                    '$urlServer/${widget.img}',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            height: query.height * 0.18,
                            width: query.width * 0.4,
                            fit: BoxFit.cover,
                            imageUrl: '$urlServer/${widget.img}',
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget imageDialog(String x) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(fit: BoxFit.cover, imageUrl: x),
      ),
    );
  }
}
