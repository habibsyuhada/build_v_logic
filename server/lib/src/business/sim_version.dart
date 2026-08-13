/// Sim/content version the server currently resolves PvP battles with
/// (§2.7). Bump this whenever `content/blocks.json` or `sim_core`'s
/// gameplay behavior changes in a way that would make old and new clients
/// disagree on a battle's outcome.
///
/// PvE (campaign, local Test Run) never checks this — only PvP submission
/// does, since PvE never needs cross-client agreement.
const int currentSimVersion = 1;

class SimVersionGate {
  /// True if a client on [clientSimVersion] may submit PvP battles against
  /// this server. Exact match only — no forward/backward compatibility is
  /// assumed for the simulation itself (§2.7: "paksa update untuk PvP").
  static bool isCompatible(int clientSimVersion) => clientSimVersion == currentSimVersion;
}
