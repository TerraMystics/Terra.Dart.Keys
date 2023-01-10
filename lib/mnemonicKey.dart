import 'package:common_utils/common_utils.dart';
import 'package:terra_dart_keys/rawKey.dart';
import 'package:terra_dart_keys/src/constants/derivationPaths.dart';
import 'package:bip39/bip39.dart' as BIP39;
import 'package:bip32/bip32.dart';

class MnemonicKey extends RawKey {
  /// <summary>
  ///
  /// </summary>
  /// <param name="mnemonicKey"></param>
  MnemonicKey({String mnemonicKey = "", bool exposePrivateKey = false}) {
    prepareMnemonic(mnemonicKey, exposePrivateKey);
  }

  void prepareMnemonic(String mnemonicKey, bool exposePrivateKey) async {
    var mnemonic = BIP39.generateMnemonic(strength: 256);

    var seed = !TextUtil.isEmpty(mnemonicKey)
        ? BIP39.mnemonicToSeed(mnemonicKey)
        : BIP39.mnemonicToSeed(mnemonic);
    var masterKey = BIP32.fromSeed(seed);
    var terraHD = masterKey.derivePath(DerivationPaths.defaultLunaPath);
    var cprivateKey = terraHD.privateKey;

    if (cprivateKey == null) {
      throw Exception("Failed to generate signing pair");
    }

    preparePrivateKey(cprivateKey, exposePrivateKey: exposePrivateKey);
  }
}
