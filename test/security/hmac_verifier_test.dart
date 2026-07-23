import 'package:demo_flutter/security/hmac_config.dart';
import 'package:demo_flutter/security/hmac_verifier.dart';
import 'package:demo_flutter/security/request_signer.dart';
import 'package:demo_flutter/security/signature_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late RequestSigner signer;
  late HmacVerifier verifier;

  setUp(() {
    signer = RequestSigner();
    verifier = HmacVerifier();
  });

  group('HmacVerifier', () {
    test('valid signature passes verification', () {
      final signed = signer.sign(
        method: 'GET',
        path: '/users',
      );

      final result = verifier.verify(
        method: 'GET',
        path: '/users',
        timestamp: signed.timestamp,
        nonce: signed.nonce,
        receivedSignature: signed.signature,
      );

      expect(result.isValid, isTrue);
      expect(result.message, 'Signature is valid');
    });

    test('tampered body fails verification', () {
      final signed = signer.sign(
        method: 'POST',
        path: '/posts',
        body: '{"title":"original"}',
      );

      final result = verifier.verifyWithTamperedBody(
        method: 'POST',
        path: '/posts',
        timestamp: signed.timestamp,
        nonce: signed.nonce,
        receivedSignature: signed.signature,
        originalBody: '{"title":"original"}',
        tamperedBody: '{"title":"tampered"}',
      );

      expect(result.isValid, isFalse);
    });

    test('tampered timestamp fails verification', () {
      final signed = signer.sign(
        method: 'GET',
        path: '/users',
      );

      final tamperedTs =
          (int.parse(signed.timestamp) - 600).toString();

      final result = verifier.verifyWithTamperedTimestamp(
        method: 'GET',
        path: '/users',
        originalTimestamp: signed.timestamp,
        tamperedTimestamp: tamperedTs,
        nonce: signed.nonce,
        receivedSignature: signed.signature,
      );

      expect(result.isValid, isFalse);
    });

    test('wrong secret fails verification', () {
      final signed = signer.sign(
        method: 'GET',
        path: '/users',
      );

      final result = verifier.verifyWithWrongSecret(
        method: 'GET',
        path: '/users',
        timestamp: signed.timestamp,
        nonce: signed.nonce,
        receivedSignature: signed.signature,
        wrongSecret: 'completely-wrong-secret',
      );

      expect(result.isValid, isFalse);
      expect(result.message, 'Signature mismatch');
    });

    test('expired timestamp fails verification', () {
      final expiredTimestamp =
          ((DateTime.now().millisecondsSinceEpoch ~/ 1000) - 600).toString();

      const generator = SignatureGenerator();
      final canonical = generator.buildCanonicalString(
        method: 'GET',
        path: '/users',
        timestamp: expiredTimestamp,
        nonce: 'testnonce',
      );
      final signature = generator.sign(
        canonicalString: canonical,
        secretKey: HmacConfig.secretKey,
      );

      final result = verifier.verify(
        method: 'GET',
        path: '/users',
        timestamp: expiredTimestamp,
        nonce: 'testnonce',
        receivedSignature: signature,
      );

      expect(result.isValid, isFalse);
      expect(result.message, contains('Timestamp expired'));
    });

    test('invalid timestamp format fails verification', () {
      final result = verifier.verify(
        method: 'GET',
        path: '/users',
        timestamp: 'not-a-number',
        nonce: 'abc',
        receivedSignature: 'fake',
      );

      expect(result.isValid, isFalse);
      expect(result.message, 'Invalid timestamp format');
    });
  });
}
