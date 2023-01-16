import 'dart:typed_data';
import 'package:sec/sec.dart';
import 'package:dart_bech32/dart_bech32.dart';
import 'package:terra_dart_keys/keys/simplePublicKey.dart';
import "package:hex/hex.dart";
import '../keys/constants/terraPubKeys.dart';

///Abstract Key Item
abstract class Key {
  SimplePublicKey? publicKey;

  Uint8List? privateKey;
  Uint8List? privateKeyExposed;

  void preparePrivateKey(Uint8List? cprivateKey,
      {bool exposePrivateKey = false}) {
    privateKey = cprivateKey;
    if (exposePrivateKey) {
      privateKeyExposed = privateKey;
    }

    var key = EC.secp256k1.createPublicKey(
        BigInt.parse(HEX.encode(Uint8List.fromList(privateKey!)), radix: 16),
        true);

    publicKey = SimplePublicKey(key);
  }

  ///Sign the Key
  Uint8List sign(Uint8List payload);

  String accAddress() {
    if (publicKey == null) {
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
