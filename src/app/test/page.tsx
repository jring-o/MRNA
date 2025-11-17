import { Button } from '@/components/ui/button'
import Link from 'next/link'

export default function TestHome() {
  return (
    <div className="flex flex-col bg-white">
      {/* Hero Section - Clean and Bold */}
      <section className="relative py-32 px-4 bg-gradient-to-b from-slate-900 to-slate-800">
        <div className="container mx-auto max-w-5xl">
          <div className="text-center space-y-8">
            <div className="space-y-4">
              <div className="text-sm font-medium text-cyan-400 tracking-wider uppercase">
                June 7-11, 2026 • Ireland
              </div>

              <h1 className="text-5xl md:text-6xl font-bold text-white tracking-tight leading-tight">
                Catalyzing Modular Interoperable
                <br />
                Research Attribution
              </h1>

              <p className="text-lg md:text-xl text-slate-300 max-w-3xl mx-auto leading-relaxed">
                A five-day intensive workshop to design and prototype interoperable
                frameworks for modular research attribution. Bringing together researchers,
                designers, and engineers to build the future of scientific communication and collaboration.
              </p>
            </div>

            <div className="flex gap-4 justify-center pt-8">
              <Button
                size="lg"
                className="bg-cyan-600 hover:bg-cyan-500 hover:scale-105 transition-all text-white px-8 py-6 text-base font-medium shadow-lg hover:shadow-xl"
                asChild
              >
                <Link href="/apply">Apply to Participate</Link>
              </Button>
              <Button
                size="lg"
                className="bg-white text-slate-900 hover:bg-cyan-50 hover:scale-105 transition-all px-8 py-6 text-base font-medium shadow-lg hover:shadow-xl"
                asChild
              >
                <Link href="/status">Check Status</Link>
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Key Information - Minimal Stats */}
      <section className="py-20 px-4 border-b border-gray-100">
        <div className="container mx-auto max-w-5xl">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-12">
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-gray-900">June 7-11</div>
              <div className="text-gray-600">2026</div>
            </div>
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-gray-900">Ireland</div>
              <div className="text-gray-600">The Deerstone Eco Hideaway</div>
            </div>
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-gray-900">22</div>
              <div className="text-gray-600">Participants</div>
            </div>
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-gray-900">5 Days</div>
              <div className="text-gray-600">Intensive Collaboration</div>
            </div>
          </div>
        </div>
      </section>

      {/* Timeline & Goals Combined Section */}
      <section className="py-24 px-4 bg-white">
        <div className="container mx-auto max-w-6xl">
          <div className="grid md:grid-cols-4 gap-12">
            {/* Timeline - 1/4 width sidebar */}
            <div className="md:col-span-1">
              <div className="sticky top-24">
                <div className="mb-8">
                  <h2 className="text-2xl font-bold text-gray-900 mb-3">Timeline</h2>
                  <div className="w-12 h-1 bg-cyan-600"></div>
                </div>

                <div className="space-y-6">
                  <div>
                    <div className="text-xs font-medium text-gray-500 uppercase tracking-wide mb-1">
                      Fall 2025
                    </div>
                    <div className="text-sm font-semibold text-gray-900">Applications Open</div>
                  </div>

                  <div>
                    <div className="text-xs font-bold text-cyan-700 uppercase tracking-wide mb-1">
                      Jan 1, 2026
                    </div>
                    <div className="text-sm font-semibold text-gray-900">Deadline</div>
                  </div>

                  <div>
                    <div className="text-xs font-bold text-cyan-700 uppercase tracking-wide mb-1">
                      Jan 15, 2026
                    </div>
                    <div className="text-sm font-semibold text-gray-900">Decisions</div>
                  </div>

                  <div>
                    <div className="text-xs font-medium text-gray-500 uppercase tracking-wide mb-1">
                      Jan-Jun 2026
                    </div>
                    <div className="text-sm font-semibold text-gray-900">Preparation</div>
                  </div>

                  <div>
                    <div className="text-xs font-bold text-cyan-700 uppercase tracking-wide mb-1">
                      Jun 7-11, 2026
                    </div>
                    <div className="text-sm font-semibold text-gray-900">Workshop</div>
                  </div>

                  <div>
                    <div className="text-xs font-medium text-gray-500 uppercase tracking-wide mb-1">
                      Post-Workshop
                    </div>
                    <div className="text-sm font-semibold text-gray-900">Implementation</div>
                  </div>
                </div>
              </div>
            </div>

            {/* Goals - 3/4 width main content */}
            <div className="md:col-span-3">
              <div className="mb-12">
                <h2 className="text-3xl font-bold text-gray-900 mb-3">Workshop Goals</h2>
                <div className="w-16 h-1 bg-cyan-600"></div>
              </div>

              <div className="grid md:grid-cols-2 gap-x-12 gap-y-12">
                <div>
                  <h3 className="text-xl font-bold text-gray-900 mb-4">
                    Design Interoperable Standards
                  </h3>
                  <p className="text-gray-600 leading-relaxed">
                    Create shared protocols and schemas for modular research attribution
                    that work across diverse platforms and tools.
                  </p>
                </div>

                <div>
                  <h3 className="text-xl font-bold text-gray-900 mb-4">
                    Build Working Prototypes
                  </h3>
                  <p className="text-gray-600 leading-relaxed">
                    Develop proof-of-concept implementations that demonstrate real-world
                    applications of the attribution network.
                  </p>
                </div>

                <div>
                  <h3 className="text-xl font-bold text-gray-900 mb-4">
                    Unite Parallel Efforts
                  </h3>
                  <p className="text-gray-600 leading-relaxed">
                    Align disparate technological and social efforts working toward
                    similar goals in research attribution.
                  </p>
                </div>

                <div>
                  <h3 className="text-xl font-bold text-gray-900 mb-4">
                    Enable Real-Time Science
                  </h3>
                  <p className="text-gray-600 leading-relaxed">
                    Create infrastructure for researchers to share and attribute discrete
                    research results before traditional publication.
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Call to Action - Minimal and Strong */}
      <section className="py-24 px-4 bg-white border-t border-gray-100">
        <div className="container mx-auto max-w-3xl text-center space-y-8">
          <div className="space-y-4">
            <h2 className="text-4xl font-bold text-gray-900">
              Ready to Shape the Future of Research?
            </h2>
            <p className="text-xl text-gray-600 leading-relaxed">
              Join us as we work to revolutionize how we
              share and attribute scientific contributions.
            </p>
          </div>

          <div className="pt-4">
            <Button
              size="lg"
              className="bg-cyan-600 hover:bg-cyan-700 text-white px-10 py-6 text-base font-medium"
              asChild
            >
              <Link href="/apply">Apply Now</Link>
            </Button>
          </div>
        </div>
      </section>
    </div>
  )
}
