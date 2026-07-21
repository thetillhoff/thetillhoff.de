# How standards evolve

<!-- DRAFT - notes and sections to explore, not yet polished prose -->

Standards solve coordination problems. But the process of making and maintaining them creates its own coordination problems. That tension is worth understanding - because the way we govern standards today has real consequences for who controls the technology everyone depends on.

## The landscape

The internet and the web are held together by a loose federation of standards bodies, each with different scope, culture, and governance:

- **IETF** (Internet Engineering Task Force) - internet protocols: TCP/IP, HTTP, SMTP, DNS, TLS. Famous for "rough consensus and running code" - a standard only advances if there are working implementations.
- **W3C** (World Wide Web Consortium) - web standards: HTML, CSS, WebAssembly, accessibility. Membership-based, slow and deliberate.
- **IEEE** (Institute of Electrical and Electronics Engineers) - networking hardware and electrical standards: Wi-Fi (802.11), Ethernet (802.3).
- **ISO** - international meta-standard body. Ratifies standards from others (e.g. PDF, MPEG formats, the metric system). Slow, bureaucratic, but globally recognized.
- **ECMA International** - JavaScript (ECMAScript), JSON, Office Open XML.
- **OASIS** - enterprise and web services standards: SAML, MQTT, OpenDocument.

These bodies overlap, compete, and occasionally coordinate. The same technology can end up standardized by multiple bodies at once, with subtle incompatibilities between versions.

## The power problem

Standards bodies are formally neutral. In practice, they're funded and staffed by the companies that have the most to gain from the outcome.

W3C membership fees run from a few thousand dollars for small organizations to over $80,000 per year for large ones - and large companies don't just pay, they send full-time employees to working groups. A company like Google or Apple might have dozens of engineers actively shaping specs. A small browser vendor or academic institution has one person, part-time.

This matters because the annual revenue of the companies at the table now dwarfs the GDP of many countries. Apple's revenue (~$400B) exceeds the GDP of countries like Denmark or Portugal. Google's parent company clears over $300B. When companies at that scale have a financial interest in the outcome of a spec, "consensus" becomes a complicated word.

The result is that standards increasingly reflect what large implementers are willing to ship, rather than what the broader ecosystem needs. A feature that Google deprioritizes tends not to advance. A feature that Apple objects to tends not to land on iOS - regardless of what the spec says.

## Where it went wrong - examples to explore

### Microsoft OOXML vs ODF (2006-2008)

The clearest case of standards process capture. OpenDocument Format (ODF) was an open ISO standard for office documents. Microsoft pushed their own format - OOXML - through ISO, reportedly pressuring national standards bodies to vote in its favor, including allegations of last-minute membership stacking in several countries. OOXML passed. The world ended up with two competing ISO-ratified document format standards. Microsoft still controls OOXML. ODF remains open but fragmented across implementations.

### The WHATWG split (2004-2019)

W3C was developing XHTML 2.0 - a clean, strict version of HTML that was theoretically better but ignored the billions of existing pages that didn't conform to it. Browser vendors (Apple, Mozilla, Opera) concluded W3C was moving in the wrong direction and formed the WHATWG, which began developing HTML5 in parallel. For years there were two competing HTML specs. W3C eventually adopted HTML5 and wound down XHTML 2.0, but only after years of confusion. The lesson: when the standards body loses touch with implementers, implementers leave and form their own.

### CSS vendor prefixes

Before CSS properties were standardized, browsers implemented them under vendor prefixes: `-webkit-`, `-moz-`, `-ms-`, `-o-`. The intent was to let browsers experiment before committing to a spec. The result was that web developers had to write the same declaration four times, and many sites only tested with `-webkit-`, locking them into Chrome/Safari behavior. The prefix experiment created a de facto standard (WebKit) within the formal standardization process. It took years to clean up.

### Video codec wars

