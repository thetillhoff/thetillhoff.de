# The decentralized web

<!-- DRAFT - notes and sections to explore, not yet polished prose -->

The internet didn't start centralized. It became that way. And the alternatives that have grown up in response to that centralization are real, functional, and used by millions - yet haven't displaced the platforms they're reacting to. That gap between "this works" and "this won" is the interesting part.

## It was always decentralized

The internet's foundational protocols were all federated by design. Email (SMTP) means anyone can run a mail server and reach anyone else's. IRC let you run your own server and join a global chat network. Usenet was a distributed discussion system with no single owner. RSS let any website publish a feed that any reader could subscribe to without the website knowing who was reading. XMPP (Jabber) was an open instant messaging protocol that anyone could implement.

None of this required permission from a central authority. You could host your own node, your own feed, your own server. The protocol was the platform.

## How centralization happened

It didn't happen through force. It happened through convenience.

Email is still federated - but in practice, Google and Microsoft handle the vast majority of it. Not because they locked it down, but because running your own mail server became a fight against spam filters, deliverability quirks, and DMARC/DKIM/SPF complexity. The protocol stayed open. The ecosystem consolidated anyway.

RSS died a different death. Google Reader made RSS simple and social. When Google shut it down in 2013 - because it didn't fit their advertising model - it took most of the RSS ecosystem with it. Not because the protocol failed. Because the dominant client disappeared and nothing replaced it at the same scale.

XMPP had a moment. Google Talk ran on it. Federation between services actually worked. Then Google closed the federation gates, rebuilt as Hangouts (proprietary), and eventually as Google Chat (also proprietary). WhatsApp was built on XMPP internally but never federated. The protocol survived; the network didn't.

The pattern: open protocol, early adoption, convenience consolidation, or deliberate closure by the dominant player once network effects locked users in.

## The natural backlash

When Twitter became X and began its unraveling, when Facebook's feed became unrecognizable, when WhatsApp was acquired and people started asking what that meant for their data - the response wasn't just complaint. It was a wave of alternatives, most of them built on open protocols.

**Mastodon and the Fediverse** - built on ActivityPub, a W3C standard. Mastodon looks like Twitter but runs on thousands of independent servers that talk to each other. Your account on mastodon.social can follow someone on chaos.social and reply to someone on fosstodon.org. No single company owns it. As of 2024, the Fediverse has roughly 10-12 million active users across hundreds of platforms (Mastodon, Pixelfed for photos, PeerTube for video, Lemmy for forums).

**Matrix** - a federated protocol for real-time messaging and collaboration. Element is its flagship client. Designed to replace both Slack and WhatsApp with something nobody owns. Governments and militaries have adopted it (France, Germany, the US DoD uses Element). FOSS communities run it. Estimated several million monthly active users.

**Nostr** - newer and simpler. A protocol so minimal it's basically just: publish signed messages to relays, subscribe to relays to read them. No accounts in the traditional sense - just cryptographic key pairs. Jack Dorsey (Twitter's founder) has funded its development. Popular in the Bitcoin community. Still small.

**Signal** - not federated, not decentralized, but private. Runs on open-source end-to-end encrypted protocols that have been independently audited. Centralized infrastructure, but the company (a nonprofit) can't read your messages even if compelled. A different answer to the same problem: trust through transparency and cryptography rather than through decentralization.

**Bluesky** - the complicated case. Spun out of Twitter, built on the AT Protocol, technically designed for federation. But in practice still largely centralized - most users are on bsky.app, federation is limited, and the company still controls the primary infrastructure. Decentralization as roadmap feature rather than day-one reality. Worth watching but not yet what it claims to be.

**Diaspora, Friendica, Hubzilla** - earlier attempts at federated social networking, most predating the Fediverse coinage. Still running, small communities, technically solid. Showed it was possible before Mastodon made it visible.

## Why they haven't taken over

They work. They're not toys. So why aren't they dominant?

### Network effects are winner-take-all

The value of a communication network is proportional to who's on it. Your friends are on WhatsApp. Your professional contacts are on LinkedIn. The news breaks on Twitter/X. A technically superior alternative where none of those people are is worth less than the inferior platform where all of them are. This is not a technical problem. It is a structural one, and it is extremely hard to overcome.

### Onboarding requires a decision

Joining Facebook in 2008 required no explanation. "It's where everyone is" was sufficient. Joining Mastodon requires choosing an instance, understanding what federation means, explaining to people why your handle has two @ signs. Every extra step loses people. The people who clear those steps are already self-selecting for technical tolerance or political motivation - which shapes the early community in ways that can repel the mainstream.

### Discovery is unsolved

On Twitter, you find people through trending topics, mutual follows, algorithmic recommendations. On the Fediverse, discovery is fragmented by instance. The people you might want to follow are distributed across hundreds of servers with no shared index. Search across the full Fediverse is limited. This is a feature for privacy but a bug for growth.

### Moderation is genuinely hard

Centralized platforms have moderation problems. Decentralized ones have them worse. Each instance sets its own rules. Some instances federate with everyone; some block others; some are havens for content that mainstream instances defederate from. The result is a patchwork. Users sometimes find themselves cut off from parts of the network by their instance's moderation decisions without realizing it. There's no universal appeals process. No coordinated response to coordinated abuse.

### The UX gap is real

Mastodon has gotten dramatically better. Matrix's Element client is functional. But they're still playing catch-up on polish, mobile experience, notifications, and the thousand small things that make a mainstream product feel effortless. Open source moves slower on UX than a company with a design team and revenue-driven incentive to reduce friction.

## What's changed recently

A few things are shifting the calculus:

**ActivityPub adoption by large platforms.** Meta's Threads has begun federating with the Fediverse. Flipboard moved to ActivityPub. WordPress.com supports it. When large platforms adopt the protocol rather than fight it, the network effect problem begins to shrink - the Fediverse gets access to audiences it couldn't reach before. Whether this is a genuine embrace or an attempt to absorb and neutralize is an open question.

**EU regulation again.** The Digital Markets Act requires large platforms designated as "gatekeepers" to open their messaging to interoperability with third parties. WhatsApp and Messenger are affected. This is potentially the biggest forced step toward federation in messaging history - not through goodwill but through law. The same pattern as USB-C: the standard won because regulators made it mandatory.

**The trust collapse at platforms.** Each time a major platform changes ownership, reverses policy, or makes the feed worse, another wave of users looks for alternatives. The Mastodon spike after Musk's Twitter acquisition was real and sustained, not a blip.

## The core tension

Decentralization solves the control problem. It doesn't solve the convenience problem. And convenience is what most people optimize for, most of the time.

The path forward probably isn't "everyone moves to Mastodon." It's more likely: open protocols get embedded into platforms people already use, through a combination of regulatory pressure and network-effect erosion at the incumbents. Federation becomes infrastructure rather than ideology.

That's less satisfying than a clean narrative of decentralization winning on merit. But it may be more accurate about how change actually happens.

## Threads to pull on when writing

- The RSS death as a case study in single-point-of-failure for open protocols
- XMPP: what a successful open messaging protocol looks like and why it still lost
- Matrix in government/enterprise - decentralization succeeding where ideology doesn't matter but trust does
- The Bluesky centralization critique in more depth - is AT Protocol actually decentralized?
- Web3/blockchain social (Lens Protocol, Farcaster) - a different answer to the same question, with different tradeoffs
- The moderation problem as a fundamental design constraint, not an implementation bug
- How DMA interoperability requirements might actually work in practice - and what the obstacles are
- Historical parallel: the early telephone network, where AT&T consolidated multiple competing networks by buying them all
