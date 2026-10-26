<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%2016%2B%20%7C%20macOS%2013%2B-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-5.9%2B-orange" alt="Swift">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/status-early%20WIP-yellow" alt="Status">
  <a href="https://buymeacoffee.com/jcbuilds"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-FFDD00?logo=buymeacoffee&logoColor=black" alt="Buy Me a Coffee"></a>
</p>

<h1 align="center">🕸️ Mesh</h1>

<p align="center">
  <strong>Peer-to-peer LLM federation over your local network.</strong><br>
  <em>Your iPhone borrows your Mac's 70B model — over wifi, no cloud, no setup.</em>
</p>

<p align="center">
  Discover • Route • Stream • Fall-back gracefully
</p>

---

Mesh turns every Apple device on your network into one big inference pool. Your iPhone has a 3B model loaded. Your iPad has 13B. Your M-series Mac has a 70B. Mesh handles the discovery, capability negotiation, and token streaming so a single `Mesh.session()` call transparently picks the best peer for the job — and falls back to the local model when no peers are reachable.

The result: your iPhone outputs at 70B quality, with iPhone latency, while staying fully local.

## Why this is novel

Every "run an LLM on your phone" project assumes the phone is alone. In reality, most users have an iPad and a Mac on the same wifi, both idling. Mesh is the first Swift package that treats the household as a compute pool — discovery via Bonjour, transport over MultipeerConnectivity / NWConnection, streamed tokens with backpressure, capability tiers per peer.

## Planned features

| Category | Capabilities |
|----------|-------------|
| 📡 **Zero-config discovery** | Bonjour-based peer discovery on the local network |
| 🧮 **Capability negotiation** | Each peer publishes loaded models, max context, tokens/sec, thermal headroom |
| 🚦 **Smart routing** | Route a prompt to the highest-capability peer that can serve it under your latency budget |
| 🌊 **Streamed tokens** | `AsyncThrowingStream` of tokens flows over the wire just like local inference |
| 🛟 **Graceful fallback** | Peer disconnects mid-stream? Resume on the local model with prefix replay |
| 🔐 **Pairing &amp; trust** | One-tap pairing with QR or AirDrop-style proximity, then ephemeral session keys |
| 🤝 **Kuzco-native** | Drop-in replacement for a local [Kuzco](https://github.com/haplollc/Kuzco) session |

## Planned API (subject to change)

```swift
import Mesh
import Kuzco

let mesh = MeshClient()
try await mesh.start()                 // begin advertising + discovering
let peers = await mesh.peers           // [Peer(name: "Jared's M4", maxParams: 70_000_000_000, ...), ...]

let session = try await mesh.session(
    prefer: .largestAvailable,
    fallback: .local("Llama-3.2-3B-Instruct.Q4_K_M.gguf")
)

for try await token in session.stream(prompt: "Explain quantum entanglement.") {
    print(token, terminator: "")
}
```

Want the same device to host? One line:

```swift
try await mesh.host(model: "Llama-3.3-70B-Instruct.Q4_K_M.gguf")
```

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/haplollc/Mesh.git", from: "0.1.0")
]
```

## Status

🚧 **Early WIP.** Discovery, routing, and Kuzco bridge are the first targets.

## License

MIT © [Haplo LLC](https://haplo.ai)