H.264 is covered by patents held by a pool of companies who charge licensing fees. Google responded by acquiring On2 and releasing VP8/VP9 as royalty-free alternatives. Mozilla, Opera, and others backed them. The result: years of browser fragmentation, content creators having to encode multiple formats, and streaming services picking sides. AV1 eventually emerged as a genuinely open successor, but only after a decade of waste. The patent system and the standardization process pulled in opposite directions.

### Embrace, extend, extinguish

Microsoft's strategy in the late 1990s: implement an open standard, add proprietary extensions that only work in Internet Explorer, then market the extensions until the web de facto depends on them. ActiveX, DHTML, and IE-specific CSS behaviors were all examples. The open standard survived, but the ecosystem fractured. The strategy only failed when Firefox (and later Chrome) rebuilt market share behind genuinely open implementations.

### Google AMP

More recent and subtler. Google's Accelerated Mobile Pages was a restricted subset of HTML that Google would preferentially serve and rank in search results. It wasn't a formal standard - it was a de facto one enforced through search market share. Publishers who didn't implement AMP were penalized in rankings. AMP effectively gave Google editorial control over web page structure under the guise of performance. It's being wound down now, but for several years it demonstrated how a company with enough market power can bypass standards bodies entirely.

### Bluetooth codec fragmentation

SBC is the baseline Bluetooth audio codec - open, low quality. aptX (Qualcomm-owned, licensed), AAC (Apple-preferred), LDAC (Sony), LC3 (the new standard). Every Android phone supports a different combination. Every pair of headphones works perfectly with some devices and not others. The "universal" wireless audio standard is anything but. No one body coordinates it, and every major player has an incentive to push their own format.

## The "15 standards" problem

There's an XKCD comic about this. Someone looks at 14 competing standards and says: "This is ridiculous. There should be one universal standard." There are now 15 standards.

The joke is accurate. The instinct to unify creates the very proliferation it tries to solve, because:

1. The existing standards each have stakeholders who won't accept being merged away
2. The unified standard has to be a superset to get buy-in, which makes it more complex than any of its predecessors
3. The complexity creates room for incompatible interpretations
4. The process of negotiating the unified standard takes long enough that new entrants appear in parallel

This isn't an argument against standardization. It's an argument against the assumption that formal unification is the right tool for every fragmentation problem.

## What has actually worked

### IETF's "rough consensus and running code"

Don't standardize a design. Standardize implementations that already interoperate. This forces the spec to reflect reality rather than aspiration. HTTP/1.1, TLS 1.3, and QUIC all went through this process. It's slower to start but produces standards that actually work.

### Living standards

WHATWG's response to the waterfall model of standards. HTML is now a "living standard" - continuously updated, no version numbers, with browsers implementing features as they land. This trades snapshot clarity for continuous relevance. It works because the implementers are also the authors. It wouldn't work for standards that need third-party interoperability.

### Modular specs

CSS moved from a monolithic spec to independent modules (CSS Grid, CSS Variables, CSS Flexbox) each on its own timeline. This means a working group can ship Flexbox without waiting for the entire CSS specification to stabilize. The tradeoff is complexity in knowing which modules are at which level of maturity.

## How to improve it - directions to explore

- **Separating funding from voting power.** Tiered membership where companies can fund the body without that funding translating directly into spec influence. Hard to implement without someone to enforce it.

- **Mandatory implementation before ratification.** Extend the IETF model more broadly. A spec that nobody has shipped in a working form shouldn't be a standard.

- **Antitrust attention on standards processes.** When a company with 90%+ browser market share shapes web standards, that's a competition issue as much as a technical one. EU Digital Markets Act is beginning to touch this.

- **Clear deprecation paths.** Standards accumulate because old ones never die. If a standard had a built-in sunset clause - adopted when a better replacement reaches a certain maturity - the ecosystem would be less cluttered.

- **Reference implementations as part of the spec.** If the standard ships with a canonical open-source implementation, the gap between spec and reality closes. Reduces the "compliant but incompatible" problem.

- **Smaller scope, faster cycle.** The bigger the standard, the longer it takes, the more it gets captured. Breaking problems into the smallest independently-useful pieces reduces both capture risk and implementation debt.
