import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_bech32/dart_bech32.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:terra_dart_keys/keys/simplePublicKey.dart';
import 'package:terra_dart_sdk_extensions/dart_extensions.dart';

import '../keys/constants/terraPubKeys.dart';

///Abstract Key Item
abstract class Key {
  SimplePublicKey? publicKey;

  Uint8List? privateKey;
  Uint8List? privateKeyExposed;

  void preparePrivateKey(Uint8List? privateKey,
      {bool exposePrivateKey = false}) {
    privateKey = privateKey;
    if (exposePrivateKey) {
      privateKeyExposed = privateKey;
    }

    var key = PrivateKey.fromHex(TerraStringExtension.toStringHex(privateKey!));
    var hexKey = key.signature(key.publicKey.toHex()).toString();
    publicKey = SimplePublicKey(
        base64.encode(TerraStringExtension.getBytesFromString(hexKey)));
  }

  ///Sign the Key
  Uint8List sign(Uint8List payload);

  String accAddress() {
    if (publicKey != null) {
      throw Exception('Could not compute accAddress: missing rawAddress');
    }

    return publicKey!.address();
  }

  // /**
  //  * Terra validator address. `terravaloper-` prefixed.
  //  */
  String valAddress() {
    if (publicKey == null) {
      throw Exception('Could not compute valAddress: missing rawAddress');
    }

    return bech32.encode(Decoded(
        prefix: TerraPubKeys.TERRA_DEV_KEYNAME,
        words: bech32.toWords(publicKey!.rawAddress())));
  }
}
