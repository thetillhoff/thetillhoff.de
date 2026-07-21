# Sending a message

You want to send a message to someone. What does that actually require?

Not email specifically. Not Signal. Just the abstract problem: a thought in your head needs to reach another person reliably. Start there, and build up.

## The bare minimum

At its simplest, you need three things: an address that identifies the recipient, a transport that moves the content, and some confidence that it arrived. A letter does all three - envelope with a name and street address, postal service as transport, delivery confirmation optional but available.

That's it. Everything else is a response to a problem that showed up later.

## What goes wrong

Scale changes everything. When communication was physical, the constraints of the medium were also its security model: cost prevented spam, physics made spoofing hard, interception required presence. Move it to software and all of those constraints disappear.

Here's the list of requirements that emerged - not from design, but from failure:

**Authenticity.** Anyone can claim to be anyone. You need a way to verify the sender is who they say. With a letter, a signature and known handwriting do rough work. At internet scale, you need cryptographic proof.

**Integrity.** Did the message arrive unchanged? In transit over untrusted networks, content can be modified. You need a way to detect tampering.

**Confidentiality.** Should anyone other than the recipient be able to read this? Physical letters have a reasonable expectation of privacy. Digital messages travel through infrastructure operated by third parties.

**Metadata privacy.** Even if content is encrypted, the envelope leaks: who wrote to whom, when, how often. For sensitive communication, the pattern of contact can be as revealing as the content.

**Spam resistance.** When sending is free, the economics of unsolicited bulk messages change entirely. Any open system needs a way to distinguish wanted from unwanted at scale.

**Deliverability.** Getting a message to the recipient's inbox - not their spam folder, not silently dropped - requires active reputation management on shared infrastructure.

**Addressing that survives change.** A street address is tied to a building. An email address is tied to a domain. A phone number is tied to a carrier. What happens when someone moves, changes providers, or loses access to an account?

**Multiple recipients.** Adding more than one person to a message isn't just "send it twice." It changes the trust model: who can see the list, who can reply to whom, whether replies go to one person or everyone, who owns the thread.

**Group semantics.** A group of ten people having an ongoing conversation has different requirements than a broadcast list of ten thousand. Membership management, moderation, history, and access control all vary by scale and use case.

**Asynchronous delivery.** The recipient may not be online when you send. Store-and-forward is not optional.

**Attachment and rich content.** Plain text is not always enough.

None of these are unreasonable requirements. All of them showed up in practice. The question is which systems handle which ones, and what they sacrifice to do it.

## What email solved, and how

Email solved most of this list - eventually, through decades of patches. The previous post in this series covers that history in detail. The short version: SMTP (1982) handled transport and async delivery. Everything else was added later in response to abuse.

SPF, DKIM, and DMARC handle authenticity and integrity. TLS handles confidentiality in transit. Reputation systems and blocklists handle spam resistance - imperfectly, and at significant ongoing cost to anyone self-hosting. IMAP handles multi-device access. MIME handles rich content and attachments.

What email never solved cleanly: end-to-end encryption (content remains visible to providers), metadata privacy (the envelope is always readable), and group semantics (CC and BCC are blunt instruments, mailing lists are a separate ecosystem with their own complexity).

## What modern systems solved by narrowing scope

Signal handled E2E encryption and metadata minimization by making a deliberate tradeoff: centralized infrastructure, controlled by one company, no federation. By owning both ends, they could design key exchange to be invisible to users. By not federating, they could make stronger guarantees about server behavior. The cost is that "Signal" means "Signal's servers."

Matrix went further: federated, E2E encrypted, open source clients. On paper it solves what email couldn't. In practice it trades one set of hard problems for another - server discovery, federation reliability, key verification across homeservers, the cold-start problem of nobody being there yet.

iMessage, WhatsApp, Telegram each made their own tradeoffs - some encrypting content but not metadata, some centralizing entirely, some federated in name but not in practice.

The pattern: every modern system that solved email's hard problems did so by accepting constraints email couldn't accept. Smaller scope. Controlled infrastructure. No backwards compatibility requirement.

## Backwards compatibility is a ceiling

Any system that needs to interoperate with email inherits its constraints. This is not a configuration problem. SMTP assumes plaintext is acceptable at the server layer. Metadata visibility is structural. The envelope exists because routing requires it.

Proton Mail and Tutanota built E2E encryption within their own user base and fall back to standard TLS for the rest of the world. That's not a limitation of their implementation - it's the ceiling imposed by backwards compatibility with a 1982 protocol. You can encrypt everything between users on the same platform. You cannot encrypt everything while remaining interoperable with Gmail.

This ceiling matters for any proposal to "fix" email. The ecosystem is too large and too distributed for a flag day - a coordinated upgrade where every server and client changes simultaneously. It has never happened in the history of the internet and there is no mechanism to make it happen.

## The 15th standard

There's an XKCD comic about this. Fourteen competing standards exist; someone decides to write a new one that unifies them all; now there are fifteen.

This post is not a proposal. The requirements listed above are real. The tradeoffs are real. The right answer genuinely depends on what you're optimizing for.

Point-to-point, low sensitivity, needs to reach everyone: email. Ugly to self-host, structurally incapable of real privacy, but universal.

Point-to-point, high sensitivity, recipient can install an app: Signal. Excellent privacy guarantees, centralized, no interoperability.

Group communication, open source, willing to accept federation friction: Matrix. Best architecture of the bunch for decentralized use, rough edges in practice.

Broadcast to a large audience with no expectation of reply: mailing lists, RSS, or just a website.

The honest map has several countries and no capital. The requirement that drove you to look is the one that determines which country you're in. Anything that promises to unify the map is either lying or about to make the map larger.
