class DetailDataHotel {
  final int id;
  final int cityId;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String image;
  final String description;

  final int starNumber;

  final List<Service> services;
  final List<Room> rooms;
  final List<ImageHotel> images;

  DetailDataHotel({
    required this.id,
    required this.cityId,
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.image,
    required this.starNumber,
    required this.description,
    required this.services,
    required this.rooms,
    required this.images,
  });

  factory DetailDataHotel.fromJson(Map<String, dynamic> json) {
    final servicesJson = json['services'] as List<dynamic>;
    final services =
        servicesJson.map((service) => Service.fromJson(service)).toList();

    final roomsJson = json['rooms'] as List<dynamic>;
    final rooms = roomsJson.map((room) => Room.fromJson(room)).toList();

    final imagesJson = json['images'] as List<dynamic>;
    final images =
        imagesJson.map((image) => ImageHotel.fromJson(image)).toList();

    return DetailDataHotel(
      id: json['id'],
      cityId: json['city_id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      image: json['image'],
      starNumber: json['star_number'],
      description: json['description'],
      services: services,
      rooms: rooms,
      images: images,
    );
  }
}

class Service {
  final int id;
  final int hotelId;
  final String name;

  Service({
    required this.id,
    required this.hotelId,
    required this.name,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      hotelId: json['hotel_id'],
      name: json['name'],
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
  final TypeRoom typeRoom;
  final List<ImageRoom> imageRoom;
  final List<ServiceRoom> serviceRoom;

  Room(
      {required this.id,
      required this.hotelId,
      required this.typeRoomId,
      required this.name,
      required this.description,
      required this.status,
      required this.typeRoom,
      required this.serviceRoom,
      required this.imageRoom});

  factory Room.fromJson(Map<String, dynamic> json) {
    final imageRoomJson = json['images_room'] as List<dynamic>;
    final images =
        imageRoomJson.map((image) => ImageRoom.fromJson(image)).toList();
    final serviceJson = json['service_room'] as List<dynamic>;
    final services =
        serviceJson.map((image) => ServiceRoom.fromJson(image)).toList();
    return Room(
        id: json['id'],
        hotelId: json['hotel_id'],
        typeRoomId: json['type_room_id'],
        name: json['name'],
        description: json['description'],
        status: json['status'],
        typeRoom: TypeRoom.fromJson(json['type_room']),
        serviceRoom: services,
        imageRoom: images);
  }
}

class ImageRoom {
  final int id;
  final String image;
  final int roomId;

  ImageRoom({required this.id, required this.image, required this.roomId});
  factory ImageRoom.fromJson(Map<String, dynamic> json) {
    return ImageRoom(
      id: json['id'],
      image: json['image'],
      roomId: json['room_id'],
    );
  }
}

class ServiceRoom {
  final int id;
  final String service;
  final int roomId;

  ServiceRoom({required this.id, required this.service, required this.roomId});
  factory ServiceRoom.fromJson(Map<String, dynamic> json) {
    return ServiceRoom(
      id: json['id'],
      service: json['name'],
      roomId: json['room_id'],
    );
  }
}

class ImageHotel {
  final int id;
  final String image;
  final int hotelId;

  ImageHotel({
    required this.id,
    required this.image,
    required this.hotelId,
  });

  factory ImageHotel.fromJson(Map<String, dynamic> json) {
    return ImageHotel(
      id: json['id'],
      image: json['image'],
      hotelId: json['hotel_id'],
    );
  }
}

class TypeRoom {
  int? id;
  String? name;
  int? price;
  int? area;
  String? numberOfPeople;
  String? numberOfBed;

  TypeRoom(
      {this.id,
      this.name,
      this.price,
      this.area,
      this.numberOfPeople,
      this.numberOfBed});

  TypeRoom.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    price = json['price'] ?? '';
    area = json['area'] ?? '';
    numberOfPeople = json['number_of_people'] ?? '';
    numberOfBed = json['number_of_bed'] ?? '';
  }
}
