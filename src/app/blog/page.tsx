import Link from 'next/link'
import Image from 'next/image'
import { Button } from '@/components/ui/button'

export default function BlogPage() {
  return (
    <div className="min-h-screen bg-white">
      {/* Hero Section */}
      <section className="py-20 px-4 bg-gradient-to-b from-slate-900 to-slate-800">
        <div className="container mx-auto max-w-4xl text-center">
          <h1 className="text-4xl md:text-5xl font-bold text-white mb-6">
            Blog
          </h1>
          <p className="text-xl text-slate-300 max-w-3xl mx-auto">
            Updates and insights on modular research attribution
          </p>
        </div>
      </section>

      {/* Blog Post */}
      <article className="py-16 px-4">
        <div className="container mx-auto max-w-4xl">

          {/* Post Header */}
          <header className="mb-12 pb-8 border-b border-gray-200">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
              Introducing Modular Research Attribution
            </h2>
            <p className="text-gray-500 text-sm">
              The MIRA Narrative
            </p>
          </header>

          <div className="prose prose-lg prose-slate max-w-none">

            {/* What is Modular Research */}
            <section className="mb-16">
              <h2 className="text-3xl font-bold text-gray-900 mb-6">What is modular research?</h2>

              <p className="text-gray-700 leading-relaxed mb-6">
                At two recent{' '}
                <a
                  href="https://articles.continuousfoundation.org/articles/scientific-standards-meeting"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-cyan-600 hover:text-cyan-700"
                >
                  workshops organized by The Continuous Science Foundation
                </a>
                , we articulated a concrete new paradigm for conducting and communicating science: interoperable, modular, composable research.
              </p>

              <p className="text-gray-700 leading-relaxed mb-6">
                Current forms of research attribution - authorship in published journal articles - do a disservice to individual contribution in large collaborations. A complementary medium is necessary to effectively structure collaborations within and between research groups, in a manner that centers individual contributions and creates an attribution trail in a self-propagating manner.
              </p>

              <p className="text-gray-700 leading-relaxed mb-6">
                This new system relies on the creation of an interoperable information layer larger than data and smaller than papers: an attributable network for modular research results. Importantly, this modular approach tracks the key <em>information</em> communicated in scientific arguments and papers, and allows different researchers to contribute, track, and compile them, individually, in smaller &quot;micropublications,&quot; or in traditional journal articles.
              </p>

              <div className="bg-slate-50 border border-slate-200 rounded-lg p-6 my-8">
                <div className="grid md:grid-cols-2 gap-6 mb-4">
                  <Image
                    src="/figure 1.png"
                    alt="Discourse graph information model"
                    width={500}
                    height={400}
                    className="w-full h-auto rounded"
                  />
                  <Image
                    src="/figure 2.png"
                    alt="DNA structure example with Franklin's result"
                    width={500}
                    height={400}
                    className="w-full h-auto rounded"
                  />
                </div>
                <p className="text-sm text-gray-600 mb-2"><strong>Figure 1:</strong></p>
                <p className="text-gray-700">
                  (Left) An information model for modular research contributions — a discourse graph. Evidence (results) are discrete observations from a single experiment, dataset, or figure panel/table of a journal article. (Right) Distinguishing models of DNA structure with an experimental result by Rosalind Franklin. In an imagined modular research publishing environment, Franklin could post the result, and Crick/Watson would need to cite the result to support their claim that DNA forms a double helix.
                </p>
                <p className="text-xs text-gray-500 mt-2">License: CC-BY4.0</p>
              </div>

              <p className="text-gray-700 leading-relaxed mb-6">
                Indeed, our cell biology lab operates on this principle:
              </p>

              <div className="bg-slate-50 border border-slate-200 rounded-lg p-6 my-8">
                <Image
                  src="/figure 3.png"
                  alt="MATSUlab discourse graph"
                  width={1000}
                  height={600}
                  className="w-full h-auto rounded mb-4"
                />
                <p className="text-sm text-gray-600 mb-2"><strong>Figure 2:</strong></p>
                <p className="text-gray-700">
                  A &quot;discourse graph&quot; by the{' '}
                  <a
                    href="https://matsulab.com/"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-cyan-600 hover:text-cyan-700"
                  >
                    MATSUlab
                  </a>
                  . We compile these results into panels of figures for research articles, or share them individually to support our evolving models of cell biology.
                </p>
                <p className="text-xs text-gray-500 mt-2">License: CC-BY4.0</p>
              </div>

              <p className="text-gray-700 leading-relaxed">
                In an ongoing pilot supported by the Chan Zuckerberg Initiative and The Navigation Fund, we&apos;ve introduced this approach to several other labs around North America, in the fields of cell biology, biochemistry, and quantum biology. Our early observations indicate that the process helps researchers think like a scientist, gain confidence in sharing early work, and make discrete contributions to shared research projects.
              </p>
            </section>

            {/* What is Modular Research Attribution */}
            <section className="mb-16">
              <h2 className="text-3xl font-bold text-gray-900 mb-6">What is modular research attribution?</h2>

              <p className="text-gray-700 leading-relaxed mb-6">
                As these networks of research results and claims grow beyond a single lab, it will be increasingly important to share, track, and cite individual results between collaborating research labs and beyond.
              </p>

              <p className="text-gray-700 leading-relaxed mb-6">
                We propose that attribution across modular research elements will unlock multi-lab collaboration, making it safer for researchers to contribute individual research results in a shared project earlier, confident that their work will make a substantive contribution and will be appropriately recognized.
              </p>

              <div className="bg-slate-50 border border-slate-200 rounded-lg p-6 my-8">
                <Image
                  src="/figure 4.png"
                  alt="Schema for sharing research between labs"
                  width={800}
                  height={500}
                  className="w-full h-auto rounded mb-4"
                />
                <p className="text-sm text-gray-600 mb-2"><strong>Figure 3:</strong></p>
                <p className="text-gray-700">
                  Schema for sharing and citing discrete research objects such as hypotheses and claims between research labs.
                </p>
                <p className="text-xs text-gray-500 mt-2">License: CC-BY4.0</p>
              </div>

              <p className="text-gray-700 leading-relaxed mb-4">
                To enable a larger, more diffuse network of contributions, a few types of metadata are needed:
              </p>

              <ul className="list-disc pl-6 text-gray-700 space-y-2 mb-6">
                <li><strong>Contributor</strong> (with an identifier like ORCID)</li>
                <li><strong>Date</strong> (so that there is a transparent audit trail between research elements)</li>
                <li><strong>Identifier</strong> (some unique value that gets you back to the posted material)</li>
                <li><strong>License</strong> (eg a Creative Commons license that stipulates you must attribute the contributor for reuse)</li>
              </ul>
            </section>

            {/* What About AI */}
            <section className="mb-16">
              <h2 className="text-3xl font-bold text-gray-900 mb-6">What about AI?</h2>

              <p className="text-gray-700 leading-relaxed">
                Exactly! This system{' '}
                <a
                  href="https://www.youtube.com/watch?v=uy-igUYz9kA"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-cyan-600 hover:text-cyan-700"
                >
                  may be more compatible with AI
                </a>
                {' '}than narrative articles on their own. By specifying the core elements of research arguments, we give Large Language Models scaffolding for properly using and citing the building blocks of knowledge. In turn, by properly citing our results, we can better track the <em>utility</em> and <em>impact</em> of our original research.
              </p>
            </section>

            {/* What is This Workshop */}
            <section className="mb-16">
              <h2 className="text-3xl font-bold text-gray-900 mb-6">What is this workshop?</h2>

              <p className="text-gray-700 leading-relaxed mb-6">
                We are convening a 22-person workshop that consolidates emerging parallel efforts to build a proof-of-concept modular research attribution network, enabling researchers to share, discover, and attribute discrete research results.
              </p>

              <p className="text-gray-700 leading-relaxed mb-6">
                Beyond a single &quot;one size fits all&quot; app or database, we seek to design, prototype, and test an interoperable network for researchers to share and reference granular results with collaborators outside their lab. We will bring together practicing scientists, designers, and engineers to share real-world scientific use cases, design accessible interfaces, and build proof-of-concept workflows from our user data.
              </p>

              <div className="bg-cyan-50 border border-cyan-200 rounded-lg p-6 my-8">
                <h3 className="text-lg font-bold text-cyan-900 mb-4">Success looks like:</h3>
                <ul className="list-disc pl-6 text-cyan-800 space-y-2">
                  <li>Participating researchers share real-world, attributable examples of their research results with their labmates or collaborators, through different user-facing applications, thanks to the interoperable protocol that we develop</li>
                  <li>The standards we develop are incorporated into the participating tool builders&apos; applications, such as{' '}
                    <a href="https://discoursegraphs.com/" target="_blank" rel="noopener noreferrer" className="text-cyan-600 hover:text-cyan-700 underline">Discourse Graphs</a>
                    {' '}and{' '}
                    <a href="https://semble.so/" target="_blank" rel="noopener noreferrer" className="text-cyan-600 hover:text-cyan-700 underline">Semble</a>
                  </li>
                  <li>We collect evidence indicating how modular attribution may be a more accurate and useful signal for scientific contribution than journal article authorship alone</li>
                </ul>
              </div>

              <p className="text-gray-700 leading-relaxed mb-6">
                The aforementioned Continuous Science Foundation workshop led to a schema for interoperable manuscript composition, called{' '}
                <a
                  href="https://github.com/scientific-publishing-tools-meeting/oxa"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-cyan-600 hover:text-cyan-700"
                >
                  OXA
                </a>
                . We think it&apos;s a starting point for these interoperable modular research standards for attribution.
              </p>

              <div className="bg-slate-50 border border-slate-200 rounded-lg p-6 my-8">
                <div className="grid md:grid-cols-2 gap-6 mb-4">
                  <Image
                    src="/figure 5.png"
                    alt="OXA - The Open Exchange Architecture"
                    width={500}
                    height={400}
                    className="w-full h-auto rounded"
                  />
                  <Image
                    src="/figure 6.png"
                    alt="Paper repository schema"
                    width={500}
                    height={400}
                    className="w-full h-auto rounded"
                  />
                </div>
                <p className="text-sm text-gray-600 mb-2"><strong>Figure 4:</strong></p>
                <p className="text-gray-700">
                  Emerging standards and schemas for interoperable research manuscript composition.
                </p>
                <p className="text-xs text-gray-500 mt-2">License: CC-BY4.0</p>
              </div>
            </section>

            {/* Apply If */}
            <section className="mb-16">
              <h2 className="text-3xl font-bold text-gray-900 mb-6">Apply if:</h2>

              <ul className="list-disc pl-6 text-gray-700 space-y-3 mb-8">
                <li><strong>You have a potential use case!</strong> &quot;I am a researcher who wants to collaborate by….&quot; &quot;I have been sharing my results in a modular way…&quot;</li>
                <li><strong>You design human/computer interaction systems!</strong> &quot;I&apos;ve designed user experiences for…&quot; &quot;I have an idea for how researchers would interact with these applications…&quot;</li>
                <li><strong>You like to build interoperable systems for research communication and/or collaboration!</strong> &quot;I created a means of connecting…&quot; &quot;I want to build data systems that…&quot;</li>
                <li><strong>You have a perspective on the emerging &quot;scientific communication ecosystem&quot; beyond journal articles!</strong> &quot;I helped bring preprints to…&quot; &quot;I am bringing…&quot;</li>
                <li><strong>Or:</strong> you have another possible contribution not listed here!</li>
              </ul>
            </section>

            {/* Commitments */}
            <section className="mb-16">
              <h2 className="text-3xl font-bold text-gray-900 mb-6">Commitments</h2>

              <p className="text-gray-700 leading-relaxed mb-6">
                Prior to the meeting, we will meet in small groups by Zoom for a total commitment between 2 and 5 hours, in order to iterate on an initial standard/schema, use cases, and designs. Attendees will be required to join the entire in-person meeting.
              </p>

              <p className="text-gray-700 leading-relaxed">
                Because we can only bring 22 people to the workshop, we will endeavor to have a Zoom workshop, before and after the in-person workshop, that incorporate and harness the ideas and enthusiasm of applicants who we could not invite in person.
              </p>
            </section>

          </div>
        </div>
      </article>

      {/* CTA Section */}
      <section className="py-16 px-4 bg-slate-50 border-t border-slate-200">
        <div className="container mx-auto max-w-3xl text-center">
          <h2 className="text-3xl font-bold text-gray-900 mb-4">Ready to participate?</h2>
          <p className="text-lg text-gray-600 mb-8">
            Join us in shaping the future of research attribution.
          </p>
          <Button
            size="lg"
            className="bg-cyan-600 hover:bg-cyan-700 text-white px-10 py-6 text-base font-medium"
            asChild
          >
            <Link href="/apply">Apply Now</Link>
          </Button>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-8 px-4 bg-gray-900 border-t border-gray-800">
        <div className="container mx-auto max-w-4xl">
          <div className="flex flex-col md:flex-row justify-between items-center gap-4 text-sm text-gray-400">
            <div>© 2026 SciOS</div>
            <div className="flex gap-6">
              <Link href="/about" className="hover:text-white transition-colors">
                About
              </Link>
              <Link href="/blog" className="hover:text-white transition-colors">
                Blog
              </Link>
              <Link href="/privacy" className="hover:text-white transition-colors">
                Privacy Policy
              </Link>
              <a href="mailto:contact@scios.tech" className="hover:text-white transition-colors">
                Contact
              </a>
            </div>
          </div>
        </div>
      </footer>
    </div>
  )
}
