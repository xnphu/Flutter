crc16CcittFalse(data, offset, length) {
  if (data == null ||
      offset < 0 ||
      offset > data.length - 1 ||
      offset + length > data.length) {
    return 0;
  }

  var crc = 0xFFFF;
  for (int i = 0; i < length; ++i) {
    crc ^= data[offset + i] << 8;
    for (int j = 0; j < 8; ++j) {
      crc = (crc & 0x8000) > 0 ? (crc << 1) ^ 0x1021 : crc << 1;
    }
  }
  return crc & 0xFFFF;
}
