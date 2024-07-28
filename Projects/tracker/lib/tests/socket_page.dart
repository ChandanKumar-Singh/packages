// import 'dart:async';

// import 'package:ext_plus/ext_plus.dart' hide Debouncer;
// import 'package:flutter/material.dart';
// import 'package:flutter_debouncer/flutter_debouncer.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   connectAndListen();
//   runApp(const MaterialApp(
//     home: BuildWithSocketStream(),
//   ));
// }

// //STEP2: Add this function in main function in main.dart file and add incoming data to the stream
// late IO.Socket socket;
// void connectAndListen() {
//   try {
//     socket = IO.io('http://192.168.1.125:3000',
//         OptionBuilder().setTransports(['websocket']).build());

//     socket.onConnect((_) {
//       print('connect');
//     });
//     socket.onDisconnect((_) => print('disconnect'));
//     socket.connect();
//   } catch (e, st) {
//     logg('connectAndListen error $e', stackTrace: st);
//   }
// }

// //Step3: Build widgets with streambuilder

// class BuildWithSocketStream extends StatefulWidget {
//   const BuildWithSocketStream({super.key});

//   @override
//   State<BuildWithSocketStream> createState() => _BuildWithSocketStreamState();
// }

// class _BuildWithSocketStreamState extends State<BuildWithSocketStream> {
//   final ScrollController scrollController = ScrollController();
//   List collectedData = [];
//   @override
//   void initState() {
//     super.initState();
//     on('connection');
//     afterBuildCreated(() {
//       socket.emit('connection', 'test');
//     });
//   }

//   handleData(String event, dynamic data) {
//     collectedData.add(data);
//     setState(() {});
//     scrollController.animateTo(
//       scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   registerAllListeners() {
//     unRegisterAllListeners();
//     on('hellow');
//     on('test');
//     on('error');
//     on('current_time');
//   }

//   on(String event) {
//     socket.on(event, (data) => handleData(event, data));
//   }

//   unRegisterAllListeners() {
//     socket.off('hellow');
//     socket.off('test');
//     socket.off('error');
//     socket.off('current_time');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           /// connect
//           IconButton(
//             icon: const Icon(Icons.connect_without_contact),
//             onPressed: () {
//               connectAndListen();
//             },
//           ),

//           /// go to chat page
//           IconButton(
//             icon: const Icon(Icons.chat),
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => const ChatPage(roomId: 'roomId_276'),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         reverse: true,
//         controller: scrollController,
//         itemCount: collectedData.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(collectedData[index].toString()),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           registerAllListeners();
//           socket.emit(
//             'current_time',
//             {
//               'test': 'test',
//               'time': DateTime.now().toIso8601String(),
//             },
//           );
//         },
//         label: const Text('hit'),
//       ),
//     );
//   }
// }

// /// create chat page
// /// listen to chat message on socket chat and handle data

// class ChatPage extends StatefulWidget {
//   const ChatPage({super.key, required this.roomId});
//   final String roomId;

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   ValueNotifier<List<ChatModel>> chatData = ValueNotifier([]);
//   final ScrollController scrollController = ScrollController();
//   String? userId;
//   ValueNotifier<bool> receiverTyping = ValueNotifier(false);
//   ValueNotifier<bool> senderTyping = ValueNotifier(false);
//   late String typingId;
//   @override
//   void initState() {
//     super.initState();
//     userId = socket.id;
//     typingId = 'typing_${widget.roomId}';
//     listen();
//     textController.addListener(_onTextChanged);
//   }

//   listen() {
//     socket.on('chat', (data) {
//       if (data is Map) addChat(data['reply']);
//     });
//     socket.on(widget.roomId, (v) {
//       logg('receiverTyping room ${widget.roomId} $v');
//       if (v is bool) receiverTyping.value = v;
//     });
//     socket.on(typingId, (v) {
//       logg('senderTyping room ${widget.roomId} $v');
//       if (v is bool) senderTyping.value = v;
//     });
//   }

//   addChat(Map data) {
//     print('roomId_276 data ${data}');
//     chatData.value = [
//       ...chatData.value,
//       ChatModel.fromJson(data.cast<String, dynamic>()),
//     ];
//     scrollToBottom();
//   }

//   scrollToBottom() {
//     scrollController.animateTo(
//       scrollController.position.maxScrollExtent + 200,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   @override
//   void dispose() {
//     socket.off('chat');
//     socket.off(widget.roomId);
//     socket.off('typing_${widget.roomId}');
//     super.dispose();
//   }

//   final TextEditingController textController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<List<ChatModel>>(
//         valueListenable: chatData,
//         builder: (context, chats, child) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Chat'),
//               actions: [
//                 IconButton(
//                   onPressed: () {
//                     var location = {
//                       "userId": 'UserRepository.instance.getAuthToken()',
//                       "latitude": 12.9715987,
//                       "longitude": 77.5945627
//                     };
//                     socket.emitWithAck('addLocation', location,
//                         ack: (location) {
//                       print('location $location');
//                     });
//                   },
//                   icon: const Icon(Icons.add_location_alt_sharp),
//                 ),
//               ],
//             ),
//             body: Column(
//               children: [
//                 ListView(
//                   padding: const EdgeInsetsDirectional.only(
//                     top: 20,
//                     bottom: 20,
//                     start: 10,
//                     end: 10,
//                   ),
//                   // reverse: true,
//                   controller: scrollController,
//                   children: [
//                     ...chats.map((chat) {
//                       return item(chat);
//                     }),
//                     typing(sender: false),
//                     typing(sender: true),
//                   ],
//                 ).expand(),
//                 bottom(),
//               ],
//             ),
//             // floatingActionButton: bottom(),
//           );
//         });
//   }

