import { Button } from '@/components/ui/button'
import Link from 'next/link'

export default function Home() {
  return (
    <div className="flex flex-col">
      {/* Hero Section */}
      <section className="relative py-24 px-4 bg-gradient-to-br from-workshop-secondary via-white to-workshop-primary/10">
        <div className="container mx-auto max-w-6xl">
          <div className="text-center space-y-6">
            <h1 className="text-5xl font-bold text-gray-900 tracking-tight">
              Catalyzing Modular Networked
              <span className="text-workshop-primary"> Research Attribution</span>
            </h1>
            <p className="text-xl text-gray-600 max-w-3xl mx-auto">
              Join us for a groundbreaking workshop to design and prototype interoperable
              frameworks for modular research attribution. Bringing together scientists,
              designers, and engineers to build the future of scientific collaboration.
            </p>
            <div className="flex gap-4 justify-center pt-4">
              <Button size="lg" asChild>
                <Link href="/apply">Apply to Participate</Link>
              </Button>
              <Button variant="outline" size="lg" asChild>
                <Link href="/status">Check Application Status</Link>
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Key Information */}
      <section className="py-16 px-4">
        <div className="container mx-auto max-w-6xl">
          <div className="grid md:grid-cols-4 gap-8">
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-workshop-primary">June 7-11</div>
              <div className="text-gray-600">2026</div>
            </div>
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-workshop-primary">Ireland</div>
              <div className="text-gray-600">The Deerstone Eco Hideaway</div>
            </div>
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-workshop-primary">22</div>
              <div className="text-gray-600">Participants</div>
            </div>
            <div className="text-center space-y-2">
              <div className="text-4xl font-bold text-workshop-primary">5 Days</div>
              <div className="text-gray-600">Intensive Collaboration</div>
            </div>
          </div>
        </div>
      </section>

      {/* Timeline Section */}
      <section className="py-16 px-4 bg-gray-50">
        <div className="container mx-auto max-w-6xl">
          <h2 className="text-3xl font-bold text-center mb-12">Workshop Timeline</h2>
          <div className="space-y-6">
            <div className="flex gap-4 items-start">
              <div className="flex-shrink-0 w-32 text-right font-semibold text-workshop-primary">
                Fall 2025
              </div>
              <div className="flex-1">
                <h3 className="font-semibold text-lg mb-1">Applications Open</h3>
                <p className="text-gray-600">Submit your application to join the workshop</p>
              </div>
            </div>
            <div className="flex gap-4 items-start">
              <div className="flex-shrink-0 w-32 text-right font-semibold text-workshop-primary">
                Early 2026
              </div>
              <div className="flex-1">
                <h3 className="font-semibold text-lg mb-1">Pre-Workshop Preparation</h3>
                <p className="text-gray-600">5-7 collaborative calls to consolidate use cases and prototypes</p>
              </div>
            </div>
            <div className="flex gap-4 items-start">
              <div className="flex-shrink-0 w-32 text-right font-semibold text-workshop-primary">
                June 7-11, 2026
              </div>
              <div className="flex-1">
                <h3 className="font-semibold text-lg mb-1">5-Day Intensive Workshop</h3>
                <p className="text-gray-600">Design, prototype, and test shared frameworks in Ireland</p>
              </div>
            </div>
            <div className="flex gap-4 items-start">
              <div className="flex-shrink-0 w-32 text-right font-semibold text-workshop-primary">
                Post-Workshop
              </div>
              <div className="flex-1">
                <h3 className="font-semibold text-lg mb-1">Implementation & Follow-up</h3>
                <p className="text-gray-600">Build APIs and continue development with engineering grants</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Goals Section */}
      <section className="py-16 px-4">
        <div className="container mx-auto max-w-6xl">
          <h2 className="text-3xl font-bold text-center mb-12">Workshop Goals</h2>
          <div className="grid md:grid-cols-2 gap-8">
            <div className="space-y-4">
              <h3 className="text-xl font-semibold text-workshop-primary">
                Design Interoperable Standards
              </h3>
              <p className="text-gray-600">
                Create shared protocols and schemas for modular research attribution
                that work across diverse platforms and tools.
              </p>
            </div>
            <div className="space-y-4">
              <h3 className="text-xl font-semibold text-workshop-primary">
                Build Working Prototypes
              </h3>
              <p className="text-gray-600">
                Develop proof-of-concept implementations that demonstrate real-world
                applications of the attribution network.
              </p>
            </div>
            <div className="space-y-4">
              <h3 className="text-xl font-semibold text-workshop-primary">
                Unite Parallel Efforts
              </h3>
              <p className="text-gray-600">
                Align disparate technological and social efforts working toward
                similar goals in research attribution.
              </p>
            </div>
            <div className="space-y-4">
              <h3 className="text-xl font-semibold text-workshop-primary">
                Enable Real-Time Science
              </h3>
              <p className="text-gray-600">
                Create infrastructure for researchers to share and attribute discrete
                research results before traditional publication.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Call to Action */}
      <section className="py-16 px-4 bg-workshop-primary text-white">
        <div className="container mx-auto max-w-4xl text-center space-y-6">
          <h2 className="text-3xl font-bold">Ready to Shape the Future of Research?</h2>
          <p className="text-xl opacity-90">
            Join scientists, designers, and engineers working to revolutionize how we
            share and attribute scientific contributions.
          </p>
          <Button size="lg" variant="secondary" asChild>
            <Link href="/apply">Apply Now</Link>
          </Button>
        </div>
      </section>
    </div>
  )
}