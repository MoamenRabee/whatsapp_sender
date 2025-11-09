class MessageData {
  final int? customerId;
  final String? serviceType;
  final String? price;
  final String? fromNumber;
  final String toNumber;
  final String messageContent;
  final String? status;
  final List<dynamic>? metadata;
  final String? updatedAt;
  final String? createdAt;
  final int? id;
  final int? msgId;

  MessageData({
    this.customerId,
    this.serviceType,
    this.price,
    this.fromNumber,
    required this.toNumber,
    required this.messageContent,
    this.status,
    this.metadata,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.msgId,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      customerId: json['customer_id'] as int?,
      serviceType: json['service_type'] as String?,
      price: json['price']?.toString(),
      fromNumber: json['from_number'] as String?,
      toNumber: json['to_number']?.toString() ?? '',
      messageContent: json['message_content']?.toString() ?? '',
      status: json['status'] as String?,
      metadata: json['metadata'] as List<dynamic>?,
      updatedAt: json['updated_at'] as String?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
      msgId: json['msg_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'customer_id': customerId,
    'service_type': serviceType,
    'price': price,
    'from_number': fromNumber,
    'to_number': toNumber,
    'message_content': messageContent,
    'status': status,
    'metadata': metadata,
    'updated_at': updatedAt,
    'created_at': createdAt,
    'id': id,
    'msg_id': msgId,
  };
}
