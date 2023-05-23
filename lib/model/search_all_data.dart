class Hotel {
  final int id;
  final int cityId;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String image;
  final int starNumber;
  final int lowestPrice;

  final List<Room> rooms;

  Hotel({
    required this.id,
    required this.cityId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.image,
    required this.starNumber,
    required this.rooms,
    required this.lowestPrice,
  });
  factory Hotel.fromJson(Map<String, dynamic> json) {
    final roomsJson = json['rooms'] as List<dynamic>;
    final rooms = roomsJson.map((roomJson) => Room.fromJson(roomJson)).toList();

    return Hotel(
      id: json['id'] ?? 0,
      cityId: json['city_id'] ?? 0,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      starNumber: json['star_number'] ?? 0,
      lowestPrice: json['lowestPrice'] ?? 0,
      rooms: rooms,
    );
  }
}

class Room {
  final int id;
  final int hotelId;
  final int typeRoomId;
  final String name;
  final String description;
  final int status;
  final RoomType typeRoom;

  Room({
    required this.id,
    required this.hotelId,
    required this.typeRoomId,
    required this.name,
    required this.description,
    required this.status,
    required this.typeRoom,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    final typeRoomJson = json['type_room'] as Map<String, dynamic>;
    final typeRoom = RoomType.fromJson(typeRoomJson);

    return Room(
      id: json['id'] ?? 0,
      hotelId: json['hotel_id'] ?? 0,
      typeRoomId: json['type_room_id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 0,
      typeRoom: typeRoom,
    );
  }
}

class RoomType {
  final int id;
  final String name;
  final int price;
  final int area;
  final String numberOfPeople;
  final String numberOfBed;

  RoomType({
    required this.id,
    required this.name,
    required this.price,
    required this.area,
    required this.numberOfPeople,
    required this.numberOfBed,
  });

  factory RoomType.fromJson(Map<String, dynamic> json) {
    return RoomType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      area: json['area'] ?? 0,
      numberOfPeople: json['number_of_people'] ?? '',
      numberOfBed: json['number_of_bed'] ?? '',
    );
  }
}
