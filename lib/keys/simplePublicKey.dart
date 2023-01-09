import 'package:protobuf_google/protobuf_google.dart';
import 'package:terra_dart_sdk_extensions/dart_extensions.dart';

import '../src/extensions/publicKeyExtensions.dart';
import 'constants/cosmosKeys.dart';
import 'constants/tendermintKeys.dart';

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

  // List<int> encodeAminoPubkey() {
  //   var base64Data = PublicKeyExtensions.getBase64DataFromKey(key);
  //   return PublicKeyExtensions.mergeDataArrays(base64Data);
  // }
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