//   Widget typing({required bool sender}) {
//     return ValueListenableBuilder(
//         valueListenable: !sender ? receiverTyping : senderTyping,
//         builder: (context, value, child) {
//           return value
//               ? Row(
//                   mainAxisAlignment:
//                       sender ? MainAxisAlignment.end : MainAxisAlignment.start,
//                   children: [
//                     Container(
//                       margin: const EdgeInsetsDirectional.only(start: 20),
//                       decoration: BoxDecoration(
//                         color: context.theme.shadowColor.withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       padding: const EdgeInsetsDirectional.symmetric(
//                           horizontal: 10, vertical: 10),
//                       width: 80,
//                       height: 30,
//                       child: LoadingAnimationWidget.staggeredDotsWave(
//                         color: context.theme.primaryColor.withOpacity(0.5),
//                         size: 30,
//                       ),
//                     ),
//                   ],
//                 )
//               : const SizedBox();
//         });
//   }

//   Widget item(ChatModel chat) {
//     bool isMe = chat.sender == userId;
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       child: Row(
//         mainAxisAlignment:
//             isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (!isMe)
//                 CircleAvatar(
//                   radius: 20,
//                   child: FittedBox(
//                     child: Text(
//                       isMe ? 'Me' : 'Admin',
//                     ).paddingAll(5),
//                   ),
//                 ).paddingRight(10),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: isMe ? Colors.blue : Colors.grey,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       isMe ? 'Me' : 'Admin',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     10.height,
//                     Text(
//                       chat.message ?? '',
//                       style: const TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     10.height,
//                     Text(
//                       chat.time?.toString() ?? '',
//                       style: const TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   final Debouncer _debouncer = Debouncer();
//   Timer? _typingDetacher;
//   void _onTextChanged() {
//     _typingDetacher?.cancel();
//     if (textController.text.isEmpty) {
//       socket.emit(typingId, false);
//       return;
//     }
//     _debouncer.debounce(
//       duration: const Duration(milliseconds: 500),
//       onDebounce: () => socket.emit(typingId, true),
//     );
//     _typingDetacher = Timer(const Duration(seconds: 3), () {
//       logg('countdown finished ${_typingDetacher?.isActive}',
//           name: '_typingDetacher');
//       if (_typingDetacher == null) return;
//       logg('reporting typing false', name: '_typingDetacher');
//       socket.emit(typingId, false);
//       _typingDetacher = null;
//     });
//   }

//   Widget bottom() {
//     return Container(
//       margin: const EdgeInsetsDirectional.only(bottom: 10, end: 10),
//       padding: const EdgeInsetsDirectional.all(10),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: context.theme.primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: const EdgeInsetsDirectional.only(end: 10),
//               child: Row(
//                 children: [
//                   IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.attachment_rounded)
//                           .rotate(angle: -1 / 2)),
//                   TextField(
//                     autofocus: true,
//                     controller: textController,
//                     decoration: const InputDecoration(
//                       hintText: 'Enter message',
//                       border: InputBorder.none,
//                     ),
//                   ).expand(),
//                   IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.camera_alt_rounded))
//                 ],
//               ),
//             ),
//           ),
//           10.width,
//           IconButton.filled(
//               onPressed: _onSend,
//               icon: const Icon(Icons.send).rotate(angle: -1 / 2)),
//         ],
//       ),
//     );
//   }

//   ///
//   void _onSend() {
//     if (textController.text.isEmpty) return;
//     var data = {
//       'id': DateTime.now().toIso8601String(),
//       'message': textController.text,
//       'sender': userId,
//       'receiver': 'admin',
//       'time': DateTime.now().toLocal().millisecondsSinceEpoch,
//     };
//     addChat(data);
//     // _typingDetacher?.cancel();
//     // _typingDetacher = null;
//     socket.emit('chat', {"roomId": widget.roomId, "message": data});
//     senderTyping.value = false;
//     socket.emit(typingId, false);
//     textController.clear();
//   }
// }

// class ChatModel {
//   String? message;
//   String? sender;
//   String? receiver;
//   DateTime? time;
//   String? id;
//   ChatModel({
//     this.message,
//     this.sender,
//     this.receiver,
//     this.time,
//     this.id,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'message': message,
//       'sender': sender,
//       'receiver': receiver,
//       'time': time?.toLocal().millisecondsSinceEpoch,
//     };
//   }

//   factory ChatModel.fromJson(Map<String, dynamic> json) {
//     return ChatModel(
//       id: json['id'],
//       message: json['message'],
//       sender: json['sender'],
//       receiver: json['receiver'],
//       time: tryCatch(() => DateTime.fromMillisecondsSinceEpoch(json['time'])),
//     );
//   }
// }
