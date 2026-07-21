# How standards evolve

<!-- DRAFT - notes and sections to explore, not yet polished prose -->

Standards solve coordination problems. But the process of making and maintaining them creates its own coordination problems - and the way we govern standards today determines who controls the technology everyone depends on.

## The landscape

The internet and the web are held together by a loose federation of standards bodies, each with different scope, culture, and governance. They overlap, compete, and occasionally coordinate - sometimes standardizing the same technology with subtle incompatibilities between versions.

- **IETF** (Internet Engineering Task Force) - internet protocols (HTTP, QUIC). Famous for "rough consensus and running code" - a standard only advances if there are working implementations.
- **W3C** (World Wide Web Consortium) - web standards (HTML, WebAssembly). Membership-based, slow and deliberate.
- **IEEE** (Institute of Electrical and Electronics Engineers) - networking hardware and electrical standards (Ethernet 802.3, Wi-Fi 6 802.11ax).
- **ISO** - international meta-standard body. Ratifies standards from other bodies (metric system, PDF). Slow, bureaucratic, but globally recognized.
- **ECMA International** - programming language and data format standards (JavaScript/ECMAScript, JSON).
- **OASIS** - enterprise and web services standards (SAML, MQTT).

## The power problem

Standards bodies are formally neutral. In practice, they're funded and staffed by the companies that have the most to gain from the outcome.

W3C membership fees run from a few thousand dollars for small organizations to over $80,000 per year for large ones - and large companies don't only pay, they send full-time employees to working groups. A company like Google or Apple might have dozens of engineers shaping specs. A small browser vendor or academic institution has one person, part-time.

The annual revenue of the companies at the table now dwarfs the GDP of many countries. Apple's revenue (~$400B) exceeds the GDP of Denmark or Portugal. Google's parent company clears over $300B. When companies at that scale have a stake in the outcome of a spec, "consensus" becomes a complicated word.

Standards reflect what large implementers will ship, not what the broader ecosystem needs. A feature Google deprioritizes tends not to advance. A feature Apple objects to tends not to land on iOS - regardless of what the spec says.

## Where it went wrong - examples to explore

### ISO/OSI model

In the 1970s and 80s, ISO developed the OSI (Open Systems Interconnection) model - a seven-layer networking architecture designed by committee to be the universal standard for computer networking. It was theoretically rigorous, carefully structured, and backed by major governments and telecoms who mandated it for public procurement.

TCP/IP had none of that. It emerged from ARPANET research, was never formally standardized by any recognized body, and was designed around working implementations rather than architectural purity. By the time OSI was ready to deploy, TCP/IP already ran the internet.

OSI lost not because it was worse on paper, but because it arrived too late with too much complexity and too little running code. The lesson: a theoretically superior standard that nobody ships is not a standard. Real-world deployment beats architectural elegance every time.

### Embrace, extend, extinguish

Microsoft's strategy in the late 1990s browser wars: implement an open standard, add proprietary extensions that only work in Internet Explorer, then market the extensions until the web depends on them. ActiveX, DHTML, and IE-specific CSS behaviors were all examples. The open standard survived, but the ecosystem fractured. The strategy only failed when Firefox (and later Chrome) rebuilt market share behind genuinely open implementations. The lesson: open standards are only as open as the dominant implementation. A spec nobody else can match in practice is proprietary lock-in with extra steps.

### The WHATWG split (2004-2019)

W3C was developing XHTML 2.0 - a clean, strict version of HTML that was theoretically better but ignored the billions of existing pages that didn't conform to it. Browser vendors (Apple, Mozilla, Opera) concluded W3C was moving in the wrong direction. They formed the WHATWG, which began developing HTML5 in parallel. For years there were two competing HTML specs. W3C eventually adopted HTML5 and wound down XHTML 2.0, but only after years of confusion. The lesson: when the standards body loses touch with implementers, implementers leave and form their own.

### Microsoft OOXML vs ODF (2006-2008)

The clearest case of standards process capture.

Some background: `.doc` was Microsoft's old binary format - proprietary, undocumented, reverse-engineered by everyone else. In 2007 Microsoft introduced `.docx` (and `.xlsx`, `.pptx`), built on OOXML - Office Open XML, a ZIP archive of XML files. ODF - OpenDocument Format - was the competing open standard, backed by Sun, IBM, and the OpenOffice project, native to OpenOffice and LibreOffice.

The compatibility hell people remember from mixing Word and OpenOffice files had two layers: implementing the undocumented `.doc` binary format was imperfect, and implementing OOXML was worse. The spec ran to roughly 6000 pages and was riddled with Windows-specific and legacy-Office-specific behaviors that were impossible to implement outside Microsoft's own toolchain.

