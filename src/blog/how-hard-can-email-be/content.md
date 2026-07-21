# How hard can it be?

You want to send an email. You type a message, hit send, and it arrives in seconds. That's it. How hard can it be?

Harder than it has any right to be. Here's what actually happens.

## How it started: paper and trust

Before email, communication was physical. A letter required a stamp, an envelope, and a known address. Authentication came for free from the physics: a sealed envelope, a postmark, a signature. Tampering was detectable. If someone opened your letter, the seal was broken. If someone forged your handwriting, it was detectable with effort. The system wasn't secure in any modern sense, but it had natural properties that made it surprisingly robust. Trust was built into the medium.

There was no spam because sending a letter cost money. There was no spoofing at scale because forging thousands of letters required physical effort. There was no interception at scale because it required physical access. The constraints of paper were also its security model.

## Email's original sin

SMTP - the protocol that moves email between servers - was designed in 1982. The internet was a network of trusted universities and research institutions. The people using it knew each other. Spam wasn't a concept. Spoofing wasn't a concern. The assumption was: if you're on this network, you're probably legitimate.

So SMTP was designed for that world. To send an email, you open a TCP connection to a server, say HELO, hand over a message, and disconnect. That's it. No authentication. No encryption. No verification that the sender is who they claim to be. The simplicity wasn't a mistake - it was appropriate for the problem at the time.

But the internet grew, and the assumptions didn't.

## The patches

Every abuse that followed produced a new specification. Each one solved a real problem. Each one is now mandatory if you want your email to arrive.

**Spam.** As email became universal, so did unsolicited bulk mail. The response was reputation systems: blacklists, spam filters, heuristic scoring. But reputation is hard to bootstrap. A new IP address with no history is suspicious by default. You can do everything right and still have your email land in spam for weeks because your server is "unknown."

**Spoofing.** SMTP lets anyone claim to be anyone. I can send an email that says it's from president@whitehouse.gov. Nothing in the original protocol stops this. SPF (2006) was the first real answer: a DNS record that says which IP addresses are allowed to send mail for a domain. If the sending IP isn't on the list, receivers can reject or mark the message.

**Tampering.** SPF verifies the sending server but not the message content. DKIM (2007) adds a cryptographic signature to each email, signed with a private key the sender controls. Receivers check the signature against a public key published in DNS. If the signature doesn't match, the message was altered in transit.

**Policy.** SPF and DKIM tell receivers what to check, but not what to do when checks fail. DMARC (2015) closes that gap: it lets domain owners publish a policy ("reject", "quarantine", or "none") and receive reports about messages that fail authentication. Without DMARC, a receiver who finds a failing DKIM signature has to make their own judgment. With DMARC, the domain owner tells them what to do.

**Encryption in transit.** The original SMTP sent everything in plaintext. STARTTLS added opportunistic encryption between mail servers. MTA-STS makes that requirement strict: it lets a domain publish a policy saying "only accept TLS connections, and only from servers with valid certificates." Without it, an attacker between two mail servers could strip the encryption.

**Clients.** SMTP moves mail between servers. IMAP lets clients read it. CalDAV syncs calendars. CardDAV syncs contacts. If you want users to connect with Thunderbird, Apple Mail, or Outlook, you need all of these. Each is a separate protocol, a separate service, a separate thing to configure, secure, and maintain.

This is the answer to "how hard can it be?" Seven protocols, all mandatory, each introduced to patch a gap in the previous ones.

## Self-hosting in 2026

If you want to run your own mail server today, here's what you need:

- A domain with correct MX, A, and PTR records
- An MTA (Postfix, Exim, or similar) for sending and receiving
- SPF, DKIM, and DMARC records configured correctly in DNS
- A DKIM signing setup tied to your MTA
- STARTTLS with a valid TLS certificate
- MTA-STS policy published
- An IMAP server (Dovecot is the standard choice)
- A CalDAV/CardDAV server if you want calendar and contacts sync
- An IP address with a clean reputation history
- Ongoing monitoring for blacklist listings

One misconfigured DNS record and your email lands in spam. One IP with a history of abuse and you're blocked before you've sent a single message. Major providers - Gmail, Outlook - apply their own heuristics on top of all of this, and they don't publish them. You can pass every test and still fail their filters.

This is why almost nobody self-hosts email anymore. Not because it's impossible - it isn't - but because the cost of maintaining a good reputation on a shared global infrastructure is ongoing and unpredictable. In practice, the "decentralized" email network runs on three providers.

## The missing patch: end-to-end encryption

Everything above is about authentication and transit security - proving the message came from who it claims and wasn't modified along the way. None of it is about confidentiality.

PGP has existed since 1991. S/MIME since 1995. Either would give you end-to-end encrypted email. Neither took off. Why?

Key management. To encrypt an email to someone, you need their public key. To decrypt a reply, they need yours. There's no universal key discovery mechanism. PGP's web of trust never scaled. S/MIME requires certificates from a CA. Most people have never seen either.

Metadata. Even with encrypted content, email leaks: who you're writing to, when, how often. The envelope is always visible. On a protocol that routes mail through multiple servers, hiding metadata is practically impossible.

Spam filtering. Encrypted content can't be inspected. Providers who filter spam on the server side - which is all of them - resist encryption because it breaks their filters. Tutanota and Proton Mail solved this by controlling both ends of the conversation. Between their own users, they can encrypt everything. With the rest of the world, they fall back to standard SMTP and TLS.

The result is that E2E encrypted email, at scale, across providers, remains effectively unsolved after 35 years. Every serious attempt has either required both parties to use the same provider, or has imposed key management on users that they won't accept.

## Where email ends

Some of these problems can't be patched. E2E encryption at scale, metadata privacy, clean group semantics - they conflict with the assumptions SMTP was built on. The protocol's constraints aren't in the configuration. They're in the foundations.

Which is why some people stopped patching and started over. That's a different story - one about what "sending a message" actually requires, what email got right and wrong, and whether the reinvention was worth it.
