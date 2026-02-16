import Link from 'next/link'
import { Card, CardContent } from '@/components/ui/card'
import { Heart, Shield, Users, Handshake, Hammer, AlertTriangle, Flag, Scale, Mail, BookOpen } from 'lucide-react'

export default function CodeOfConductPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      <div className="max-w-4xl mx-auto py-12 px-4">
        {/* Header */}
        <div className="text-center mb-8">
          <div className="flex justify-center mb-4">
            <Heart className="h-12 w-12 text-rose-600" />
          </div>
          <h1 className="text-4xl font-bold text-gray-900 mb-2">
            Code of Conduct
          </h1>
          <p className="text-gray-600">
            MIRA Workshop - Building a safe and inclusive community
          </p>
        </div>

        <Card className="shadow-xl">
          <CardContent className="prose prose-sm max-w-none pt-6 space-y-6">
            {/* Purpose & Scope */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <BookOpen className="mr-2 h-6 w-6 text-blue-600" />
                Purpose and Scope
              </h2>
              <p className="text-gray-700 leading-relaxed">
                The Modular Interoperable Research Attribution team is dedicated to fostering an environment
                that enables innovative, collaborative, and community-driven advancements in open science.
                This event is a unique opportunity to bring together researchers, technologists, and leaders
                from diverse backgrounds to collectively explore and build the infrastructure and culture
                necessary for a more open, frictionless, and accessible research ecosystem.
              </p>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">Purpose</h3>
              <ol className="list-decimal pl-6 text-gray-700 space-y-2">
                <li>
                  <strong>Ensure Inclusivity and Equity:</strong> Create an environment where all
                  participants—regardless of background, identity, or experience—feel welcome, valued,
                  and able to contribute meaningfully. Actively promote equity in voice by encouraging
                  participation from historically underrepresented groups and ensuring that diverse
                  perspectives are respected and included in all discussions.
                </li>
                <li>
                  <strong>Promote Collaboration:</strong> Encourage respectful engagement and curiosity,
                  recognizing that multiple approaches to solving shared challenges enrich our collective
                  understanding. Support participants in building forward relationships and fostering
                  ongoing collaborations that extend beyond the event itself.
                </li>
                <li>
                  <strong>Foster Safety and Community Accountability:</strong> Establish a space where all
                  participants share responsibility for maintaining a positive, inclusive environment.
                  Encourage mutual respect, trust, and constructive interactions to ensure that everyone
                  feels safe and supported throughout the event.
                </li>
              </ol>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">Scope</h3>
              <p className="text-gray-700 leading-relaxed mb-2">This Code of Conduct extends to:</p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>All participants, including attendees, speakers, organizers, volunteers, and sponsors.</li>
                <li>
                  All event-related spaces, whether physical or virtual, including conference venues, social
                  gatherings, online discussions, and communication channels such as email or Slack.
                </li>
              </ul>
            </section>

            {/* Encouraged Behavior - PRIC Model */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <Users className="mr-2 h-6 w-6 text-blue-600" />
                Encouraged Behavior
              </h2>
              <p className="text-gray-700 leading-relaxed mb-4">
                All participants in MIRA are expected to not be a PRIC and here&apos;s how you do that proactively :)
              </p>

              <div className="space-y-3">
                <div className="bg-blue-50 border-l-4 border-blue-600 p-4">
                  <h4 className="font-semibold text-blue-900 mb-1 flex items-center">
                    <Shield className="mr-2 h-4 w-4" />
                    Protect
                  </h4>
                  <p className="text-sm text-blue-800">
                    Commit to creating a space where all participants feel safe and valued. Take responsibility
                    for ensuring that personal and community behaviors align with the values of MIRA.
                  </p>
                  <p className="text-xs text-blue-700 mt-2 italic">
                    e.g. Cede voice to those who might typically not talk, listen to people&apos;s ideas.
                    Criticize the idea not the person.
                  </p>
                </div>

                <div className="bg-green-50 border-l-4 border-green-600 p-4">
                  <h4 className="font-semibold text-green-900 mb-1 flex items-center">
                    <Handshake className="mr-2 h-4 w-4" />
                    Respect
                  </h4>
                  <p className="text-sm text-green-800">
                    Approach discussions with curiosity, patience, and an open mind. Assume good intent
                    while recognizing the impact of words and actions.
                  </p>
                  <p className="text-xs text-green-700 mt-2 italic">
                    e.g. Don&apos;t play the blame game. If someone is impacting you (or you can see they&apos;re
                    impacting others) in a certain way and you&apos;re comfortable having a convo, have it.
                    If you&apos;re not, chat with us :)
                  </p>
                </div>

                <div className="bg-purple-50 border-l-4 border-purple-600 p-4">
                  <h4 className="font-semibold text-purple-900 mb-1 flex items-center">
                    <Users className="mr-2 h-4 w-4" />
                    Include
                  </h4>
                  <p className="text-sm text-purple-800">
                    Welcome and respect diverse perspectives, experiences, and identities. Actively encourage
                    and support participation from individuals across different backgrounds, particularly
                    those from underrepresented groups.
                  </p>
                </div>

                <div className="bg-amber-50 border-l-4 border-amber-600 p-4">
                  <h4 className="font-semibold text-amber-900 mb-1 flex items-center">
                    <Hammer className="mr-2 h-4 w-4" />
                    Construct
                  </h4>
                  <p className="text-sm text-amber-800">
                    Contribute to building forward relationships and collaborations that extend beyond
                    the event. Share knowledge and insights in ways that promote mutual learning and progress.
                  </p>
                </div>
              </div>
            </section>

            {/* Unacceptable Behavior */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <AlertTriangle className="mr-2 h-6 w-6 text-red-600" />
                Unacceptable Behavior
              </h2>
              <p className="text-gray-700 leading-relaxed mb-3">
                The following behaviors are considered unacceptable at MIRA and its related spaces and
                may result in removal from the space:
              </p>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">1. Harassment and Discrimination</h3>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Harassment in any form, including but not limited to verbal, physical, sexual, or online harassment.</li>
                <li>
                  Discrimination or exclusion based on gender, race, ethnicity, age, sexual orientation,
                  disability, religion, or any other aspect of identity.
                </li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">2. Disrespectful Conduct</h3>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Dismissing or belittling the contributions of others.</li>
                <li>Engaging in hostile or aggressive behavior that undermines constructive dialogue.</li>
                <li>Intentionally disrupting presentations, workshops, or discussions.</li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">3. Unwelcome Advances or Contact</h3>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Making inappropriate or unwelcome personal advances, whether verbal or physical.</li>
                <li>Violating personal boundaries or failing to respect requests to disengage.</li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">4. Harmful Actions Toward Community Goals</h3>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Misusing shared spaces or resources in ways that detract from the event&apos;s purpose.</li>
                <li>Deliberately spreading misinformation or undermining collaborative efforts.</li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">5. Retaliation or Dismissiveness</h3>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Retaliating against individuals who raise concerns about conduct.</li>
                <li>Dismissing reports of inappropriate behavior or failing to address them in good faith.</li>
              </ul>
            </section>

            {/* Reporting */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <Flag className="mr-2 h-6 w-6 text-blue-600" />
                Reporting Mechanisms
              </h2>
              <p className="text-gray-700 leading-relaxed">
                If you observe or experience any behaviors that represent a code of conduct violation,
                or a violation of your safety in the space, please report it either to in-person staff
                or to our anonymous reporting form. We will handle all reports with as much discretion as possible.
              </p>
              <div className="bg-rose-50 border-l-4 border-rose-600 p-4 mt-3">
                <p className="text-sm text-rose-800 font-medium">
                  Unsafe spaces ruin it for everyone. We will have specific staff focused on maintaining
                  this safe space, however we invite the entirety of the community to remind others of
                  our standards when necessary. It&apos;s trite, but if you see something say something :)
                </p>
              </div>
              <p className="text-gray-700 leading-relaxed mt-3">
                Any written reports will be stored only for the purpose of enforcing the Code of Conduct
                and will not be shared outside of the safety team.
              </p>
              <div className="bg-gray-50 p-4 rounded-lg mt-3">
                <p className="text-sm text-gray-700">
                  <strong>Report violations:</strong><br />
                  Email: <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">contact@scios.tech</a><br />
                  Or speak to staff at the event.
                </p>
              </div>
            </section>

            {/* Consequences */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <Scale className="mr-2 h-6 w-6 text-blue-600" />
                Consequences of Violations
              </h2>
              <p className="text-gray-700 leading-relaxed mb-2">
                Actions our team may take include and are not limited to:
              </p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Asking anyone to stop a behavior; the person asked is expected to comply immediately</li>
                <li>Asking anyone to leave the event and online spaces either temporarily, for the remainder of the event, or permanently</li>
                <li>Removing anyone&apos;s access to the event spaces that we manage either temporarily, for the remainder of the event, or permanently</li>
                <li>Communicating to all participants to reinforce our expectations for conduct and remind what is unacceptable behavior</li>
                <li>Communicating to all participants that an incident has taken place and how we will act or have acted</li>
                <li>Banning anyone from participating in SciOS-managed spaces, future events and activities, either temporarily or permanently</li>
                <li>No action</li>
              </ul>

              <p className="text-gray-700 leading-relaxed mt-4 mb-2">
                Please note that there are spaces and platforms on which we have no way to control access. These include but are not limited to:
              </p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Social media platforms, e.g. Twitter, Facebook</li>
                <li>Public GitHub repositories</li>
              </ul>
              <p className="text-gray-700 leading-relaxed mt-2">
                In these venues, in addition to some of the other actions we can take above, we can
                be the ones who/support participants to report issues to the venue and support and
                encourage participants to block people.
              </p>
            </section>

            {/* Appeals */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Appeals</h2>
              <p className="text-gray-700 leading-relaxed">
                Please contact{' '}
                <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">
                  contact@scios.tech
                </a>{' '}
                if you would like to appeal a decision.
              </p>
            </section>

            {/* Acknowledgments */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Acknowledgments</h2>
              <p className="text-gray-700 leading-relaxed mb-2">
                This Code of Conduct was inspired by:
              </p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>The eLife code of conduct</li>
                <li>Anti-harassment policy from the Geek Feminism wiki</li>
              </ul>
            </section>

            {/* Contact */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <Mail className="mr-2 h-6 w-6 text-blue-600" />
                Contact Us
              </h2>
              <p className="text-gray-700 leading-relaxed">
                If you have any questions about this Code of Conduct, please contact us:
              </p>
              <div className="bg-blue-50 p-4 rounded-lg mt-3">
                <p className="text-gray-800">
                  <strong>Email:</strong>{' '}
                  <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">
                    contact@scios.tech
                  </a>
                  <br />
                  <strong>Subject Line:</strong> MIRA Code of Conduct Inquiry
                </p>
              </div>
            </section>

            {/* Quick Links */}
            <section className="border-t pt-6 mt-8">
              <div className="flex flex-wrap gap-4 justify-center text-sm">
                <Link href="/" className="text-blue-600 hover:underline">
                  Home
                </Link>
                <span className="text-gray-400">•</span>
                <Link href="/apply" className="text-blue-600 hover:underline">
                  Apply
                </Link>
                <span className="text-gray-400">•</span>
                <Link href="/privacy" className="text-blue-600 hover:underline">
                  Privacy Policy
                </Link>
                <span className="text-gray-400">•</span>
                <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">
                  Contact Us
                </a>
              </div>
            </section>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
