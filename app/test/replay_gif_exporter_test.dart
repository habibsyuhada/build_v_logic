import 'package:content_schema/content_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:payload_app/features/replay/export/replay_gif_exporter.dart';
import 'package:sim_core/sim_core.dart';

NetworkDef _network() => NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['r1']),
      const NetworkNodeDef(id: 'r1', type: NodeType.relay, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: ['entry'],
          data: DataDef(value: 10, verified: true)),
      for (var i = 0; i < 5; i++) NetworkNodeDef(id: 's$i', type: NodeType.relay, edges: const []),
    ]);

BattleLog _log() => resolveBattle(
      network: _network(),
      virusDef: const VirusDef(
          program: DagDef(nodes: [DagNode(id: 'a', blockId: 'move_random')], entry: 'a')),
      balance: BalanceConfig.defaults,
      blockCatalog: const [
        BlockDef(id: 'move_random', family: BlockFamily.action, sizeKb: 2, energyCost: 2, noise: 1),
      ],
      seed: 1,
    );

void main() {
  test('exports a decodable, multi-frame animated GIF', () {
    final bytes = ReplayGifExporter.export(network: _network(), log: _log(), tickStride: 20);

    expect(bytes, isNotEmpty);
    // GIF magic header: "GIF87a" or "GIF89a".
    expect(String.fromCharCodes(bytes.take(3)), 'GIF');

    final decoded = img.decodeGif(bytes);
    expect(decoded, isNotNull);
    expect(decoded!.numFrames, greaterThan(1));
    expect(decoded.width, 480);
    expect(decoded.height, 320);
  });

  test('a shorter tick stride produces more frames', () {
    final coarse = ReplayGifExporter.export(network: _network(), log: _log(), tickStride: 50);
    final fine = ReplayGifExporter.export(network: _network(), log: _log(), tickStride: 5);

    final coarseFrames = img.decodeGif(coarse)!.numFrames;
    final fineFrames = img.decodeGif(fine)!.numFrames;

    expect(fineFrames, greaterThan(coarseFrames));
  });

  test('respects the requested canvas size', () {
    final bytes = ReplayGifExporter.export(
        network: _network(), log: _log(), width: 240, height: 160, tickStride: 30);
    final decoded = img.decodeGif(bytes)!;

    expect(decoded.width, 240);
    expect(decoded.height, 160);
  });
}
