import 'package:terra_dart_sdk_extensions/dart_extensions.dart';
import '../../keys/constants/tendermintKeys.dart';

class PublicKeyExtensions {
  static final List<int> pubkeyAminoPrefixSecp256k1 =
      TerraStringExtension.getBytesFromString("eb5ae98721");
  static final List<int> pubkeyAminoPrefixEd25519 =
      TerraStringExtension.getBytesFromString("1624de6420");
  static final List<int> pubkeyAminoPrefixMultisigThreshold =
      TerraStringExtension.getBytesFromString("22c1f7e2");

  static List<int> getBase64DataFromKey(String key) {
    return TerraStringExtension.getBytesFromString(
        TerraStringExtension.getBase64FromString(key));
  }

  static List<int> encodeUVariant(int result) {
    if (result > 127) {
      throw Exception(
          "Encoding numbers > 127 is not supported here. Please tell those lazy CosmJS maintainers " +
              "to port the binary.PutUvarint implementation from the Go standard library and write some tests.");
    }
    return [result];
  }

  static bool isSimpleKey(String typeUrl) {
    return typeUrl == TendermintKeys.TENDERMINT_SIMPLE_PUBKEY;
  }

  static bool isValConsPublicKey(String typeUrl) {
    return typeUrl == TendermintKeys.TENDERMINT_VALCONS_PUBKEY;
  }

  static bool isLegacyMultiSigKey(String typeUrl) {
    return typeUrl == TendermintKeys.TENDERMINT_LEGACY_MULTISIG_AMINO_PUBKEY;
  }
}
