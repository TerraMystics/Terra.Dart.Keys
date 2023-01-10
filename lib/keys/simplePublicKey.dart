import 'dart:convert';
import 'dart:typed_data';

import 'package:buffer/buffer.dart';
import 'package:protobuf_google/protobuf_google.dart';
import 'package:terra_dart_keys/keys/constants/terraPubKeys.dart';
import 'package:terra_dart_sdk_extensions/dart_extensions.dart';
import 'package:terra_dart_sdk_extensions/extensions/hash/hashExtensions.dart';
import '../src/extensions/publicKeyExtensions.dart';
import 'constants/cosmosKeys.dart';
import 'constants/tendermintKeys.dart';
import 'package:dart_bech32/dart_bech32.dart';

class SimplePublicKey {
  String? key;
  SimplePublicKey(this.key);

  Any packAny() {
    return Any(typeUrl: CosmosKeys.SECP256K1_SIMP_PUBKEY);
  }

  //  static SimplePublicKey UnPackAny(Any msgAny)
  // {
  //     return FromProto(ProtoExtensions.DeserialiseFromBytes<PubKey>(msgAny.Value));
  // }

  SimplePublicKeyDataArgs toData() {
    return SimplePublicKeyDataArgs(key);
  }

  //  PubKey ToProtoWithType()
  // {
  //     return new PubKey()
  //     {
  //         Key = TerraStringExtensions.GetBase64BytesFromString(this.key)
  //     };
  // }

  // List<int> toProto() {
  //   return ProtoExtensions.SerialiseFromData(this.ToProtoWithType());
  // }

  SimplePublicKeyAminoArgs toAmino() {
    return SimplePublicKeyAminoArgs(key);
  }

  static SimplePublicKey fromAmino(SimplePublicKeyAminoArgs data) {
    return SimplePublicKey(data.key);
  }

  static SimplePublicKey fromData(SimplePublicKeyDataArgs data) {
    return SimplePublicKey(data.key);
  }

  // static SimplePublicKey fromProto(PubKey data) {
  //   return SimplePublicKey(TerraStringExtension.getBase64FromBytes(data.Key));
  // }

  Uint8List encodeAminoPubkey() {
    var buffer = BytesBuffer();
    buffer.add(PublicKeyExtensions.pubkeyAminoPrefixSecp256k1);
    buffer.add(TerraStringExtension.getBytesFromBase64(key!));

    return buffer.toBytes();
  }

  Uint8List rawAddress() {
    var pubkeyData = base64.decode(key!);
    return HashExtensions.ripemd160(HashExtensions.getSha256(pubkeyData));
  }

  String address() {
    return bech32.encode(Decoded(
        prefix: TerraPubKeys.TERRA_PUBLIC_KEYNAME,
        words: bech32.toWords(rawAddress())));
  }

  String pubkeyAddress() {
    return bech32.encode(Decoded(
        prefix: TerraPubKeys.TERRA_PUB,
        words: bech32.toWords(encodeAminoPubkey())));
  }
}

class SimplePublicKeyAminoArgs extends SimplePublicKeyCommonArgs {
  SimplePublicKeyAminoArgs(String? key) : super(key) {
    type = TendermintKeys.TENDERMINT_SIMPLE_PUBKEY;
  }
}

class SimplePublicKeyDataArgs extends SimplePublicKeyCommonArgs {
  SimplePublicKeyDataArgs(String? key) : super(key) {
    type = CosmosKeys.SECP256K1_SIMP_PUBKEY;
  }
}

class SimplePublicKeyCommonArgs {
  String? type;
  String? key;

  SimplePublicKeyCommonArgs(this.key);
}
