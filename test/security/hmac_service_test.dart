import 'package:demo_flutter/security/hmac_config.dart';
import 'package:demo_flutter/security/hmac_service.dart';
import 'package:demo_flutter/security/signature_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HmacService', () {
    const service = HmacService();

    test('sha256Hex produces consistent hash', () {
      final hash1 = service.sha256Hex('hello');
      final hash2 = service.sha256Hex('hello');
      expect(hash1, hash2);
      expect(hash1.length, 64);
    });

    test('sha256Hex of empty string is known value', () {
      final hash = service.sha256Hex('');
      expect(
        hash,
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      );
    });

    test('computeHmacHex produces consistent signature', () {
      final sig1 = service.computeHmacHex(
        message: 'test-message',
        secretKey: 'test-secret',
      );
      final sig2 = service.computeHmacHex(
        message: 'test-message',
        secretKey: 'test-secret',
      );
      expect(sig1, sig2);
      expect(sig1.length, 64);
    });

    test('different secrets produce different signatures', () {
      final sig1 = service.computeHmacHex(
        message: 'test-message',
        secretKey: 'secret-a',
      );
      final sig2 = service.computeHmacHex(
        message: 'test-message',
        secretKey: 'secret-b',
      );
      expect(sig1, isNot(sig2));
    });

    test('different messages produce different signatures', () {
      final sig1 = service.computeHmacHex(
        message: 'message-a',
        secretKey: 'test-secret',
      );
      final sig2 = service.computeHmacHex(
        message: 'message-b',
        secretKey: 'test-secret',
      );
      expect(sig1, isNot(sig2));
    });
  });

  group('SignatureGenerator', () {
    const generator = SignatureGenerator();

    test('buildCanonicalString follows expected format', () {
      final canonical = generator.buildCanonicalString(
        method: 'GET',
        path: '/users',
        timestamp: '1700000000',
        nonce: 'abc123',
        body: '',
      );

      expect(canonical, contains('GET'));
      expect(canonical, contains('/users'));
      expect(canonical, contains('1700000000'));
      expect(canonical, contains('abc123'));
      expect(canonical.split('\n').length, 5);
    });

    test('sign produces reproducible signature', () {
      const canonical = 'GET\n/users\n1700000000\nabc123\ne3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';
      final sig = generator.sign(
        canonicalString: canonical,
        secretKey: HmacConfig.secretKey,
      );
      expect(sig.length, 64);
      expect(
        generator.sign(
          canonicalString: canonical,
          secretKey: HmacConfig.secretKey,
        ),
        sig,
      );
    });
  });
}
