# How agile became waterfall

At some point the engineering stopped. Not literally - code still got written. But the job became: understand the ticket, write the ticket, attend the planning, attend the grooming, attend the retrospective, do the security review, fill in the cost estimate, update the architecture decision record, wait for the compliance sign-off, answer the questions from legal, and then, if there's time, write the code. Sprint ends. Do it again.

This is waterfall. Every phase is still there - requirements, design, security, compliance, architecture, build, test, deploy - except the phases all happen inside the engineer's head, simultaneously, across a dozen tickets each at a different stage, across several sprints that were supposed to be about delivering value. An engineer who estimates a day of focused work is right about the work. They're not estimating the standups, the grooming, the gate reviews, the request they filed with the platform team two weeks ago that's still "in progress", or the context switches between all the other tickets in flight at the same time. One day becomes one week. Nobody planned for that, and yet everyone is surprised. Instead of planning forever, you build forever. The gates became internal. And the answer to "when will this be done?" became a shrug dressed up in sprint velocity.

To understand how we got here, it helps to remember what agile was reacting to.

## How we got here

In the early 2000s, software development in large organizations ran like a relay race. A business analyst wrote a requirements document. It went to architects, who produced a design. It went to developers, who built it. It went to testers, who broke it. It went back to developers. Eventually it went to operations, who ran it. At each handoff, context leaked. The person who knew what the customer actually needed was three or four steps removed from the person writing the code.

The Agile Manifesto was a reaction to that - a set of principles that prioritized people over processes, working software over comprehensive documentation, customer collaboration over contract negotiation. The principles were sound. They still are.

Within a decade, agile had become the default answer to questions nobody was asking. Companies adopted it because "we use agile" had become a signal of modernity. They learned the vocabulary: sprints, retrospectives, story points, velocity. They performed the rituals. Things got worse. But they were agile now.

One clarification: agile and Scrum are not the same thing. Agile is a set of principles. Scrum is one implementation - one that became so dominant that most people use the names interchangeably. What follows is mostly about Scrum and its relatives.

Tickets became the new spec. The product owner writes the story. The developer implements it. The context travels as text, and text loses nuance. The telephone game still plays; the rounds are just shorter.

Shared ownership became dissolved ownership. Moving away from the single-hero developer who alone understood a system was a genuine improvement. But collective ownership in practice often meant that when something broke or needed a decision, there was nobody in particular responsible for it. If everyone owns it, nobody does.

## The gate problem

Engineers want to build things well. Product wants them built quickly. Finance wants them built cheaply. Security wants them built safely. Legal wants them defensible. Architecture wants them consistent. IT wants them operable. These are not personality conflicts - they're genuinely competing concerns, all legitimate, none fully compatible.

None of these teams are the villains. Security exists because security matters. Legal exists because legal matters. The problem is structural: each of these functions sits at a bottleneck by design. Every feature has to pass through some subset of them.

Waterfall had all of these gates too. They were sequential - plan first, then build, then review, then deploy. Slow, but predictable. Agile compressed the timeline but kept the gates. Now you hit them at sprint speed.

## Shifting left

The popular fix was to shift left: move the security review earlier, involve the architect in the design phase, do the compliance check before building rather than after. DevOps moved operations into the development cycle. DevSecOps moved security in too. The idea was sound - catch problems earlier, when they're cheaper to fix.

What it meant in practice: engineers now own operations, security, compliance, testing, cost estimation, and architecture review - in addition to the actual engineering. Nobody planned this. It was easier to expand the engineer's job description than to build the tooling that would make each of those domains navigable without a specialist.

The engineer who has to think about whether this database query violates GDPR policy, whether this new service will blow the budget, whether this approach will pass the architecture review, and whether this authentication flow is secure enough - before writing the first line of code - is not empowered. They're overwhelmed. The work still gets done, but slowly, or badly, or both.

## Specialists as platform teams

The way out is not to move the burden. It's to move the expertise.

A security team that reviews pull requests manually is a gate. A security team that builds a linter, runs it on every pull request, and flags specific issues automatically - that's a platform. The security specialist didn't disappear. They shifted from being a bottleneck to being an infrastructure provider. Engineers become consumers of the guardrail product, not owners of the security domain.

This already happens in other disciplines. Designers don't review every button in every PR; they publish a design system and engineers use it. Frontend teams share component libraries. Backend teams share libraries and SDKs. The specialist's knowledge is encoded into a product that scales without the specialist present at every decision.

The same logic applies to every gate. Architecture compliance: a linter that knows the rules, not a meeting where an architect asks questions. Cost: a dashboard that shows what a service costs in production, automatically, so engineers can see it without asking finance. GDPR compliance: a library with sensible defaults, not a legal review for each new data field.

These tools are products. They take real engineering effort to build and maintain. That's the work that actually removes the bottleneck - not moving the bottleneck into the engineer. Make feedback fast, not heavy. A linter that tells you in ten seconds is worth more than a review meeting that tells you in two weeks, because by the time you're in the meeting you've already built two sprints of work on top of the mistake.

Specialization isn't the enemy of agile. A security engineer who thinks about nothing but security is better at security than a generalist who also owns the sprint board, the deployment pipeline, and the GDPR review. The expertise still exists; it just reaches engineers through tooling instead of through reviews. An engineer who owns a slice of everything never owns enough of anything to go deep - not because they aren't capable, but because expertise takes hours that generalism keeps spending elsewhere.

## The pattern

Before adding a process, ask what problem it solves and whether you actually have that problem. Before adding a gate, ask whether it could be a tool instead. Before shifting something left, ask whether you're shifting the guidance or just the burden.

Shifting the burden means a security checklist lands in the engineer's hands. Shifting the guidance means the security team encodes their knowledge into a tool that enforces the rules for everyone.
