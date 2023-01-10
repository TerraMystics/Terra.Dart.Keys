import 'dart:typed_data';

import 'package:terra_dart_keys/src/key.dart';

class RawKey extends Key {


  List<int> ecdsaSign(List<int> payload) {
    var data = TerraStringExtensions.GetBytesFromString(
        HashExtensions.HashToHex(
            TerraStringExtensions.GetBase64FromBytes(payload)));
    return Secp256K1Manager.SignCompressedCompact(data, this.privateKey);
  }

  Future<List<int>> sign(List<int> payload) {
    if (!BitConverter.IsLittleEndian) Array.Reverse(payload);

    return this.EcdsaSign(payload);
  }
}
