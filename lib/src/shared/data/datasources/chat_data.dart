List<Map<String, dynamic>> chats = [
  {
    'id': 'chat_1',
    'userIds': ['user_1', 'user_2'],
    'messages': [
      {
        'messageId': 'message_1',
        'senderId': 'user_1',
        'recipientId': 'user_2',
        'text':
            'Hey, it\'s me!\nBlah blah blah...blah this is a long message!\nMamma mia',
        'createdAt': DateTime(2022, 08, 01, 10, 10, 10),
      },
      {
        'messageId': 'message_2',
        'senderId': 'user_1',
        'recipientId': 'user_2',
        'text': 'How are you?',
        'createdAt': DateTime(2022, 08, 01, 10, 10, 20),
      },
      {
        'messageId': 'message_3',
        'senderId': 'user_2',
        'recipientId': 'user_1',
        'text': 'I am good, thanks.',
        'createdAt': DateTime(2022, 08, 01, 10, 10, 12),
      }
    ]
  },
  {
    'id': 'chat_2',
    'userIds': ['user_1', 'user_3'],
    'messages': [
      {
        'messageId': 'message_1',
        'senderId': 'user_1',
        'recipientId': 'user_3',
        'text': 'Hey, how are you?',
        'createdAt': DateTime(2022, 08, 01, 10, 12, 10),
      },
      {
        'messageId': 'message_2',
        'senderId': 'user_3',
        'recipientId': 'user_1',
        'text': 'I am good, thanks.',
        'createdAt': DateTime(2022, 08, 01, 10, 12, 22),
      }
    ]
  }
];
