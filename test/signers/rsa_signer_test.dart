// Copyright (c) 2013, Iván Zaera Avellón - izaera@gmail.com
// Use of this source code is governed by a LGPL v3 license.
// See the LICENSE file for more information.

library cipher.test.paddings.rsa_signer_test;

import 'package:bignum/bignum.dart';
import "package:cipher/cipher.dart";
import "package:cipher/impl/base.dart";

import "../test/signer_tests.dart";
import "../test/src/helpers.dart";
import "../test/src/null_secure_random.dart";

/// NOTE: the expected results for these tests are computed using the Java version of Bouncy Castle
void main() {

  initCipher();

  var modulus = new BigInteger("20620915813302906913761247666337410938401372343750709187749515126790853245302593205328533062154315527282056175455193812046134139935830222032257750866653461677566720508752544506266533943725970345491747964654489405936145559121373664620352701801574863309087932865304205561439525871868738640172656811470047745445089832193075388387376667722031640892525639171016297098395245887609359882693921643396724693523583076582208970794545581164952427577506035951122669158313095779596666008591745562008787129160302313244329988240795948461701615228062848622019620094307696506764461083870202605984497833670577046553861732258592935325691");
  var publicExponent = new BigInteger("65537");
  var privateExponent = new BigInteger("11998058528661160053642124235359844880039079149364512302169225182946866898849176558365314596732660324493329967536772364327680348872134489319530228055102152992797567579226269544119435926913937183793755182388650533700918602627770886358900914370472445911502526145837923104029967812779021649252540542517598618021899291933220000807916271555680217608559770825469218984818060775562259820009637370696396889812317991880425127772801187664191059506258517954313903362361211485802288635947903604738301101038823790599295749578655834195416886345569976295245464597506584866355976650830539380175531900288933412328525689718517239330305");
  var p = new BigInteger("144173682842817587002196172066264549138375068078359231382946906898412792452632726597279520229873489736777248181678202636100459215718497240474064366927544074501134727745837254834206456400508719134610847814227274992298238973375146473350157304285346424982280927848339601514720098577525635486320547905945936448443");
  var q = new BigInteger("143028293421514654659358549214971921584534096938352096320458818956414890934365483375293202045679474764569937266017713262196941957149321696805368542065644090886347646782188634885321277533175667840285448510687854061424867903968633218073060468434469761149335255007464091258725753837522484082998329871306803923137");

  var pubk = new RSAPublicKey(modulus, publicExponent);
  var privk = new RSAPrivateKey(modulus, privateExponent, p, q);

  var pubParams = () => new ParametersWithRandom(new PublicKeyParameter<RSAPublicKey>(pubk), new NullSecureRandom());
  var privParams = () => new ParametersWithRandom(new PrivateKeyParameter<RSAPrivateKey>(privk), new NullSecureRandom());

  runSignerTests( new Signer("SHA-512/RSA"), privParams, pubParams, [

    "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
    _newSignature(
        "7f612335cb7553c1eb4713a036825a0e5eb8eb21ea3993e02ee2bb4a64d0be79e7a4d7717f7604a51cf989725087f0b25aa1b20e9ee08c165e4015"
        "8f66a443338f3f83b6c8707a4e3303e1f90f3ba5254ce65f14cf1305cb993335773d087174bc1a95b88185ef16f7a6c4e6e48fe11d3a5604b2bd1c"
        "601100b49a762c07c2a5c473ccba3e079e8c53e5a18beb1246d6eef45c39a610dea48d1b7f46931da2cda454697ad1a4f62a6aa90e0026cefcb23b"
        "67e52579c41cf431509cb1140b9d63fad68642fca34afeeac6069336abc233056db29a2a9b1e1e4ae65a38f9032e1693a6be052fec5bc9044665bf"
        "d19c29ecddff7e26f0a3228ecc4c8f9ec70d3c1b"
    ),

    "En un lugar de La Mancha, de cuyo nombre no quiero acordarme...",
    _newSignature(
        "49b57219db717dee1485a7fe7fd8baa43f53fd736057a9313848b61996b8c5b080c52920450d17215bc2a115188b7267d2bcfbbbb7d6a21223e215"
        "53356d40a0f12d9b0b7363580b129f5ffaa540f8421485b2cac677d6b16adc5d27d70ddc28685a055a2bcf4173311e862024bc953927ef4a68d7ba"
        "467c3db538e778360fce218b748411e16f0c265ccd956b712843d99beb6467284f618e87df949a994dce54abe771a5e80b6adef2d61b2c11267ad7"
        "b98687ec39ad9ad1f8f77c4a8b6e018e3e4e511b5566dd78abca25429c384ad7b21dab9fdf3c53c15c30640d8f3e2aefb660e9e490f2f0fc7f4a6e"
        "7057de5fb39249a3110b0be105107b3d3bcfc3d2"
    ),

  ]);
}

RSASignature _newSignature(String value)
  => new RSASignature(createUint8ListFromHexString(value));









