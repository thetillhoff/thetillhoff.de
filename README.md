# `thetillhoff.de`

This repository contains the current status of the website https://thetillhoff.de.

> The grand idea was to make the site as fast as possible. Go on, check it out, I'll wait.

improve presentation style (formatting of notes)
presentation of my work
small game?

## How to get started
- `./temingo -wsv`
<!--
- `npm create svelte@latest <projectname>`
  template: skeleton project
  type checking: no
  eslint: yes
  prettier: yes
  playwright: no
- `cp <projectname>/* ./ && rm -d <projectname>`
- `npm install`
- `npm run dev` || `npm run build`
-->

## Further details for those interested

Instead of using \<your favorite third-party framework, website-hoster\>, I wanted to create, optimize and host at least this single website on my own.
Some details/goals of the setup are:
- Speed, simplicity and efficiency are the primary goals.
- The website runs on a [caddy](https://caddyserver.com/) container.

- Since it's cumbersome to repeat html snippets, I'm using [temingo](https://github.com/thetillhoff/temingo) as a static website generator.
- No usage of google-fonts or any other third-party hosting for anything.
- No javascript (except a reference to add my own analytics)



<!--
# Considerations
- There needs to be a templating engine in place, so partials like navigation and footer and headers cannot diverge if not explicitely stated.
- To use a template, there are two ways:
  - simply reference it with default content
  - reference it, but override default content; this is similar to sveltes slots and components
- Templates and components are basically the same. Only the filepath is different.
- A template can combine html, css and javascript. The templating engine will extract the css and javascript and merge them each into dedicated files.
  Alternatively, they can be split into different files straight from the start, meaning the templating engine only needs to aggregate the files with the corresponding extensions.
- Templates should support input and output variables. That way, they can be reused more often.
- css should use variables. Those need to be set at a global place (aka :root).
- `temingo` could include the `serve` library, and inject a javascript snippet that holds a constant connection to the temingo dev web-server, so it can instantly trigger page reloads on changes.
- each non-html file should have a hash appended that changes with the contents.
- the integrated dev `serve`r should set the cache-control header to 0 (not cache anything at all).
- include options to automatically minify output html, css and js. This includes "uglifying" css (and js?).
  Extend this to automatically optimize images as well.
- print warning if unused code is detected, except for "components/libs".
- Write tests.
- Print html, css and js syntax lint issues.
- Document each feature in code AND via markdown. -> Use godoc for this to save redundancy.
- `temingo init` should create the initial folder structure and a simple example page that includes the most features. The necessary file contents should be embedded and can be used for tests.
- special needs have to be addressed. This includes RSS and sitemaps.

- don't make things flexible (aka variables) if there is no need. F.e. making the name of the templates or output folder flexible via variables.
-->


## Features

### Speed
The following points were considered during developing this webpage:
- [x] The used CSS is *not* less enough to just embed it in the HTML instead of using a dedicated CSS file. More details on that topic can be found on https://mathiasbynens.be/notes/inline-vs-separate-file. TL;DR: For CSS smaller than some 700 bytes, it actually *reduces* bandwidth and loading speed to have CSS and HTML in the same file, because of reduced packet overhead and the necessity of the additional request for the CSS file. (At the time of writing, the CSS alone has a size ~6kB minified.)
- [x] A CDN does *not* make sense for this website. While they add convenience and performance to larger sites, they don't like unfrequently visited sites: For sites not in their cache (anymore, as they aren't visited frequently enough) they even add latency, as they fetch the site themselves before providing it to the actual requester. At the same time not using CDNs reduces scaling capabilities, increases DDoS chances, and introduces additional latency for website-calls from (at least) other continents. I dediced to take this risk.
- [x] The goal was to get as much direct html with as less javascript as possible. That means that javascript frameworks like vuejs or svelte don't fit here.
      A static site generator like hugo would fit, but has a gazillion of unnecessary features and doesn't support automatic code indentation in the generated files (which triggers my OCD).
      In addition, it provides many ways of doing things, which I do believe is not a good design.
      Therefore, I started developing my own static [site generator](https://github.com/thetillhoff/temingo), and use it for this website.
- [x] Compression is enabled on server side.

### Dark and light modes
To support both dark and light modes, the following adjustments were made:
- [x] `color-scheme: light dark;` makes the browser automatically adjust the website default colors according to the browser preferences (without flashing!). If you're on dark mode, the default background is dark, if your default is light mode, the background will be light by default.
  As a great side effect this prevents pages from flashing in the default color of the background (normally white) before the dark-mode CSS styling kicks in.
- [x] In addition, conditional CSS colorization variables are set via media queries for `prefers-color-scheme`. Those are used to darken on highlight (f.e. when hovering) in light mode and vice versa.

### IPv4 compatible and IPv6 ready
- [ ] This webpage is hosted on a server that provides a IPv4 and IPv6 address, which are referenced in an A and an AAAA DNS record respectively.

### Security by design
- [x] secure TLS
  - [x] HTTP requests are redirected to HTTPS.
  - [x] HTTPS has automatically renewed certificates (letsencrypt).
  - [x] Only TLS1.2 or higher are allowed.
  - [x] Insecure ciphers are disabled.
- [x] HTTP headers are configured for maximum security:
  - [x] HSTS is enabled.
  - [x] XSS is prevented.
  - [x] CSPs are set.
- More information can be found in the [README.md of webscan](https://github.com/thetillhoff/webscan), which I wrote specifically to scan websites for infrastructure and security issues and best-practices.

### Accessibility
- [x] Discernible text for links - if there is only an icon in there, add an aria-label
- [ ] https://developers.google.com/search/docs/appearance/title-link?visit_id=638185384773364906-586104254&rd=1#1

### Analytics
I was thinking about using server-side analytics, instead of any client-side javascript code. But browsers often cache a whole page, so the server wouldn't get a request for every page load of a user. Javscript still runs on every page load, even if cached. Therefore a lightweight javascript is used, that only transmits data to a selfhosted instance for that analytics tool.

The script is only added when the container has the env var `UMAMI_WEBSITE_ID` set. Without it, the pages contain no script. Example: `docker run -e UMAMI_WEBSITE_ID=<id> -p 80:80 ghcr.io/thetillhoff/thetillhoff.de`.

## Development
Use `./temingo -wsv` for continuous building and serving.


FEATURE IDEAS
- If there is neither a meta.yaml, nor a content.md in a folder, but only subfolders, then iterate over those subfolders (recursively). If a meta.yaml/content.md is found, check parent-folders until an index.metatemplate.html is found (again, recursive).
- If there is a content.md, but no meta.yaml, use the folder name as title (lowercase, "safe").
- ? When there's a metatemplate, subfolders don't contain a meta.yaml, but there are subsubfolders, then use that metatemplate for them as well ("metatemplate recursion", see above as well).
- Add a variable to the templates "local path" so it's possible to use absolute paths, but users don't have to specify them in the source
- Breadcrumbs for docs etc
---

Idea for Infrastructure is Cool

**Introduction:**
- Introduce yourself and your passion for IT infrastructure and modern technologies.
- Briefly set the stage for the story: "Today, I'm going to take you on a journey of building an awesome website and the adventure of running it at scale!"

**Act 1: The Birth of the Cool Website**
- Start with an exciting idea for a website and how it came to be.
- Showcase the development process, explaining the tech stack used (e.g., HTML, CSS, JavaScript, etc.).
- Demo the simple website on your local machine and share the excitement of the initial creation.

**Act 2: The Quest for Scalability**
- As more users discover the website, it gains popularity, and you encounter scaling challenges.
- Explain the importance of scalability and how it's vital for growing businesses.
- Introduce the concept of scaling horizontally and vertically to handle increased traffic.
- Demo the website's performance on a single server and simulate traffic to reveal bottlenecks.

**Act 3: Enter Containers**
- As demand continues to rise, you realize traditional server setups won't cut it anymore.
- Introduce the concept of containers and how they bring flexibility and consistency to deployments.
- Showcase containerization using Docker and its benefits in isolating applications.
- Containerize the website and demonstrate how easy it is to package and ship it across environments.

**Act 4: The Journey to the Cloud**
- With containerized applications, it's time to explore the world of cloud infrastructure.
- Discuss the advantages of cloud platforms like AWS, GCP, or Azure.
- Deploy the containerized website on a cloud platform using Terraform, highlighting Infrastructure as Code.

**Act 5: Handling Success with Load Balancing**
- As the website gains even more popularity, you face new challenges to ensure high availability.
- Introduce load balancing and its role in distributing traffic across multiple servers.
- Implement load balancing for the website using Kubernetes, ensuring seamless user experience.

**Act 6: A Symphony of Automation**
- With infrastructure growing complex, manual management becomes tedious.
- Showcase the power of automation with tools like Ansible to streamline deployments and updates.
- Automate the scaling process to handle traffic spikes effortlessly.

**Act 7: Keeping a Watchful Eye - Monitoring and Optimization**
- With a website running at scale, monitoring becomes essential to ensure performance and reliability.
- Introduce monitoring tools like Grafana and Prometheus for real-time insights.
- Showcase how to monitor the website's performance and optimize resources for efficiency.

**Act 8: The Impenetrable Fortress - Security and Compliance**
- Highlight the critical aspect of security and protecting the website and its users.
- Discuss container security measures and best practices for securing the infrastructure.
- Implement basic security measures to fortify the website and infrastructure.

**Conclusion:**
- Recap the incredible journey of building the awesome website and scaling it to success.
- Emphasize the importance of modern infrastructure in enabling businesses to thrive.
- Encourage the audience to explore the exciting world of IT infrastructure and embrace new technologies.

**Closing:**
- Thank the audience for joining you on this adventurous journey.
- Offer a Q&A session for any questions and discussions.
- Provide additional resources for further learning and experimentation.

Remember to bring energy and enthusiasm to the presentation, as this captivating story will take your audience through a thrilling experience of building and running a cool website with cutting-edge infrastructure concepts! Good luck, and have fun with your presentation!

---

focus on these acts:

The Quest for Scalability (Act 2): This act is essential as it introduces the main challenge faced by many businesses as they grow. Explain the importance of scalability and how it directly impacts the website's performance and user experience. Use visual aids and interactive examples to showcase the difference between a non-scalable website and a scalable one under increasing traffic.

Enter Containers (Act 3): Containers are a revolutionary technology that has transformed the way applications are deployed and managed. Focus on this act to emphasize the benefits of containerization, such as consistency, portability, and resource isolation. Use a live demo to showcase how easy it is to package and deploy the website in containers.

Handling Success with Load Balancing (Act 5): Load balancing is a crucial aspect of ensuring high availability and optimal performance, especially when dealing with increased traffic. Put a strong focus on this act to demonstrate how load balancing works, the different algorithms used, and how it improves the website's reliability.

A Symphony of Automation (Act 6): Automation is a key enabler of modern IT infrastructure management. Give significant attention to this act to showcase how automation streamlines the deployment and management process. Use examples to demonstrate how automation saves time, reduces errors, and enhances overall efficiency.

---

pitfalls:
- overload with technical jargon
- lack of context
- too much detail
- skipping the basics
- lack of engangement
- rushing
- neglecting visuals
- lack of clear takeaways
- running out of time

roughly 1h, if each slide takes 5-8min, but leave buffer, so 1h15min or so

depending on audience, adjust:
- tech terms
- level of detail
- visuals
- pace
- audience interaction
- focus on story vs on topics
- impact on business vs tech advantages
