enum ChatMessageType { text, audio, image, video }

enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;
  final String? sender;
  final String? senderImage;
  final String? imageUrl;

  ChatMessage(
      {this.text = '',
      required this.messageType,
      required this.messageStatus,
      required this.isSender,
      this.sender,
      this.senderImage,
      this.imageUrl});
}

List<ChatMessage> dummyCHatMessages = [
  ChatMessage(
      text: "hi Eslam",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: false),
  ChatMessage(
      text: "hi Eslam",
      messageType: ChatMessageType.text,
      messageStatus: MessageStatus.viewed,
      isSender: true),
  ChatMessage(
      text: "hi Eslam",
      messageType: ChatMessageType.video,
      messageStatus: MessageStatus.viewed,
      isSender: false),
  ChatMessage(
      text: "hi Eslam",
      messageType: ChatMessageType.audio,
      messageStatus: MessageStatus.not_view,
      isSender: true)
];
