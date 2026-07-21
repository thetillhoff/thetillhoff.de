# How hard can it be?

You want to send an email. You type a message, hit send, and it arrives in seconds. That's it. How hard can it be?

Harder than it has any right to be. Here's what actually happens.

## How it started: paper and trust

Before email, communication was physical. A letter required a stamp, an envelope, and a known address. Authentication came for free from the physics: a sealed envelope, a postmark, a signature. Tampering was detectable. If someone opened your letter, the seal was broken. If someone forged your handwriting, it was detectable with effort. The system wasn't secure in any modern sense, but it had natural properties that made it surprisingly robust.

There was no spam because sending a letter cost money. There was no spoofing at scale because forging thousands of letters required physical effort. There was no interception at scale because it required physical access. The physics of paper did what protocols would later have to do deliberately.

## Email's original sin

SMTP - the protocol that moves email between servers - was designed in 1982. The internet was a network of trusted universities and research institutions. The people using it knew each other. A Nigerian prince hadn't yet discovered how much cheaper email was than fax for extracting $700,000 a year from strangers. The assumption was: if you're on this network, you're probably legitimate.

So SMTP was designed for that world. To send an email, you open a TCP connection to a server, say HELO, hand over a message, and disconnect. That's it. No authentication. No encryption. No verification that the sender is who they claim to be. The simplicity wasn't a mistake - it was appropriate for the problem at the time. It also assumed servers could be offline - messages would be held and retried until delivery succeeded, sometimes days later.

The internet outgrew it.

## The patches

Every abuse that followed produced a new specification - and every one of them is now mandatory if you want your email to arrive.

**Spam.** As email became universal, so did unsolicited bulk mail. The response was reputation systems: blacklists, spam filters, heuristic scoring. But reputation is hard to bootstrap. A new IP address with no history is suspicious by default. You can do everything right and still have your email land in spam for weeks because your server is "unknown."

**Spoofing.** SMTP lets anyone claim to be anyone. I can send an email that says it's from <president@whitehouse.gov>. Nothing in the original protocol stops this. SPF (2006) was the first real answer: a DNS record that says which IP addresses are allowed to send mail for a domain. If the sending IP isn't on the list, receivers can reject or mark the message.

**Tampering.** SPF verifies the sending server but not the message content. DKIM (2007) adds a cryptographic signature to each email, signed with a private key the sender controls. Receivers check the signature against a public key published in DNS. If the signature doesn't match, the message was altered in transit.

**Policy.** SPF and DKIM tell receivers what to check, but not what to do when checks fail. DMARC (2015) closes that gap: it lets domain owners publish a policy ("reject", "quarantine", or "none") and receive reports about messages that fail authentication. Without DMARC, a receiver who finds a failing DKIM signature has to make their own judgment. With DMARC, the domain owner tells them what to do.

**Encryption in transit.** The original SMTP sent everything in plaintext. STARTTLS added opportunistic encryption between mail servers. MTA-STS makes that requirement strict: it lets a domain publish a policy saying "only accept TLS connections, and only from servers with valid certificates." Without it, an attacker between two mail servers could strip the encryption.

**Clients.** SMTP moves mail between servers. IMAP lets clients read it. CalDAV syncs calendars. CardDAV syncs contacts. If you want users to connect with Thunderbird, Apple Mail, or Outlook, you need all of these. Each is a separate protocol, a separate service, a separate thing to configure, secure, and maintain.

**Push.** IMAP is poll-based - clients ask the server if anything is new. Modern clients expect the server to push notifications instead. IMAP IDLE is the open standard for this. Exchange ActiveSync is the proprietary alternative that much of the ecosystem has standardized on in practice. Mobile push adds another layer: iOS and Android each have their own notification infrastructure, and neither speaks IMAP directly.

Many patches, all mandatory, each introduced to fill a valid serious gap. That's the answer to "how hard can it be?"

## Self-hosting in 2026

If you want to run your own mail server today, here's what you need:

- A domain with correct MX, A, and PTR records
- A mail server for sending and receiving
- SPF, DKIM, and DMARC records configured correctly in DNS
- A DKIM signing setup tied to your mail server
- STARTTLS with a valid TLS certificate
- MTA-STS policy published
- An IMAP server, plus push notification support if you want clients to receive mail in real time
- Storage, archival, and backup for all mail
- A spam filter with a quarantine - plus a way for users to report spam and to un-flag false positives
- Your own spam heuristics, because no off-the-shelf filter knows your users
- A CalDAV/CardDAV server if you want calendar and contacts sync
- An IP address with a clean reputation history
- Ongoing monitoring for blacklist listings
- Password policy enforcement and rotation
- TLS certificate rotation before expiry
- PGP/GPG support if you want E2E encryption - accepting that most recipients won't have it, so most mail stays unencrypted anyway

One misconfigured DNS record and your email lands in spam. One IP with a history of abuse and you're blocked before you've sent a single message. Major providers - Gmail, Outlook - apply their own heuristics on top of all of this, and they don't publish them. You can pass every test and still fail their filters.

This is why almost nobody self-hosts email anymore. Maintaining a good reputation on a shared global infrastructure is ongoing and unpredictable work, and the penalty for getting it wrong is silence - your email just stops arriving. In practice, the "decentralized" email network runs on three providers.

## The missing patch: end-to-end encryption

Everything above is about authentication and transit security - proving the message came from who it claims and wasn't modified along the way. None of it is about confidentiality.

PGP has existed since 1991. S/MIME since 1995. Either would give you end-to-end encrypted email. Neither took off. Why?

Key management. To encrypt an email to someone, you need their public key. To decrypt a reply, they need yours. There's no universal key discovery mechanism. PGP's web of trust never scaled. S/MIME requires certificates from a CA. Most people have never seen either.

Metadata. Even with encrypted content, email leaks: who you're writing to, when, how often. The envelope is always visible. On a protocol that routes mail through multiple servers, hiding metadata is practically impossible.

Spam filtering. Encrypted content can't be inspected. Providers who filter spam on the server side - which is all of them - resist encryption because it breaks their filters. Tutanota and Proton Mail solved this by controlling both ends of the conversation. Between their own users, they can encrypt everything. With the rest of the world, they fall back to standard SMTP and TLS.

E2E encrypted email, at scale, across providers, remains unsolved after 35 years. Every serious attempt has either required both parties to use the same provider, or has imposed key management on users that they won't accept.

## Why it's still here

None of this stopped email from winning. Official correspondence is still migrating from paper to email. Everyone has at least one address, the same way everyone used to have a postal address. It's the universal fallback - the one channel you can reach anyone on when you don't share a platform.

Email does the job. It's ugly, it accreted rather than designed, and running your own is a project, not an afternoon. Even getting a clean IP address is harder than it sounds: IPv4 exhaustion means most available addresses have a history, and that history comes with a reputation you didn't earn and may spend months repairing.

## Where email ends

Some of these problems can't be patched. E2E encryption at scale, metadata privacy, clean group semantics - they conflict with the assumptions SMTP was built on. The constraints aren't in the configuration. They're in the foundations.

Which is why some people stopped patching and started over. That's a different story - one about what "sending a message" actually requires, what email got right and wrong, and whether the reinvention was worth it.