That context is why the standards fight mattered: governments and enterprises were moving toward mandating open formats for public documents. Whoever won "official open standard" status would determine whether the future was interoperable.

Microsoft pushed OOXML through ISO. The process was [extensively documented](https://en.wikipedia.org/wiki/Standardization_of_Office_Open_XML): Sweden invalidated its vote after one company cast multiple ballots; Norway's technical committee voted majority against but the administration overrode them to approve (13 of 23 committee members resigned in protest); the European Commission opened an antitrust investigation in January 2008. OOXML passed. The world ended up with two competing ISO-ratified document format standards. Microsoft still controls OOXML. ODF remains open but fragmented across implementations.

The lesson: an "open" standard that depends on proprietary components - legacy Windows behaviors, undocumented Office internals - is a proprietary standard. The openness is in the XML wrapper, not the spec.

### CSS vendor prefixes

Before CSS properties were standardized, browsers implemented them under vendor prefixes: `-webkit-`, `-moz-`, `-ms-`, `-o-`. The intent was to let browsers experiment before committing to a spec. The result was that web developers had to write the same declaration four times, and many sites only tested with `-webkit-`, locking them into Chrome/Safari behavior. The prefix experiment created a de facto standard (WebKit) within the formal standardization process.

Most prefixed properties were eventually standardized and the prefixes deprecated - but some remain. `-webkit-appearance` and `-webkit-scrollbar` are still required in 2024 for cross-browser consistency, because Chrome and Safari's market share made their prefixed behavior the de facto standard before any unprefixed version landed.

When the vendor with dominant market share ships a prefix, the prefix becomes the de facto standard - forcing others to support it too. But without a proper spec, every browser builds their own interpretation. You end up with one name for several subtly incompatible behaviors.

The lesson: don't wait too long to standardize experimental features. Leave the window open long enough and the market leader shapes it however suits them, and everyone else spends years catching up to a moving target.

### H.265 / HEVC

H.264 is covered by patents held by a pool of companies who charge licensing fees. H.265 (HEVC) - the technical successor, roughly twice the compression efficiency - made things worse. Three separate patent pools formed around it (MPEG LA, HEVC Advance, Velos Media), with no coordinated licensing terms and fees that streaming services found unpredictable. Apple adopted it across their ecosystem; hardware decoders shipped on most devices by ~2015. But browser vendors stayed away - Chrome didn't ship H.265 decode until 2022, Firefox support remains limited - because patent uncertainty made adoption legally risky at scale.

Technically superior, commercially abandoned. The lesson: rights need to be clarified before a standard is widely adopted, not after. A standard with unresolved or competing patent claims isn't open - it's proprietary with a delay fuse. By the time the ecosystem discovers the terms are unusable, adoption stops and everyone waits for something else.

### Bluetooth codec fragmentation

SBC is the baseline Bluetooth audio codec - open, low quality. aptX (Qualcomm-owned, licensed), AAC (Apple-preferred), LDAC (Sony), LC3 (the new standard). Every Android phone supports a different combination. Every pair of headphones works perfectly with some devices and not others. The "universal" wireless audio standard is anything but. No one body coordinates it, and every major player has an incentive to push their own format.

Two lessons here. First: extensions to a standard - proprietary or even open - that never get folded back into an official new version are still proprietary standards. aptX and LDAC are both "supported" and both lock you into a specific vendor pair. The base standard exists; everything above it is fragmentation dressed as a feature.

Second: waiting too long to standardize extensions guarantees that outcome. LC3 arrived in 2020, by which point the ecosystem had already calcified around incompatible proprietary codecs. Each vendor had too much invested to abandon their format for a late-arriving open one.

### Google AMP

More recent and subtler. Google's Accelerated Mobile Pages was a restricted subset of HTML that Google would serve and rank ahead of everything else. It wasn't a formal standard - it was a de facto one enforced through search market share. Publishers who didn't implement AMP were penalized in rankings. AMP gave Google editorial control over web page structure under the guise of performance. It's being wound down now, but for several years it showed how a company with enough market power can bypass standards bodies entirely. The lesson: you don't need anyone to approve your standard if you control the consumer.

## The "15 standards" problem

There's an [XKCD comic about this](https://xkcd.com/927/). Someone looks at 14 competing standards and says: "This is ridiculous. There should be one universal standard." There are now 15 standards.

The joke is accurate. The instinct to unify creates the very proliferation it tries to solve, because:

1. The existing standards each have stakeholders who won't accept being merged away
2. The unified standard has to be a superset to get buy-in, which makes it more complex than any of its predecessors
3. The complexity creates room for incompatible interpretations
4. The process of negotiating the unified standard takes long enough that new entrants appear in parallel

This isn't an argument against standardization. It's an argument against the assumption that formal unification is the right tool for every fragmentation problem.

## What has actually worked

### TCP/IP

TCP/IP won against OSI by doing the opposite: it shipped. ARPANET had running implementations before anyone wrote a formal spec. When the IETF eventually codified the process, it named it "rough consensus and running code" - don't standardize a design, standardize implementations that already interoperate.

The lesson carried forward: HTTP/1.1, TLS 1.3, and QUIC all went through the same process. A spec that reflects working code is harder to break than one that reflects committee intent.

### Living standards

WHATWG's response to the waterfall model of standards. HTML is now a "living standard" - continuously updated, no version numbers, with browsers implementing features as they land. This trades snapshot clarity for continuous relevance. It works because the implementers are also the authors. It wouldn't work for standards that require third-party interoperability.

### Modular specs

CSS moved from a monolithic spec to independent modules (CSS Grid, CSS Variables, CSS Flexbox) each on its own timeline. This means a working group can ship Flexbox without waiting for the entire CSS specification to stabilize. The tradeoff is complexity in knowing which modules are at which level of maturity.

### AV1

AV1 emerged directly from the H.265 failure. The Alliance for Open Media (Google, Mozilla, Microsoft, Apple, Netflix, Amazon, and others) built a royalty-free codec designed to route around the HEVC licensing impasse. Compression efficiency is roughly on par with H.265, with further gains at higher encode settings. Hardware decode is widespread; hardware encode arrived in consumer GPUs around 2022 and is catching up fast.

The lesson: when rights are settled upfront and the major implementers are also the authors, a standard can ship. AV1 did what H.265 couldn't - not because the technology was better organized, but because the licensing was.

## Open problems

### Entrenched fragmentation

Once fragmentation calcifies, formal standards arrive too late to matter. LC3 is the correct open Bluetooth audio codec - but aptX and LDAC aren't going anywhere. Every major vendor has hardware, firmware, and marketing invested in their format. The open standard won on paper and lost in the market.

A few directions: hardware certification bodies (like Wi-Fi Alliance for Wi-Fi) could phase out certification for fragmented proprietary codecs over a defined timeline. Government procurement could mandate the base standard - if public contracts require LC3 support, device makers have a reason to prioritize it. Neither is fast, but the alternative is waiting for the market to self-correct, which it demonstrably won't.

### Funding buys influence

Working group participation scales with company size. Google and Apple each have dozens of full-time engineers shaping web specs; a small browser vendor or academic institution has one person, part-time. The formal voting process is neutral; the actual drafting is not.

Separating funding tiers from voting weight is the obvious fix - companies can sustain the body financially without that translating into spec control. Rotating technical chairs and independent editors (the model WHATWG uses) reduce the effect further. Hard to retrofit onto bodies where the large members are also the funders, but newer bodies can choose it from the start.

### Patent ambush

A standard advances, reaches widespread adoption, then patent holders surface with incompatible licensing demands - or, as with H.265, multiple competing pools form after the fact. By then switching costs are too high to walk away.

W3C already has a working answer: royalty-free licensing is a condition of inclusion in a web standard. Patent holders who want their technology in the spec must commit to license it royalty-free, upfront. Extending that norm to other bodies - and requiring disclosure of known patents before ratification, not after - would close most of the gap. H.265 would have looked different under those rules.

### Standards that never die

IPv6 has existed since 1998. IPv4 is still the default in 2024. Old standards don't die when better replacements arrive - they accumulate, and implementers must support both indefinitely.

Built-in sunset clauses could help: once a replacement reaches a defined maturity threshold (say, two major independent implementations passing a shared test suite), the old standard enters a deprecation window with a real end date, not an advisory one. The EU's USB-C mandate is a blunt version of this - regulation forcing deprecation when market incentives won't. That's a last resort, but it worked.

### De facto standards bypass the process entirely

AMP didn't go through any standards body - Google had enough search market share to mandate it unilaterally. More recently, OpenAI's API has become a de facto standard that competing model providers implement for compatibility, not because anyone agreed it should be.

Antitrust scrutiny on standards-through-market-power is increasing - the EU Digital Markets Act is beginning to require interoperability from gatekeepers. But regulation lags years behind deployment. The faster check is interoperability requirements baked into platform designation: if you control the distribution channel, you don't also get to control the format.
