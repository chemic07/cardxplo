class PremiumCardModel {
  final String id;
  final String uid;
  final String name;
  final String companyName;
  final String email;
  final String address;
  final DateTime createdAt;
  final String imageUrl;
  final String description;
  final String websiteUrl;
  final String phone;

  PremiumCardModel({
    required this.id,
    required this.name,
    required this.companyName,
    required this.email,
    required this.address,
    required this.createdAt,
    required this.imageUrl,
    required this.description,
    required this.websiteUrl,
    required this.phone,
    required this.uid,
  });

  PremiumCardModel copyWith({
    String? id,
    String? name,
    String? companyName,
    String? email,
    String? address,
    DateTime? createdAt,
    String? imageUrl,
    String? description,
    String? websiteUrl,
    String? phone,
    String? uid,
  }) {
    return PremiumCardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      phone: phone ?? this.phone,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'companyName': companyName,
      'email': email,
      'address': address,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
      'description': description,
      'websiteUrl': websiteUrl,
      'phone': phone,
      'uid': uid,
    };
  }

  factory PremiumCardModel.fromMap(Map<String, dynamic> map) {
    return PremiumCardModel(
      id: map[{"\$id"}] as String,
      name: map['name'] as String,
      companyName: map['companyName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] as int,
      ),
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      websiteUrl: map['websiteUrl'] as String,
      phone: map['phone'] as String,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() {
    return 'PremiumCardModel(id: $id, name: $name, companyName: $companyName, email: $email, address: $address, createdAt: $createdAt, imageUrl: $imageUrl, description: $description, websiteUrl: $websiteUrl, phone: $phone, uid :$uid)';
  }

  @override
  bool operator ==(covariant PremiumCardModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.companyName == companyName &&
        other.email == email &&
        other.address == address &&
        other.createdAt == createdAt &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.websiteUrl == websiteUrl &&
        other.phone == phone &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        companyName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        createdAt.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        websiteUrl.hashCode ^
        phone.hashCode ^
        uid.hashCode;
  }
}
