class Officer {
  final String id;
  final String name;
  final String roomId;
  final String gender;
  final Position position;
  final String username;
  final String password;

  Officer copyWith(
          {String id,
          String name,
          String gender,
          String roomId,
          Position position,
          String username,
          String password}) =>
      Officer(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        roomId: roomId ?? this.roomId,
        position: position ?? this.position,
        username: username ?? this.username,
        password: password ?? this.password,
      );

  Officer(
      {this.id,
      this.name,
      this.roomId,
      this.gender,
      this.position = Position.NhanVien,
      this.username,
      this.password});
}

enum Position { TruongPhong, PhoPhong, NhanVien }
