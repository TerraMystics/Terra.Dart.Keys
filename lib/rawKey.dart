import 'dart:typed_data';

import 'package:ecdsa/ecdsa.dart';
import 'package:terra_dart_keys/src/key.dart';
import 'package:terra_dart_sdk_extensions/extensions/hash/hashExtensions.dart';
import 'package:elliptic/elliptic.dart';

class RawKey extends Key {
  SignatureModel ecdsaSign(Uint8List payload) {
    var ec = getP256();

    var sign = signature(PrivateKey.fromBytes(ec, privateKey!),
        HashExtensions.getSha256(payload));
    return SignatureModel(sign.toCompact(), sign.R);
  }

  @override
  Uint8List sign(Uint8List payload) {
    var signature = ecdsaSign(payload).signature;
    return Uint8List.fromList(signature!);
  }
}

class SignatureModel {
  List<int>? signature;
  BigInt? recid;

  SignatureModel(this.signature, this.recid);
}
