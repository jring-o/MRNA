import Link from 'next/link'
import { Card, CardContent } from '@/components/ui/card'
import { Shield, Mail, Database, Users, Download, Trash2 } from 'lucide-react'

export default function PrivacyPolicyPage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-white to-blue-50">
      <div className="max-w-4xl mx-auto py-12 px-4">
        {/* Header */}
        <div className="text-center mb-8">
          <div className="flex justify-center mb-4">
            <Shield className="h-12 w-12 text-blue-600" />
          </div>
          <h1 className="text-4xl font-bold text-gray-900 mb-2">
            Privacy Policy
          </h1>
          <p className="text-gray-600">
            MIRA Workshop - Effective Date: November 18, 2025
          </p>
        </div>

        <Card className="shadow-xl">
          <CardContent className="prose prose-sm max-w-none pt-6 space-y-6">
            {/* Introduction */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Introduction</h2>
              <p className="text-gray-700 leading-relaxed">
                This Privacy Policy describes how MIRA (Modular Interoperable Research Attribution) Workshop
                (&quot;we&quot;, &quot;us&quot;, or &quot;our&quot;) collects, uses, and protects your personal information when you use our
                website and apply to participate in our workshop. We are committed to protecting your privacy
                and complying with the General Data Protection Regulation (GDPR) and other applicable data
                protection laws.
              </p>
            </section>

            {/* Data Controller */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Data Controller</h2>
              <p className="text-gray-700 leading-relaxed">
                The data controller for your personal information is SciOS, facilitated through the MIRA Workshop.
              </p>
              <div className="bg-gray-50 p-4 rounded-lg mt-3">
                <p className="text-sm text-gray-700">
                  <strong>Contact:</strong><br />
                  Email: <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">contact@scios.tech</a>
                </p>
              </div>
            </section>

            {/* Information We Collect */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <Database className="mr-2 h-6 w-6 text-blue-600" />
                Information We Collect
              </h2>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">1. Application Information</h3>
              <p className="text-gray-700 leading-relaxed mb-2">When you submit a workshop application, we collect:</p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Personal information: name, email address, organization, role/title</li>
                <li>Classification selections and custom classifications</li>
                <li>Work examples: descriptions, roles, and optional URLs</li>
                <li>Essay responses to application questions (up to 200 words each)</li>
                <li>Role-specific questionnaire responses based on your classifications</li>
                <li>Logistics information: availability confirmation, travel requirements, dietary restrictions</li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">2. Account Information (Accepted Participants Only)</h3>
              <p className="text-gray-700 leading-relaxed mb-2">If you are accepted and create an account, we collect:</p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Email address and password (encrypted)</li>
                <li>Name and organization</li>
                <li>Profile information you choose to add</li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">3. Cookies and Technical Data</h3>
              <p className="text-gray-700 leading-relaxed mb-2">We use cookies for:</p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Authentication and session management (essential cookies)</li>
                <li>Maintaining your login state</li>
              </ul>
              <p className="text-sm text-gray-600 mt-2">
                We do not use tracking, analytics, or advertising cookies.
              </p>
            </section>

            {/* How We Use Your Information */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">How We Use Your Information</h2>
              <p className="text-gray-700 leading-relaxed mb-2">We use your personal information for the following purposes:</p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Processing and reviewing workshop applications</li>
                <li>Communicating application status and decisions</li>
                <li>Facilitating the voting process among review committee members</li>
                <li>Creating participant accounts for accepted applicants</li>
                <li>Workshop logistics and coordination</li>
                <li>Sending workshop-related communications</li>
              </ul>
              <p className="text-sm text-gray-600 mt-3">
                <strong>Legal basis:</strong> Processing is based on your explicit consent (application submission)
                and our legitimate interests in organizing the workshop.
              </p>
            </section>

            {/* Data Sharing */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <Users className="mr-2 h-6 w-6 text-blue-600" />
                Who We Share Your Data With
              </h2>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">Internal Access</h3>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li>Workshop administrators and review committee members can view applications</li>
                <li>Admin voting and internal comments are visible only to administrators</li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">Third-Party Services</h3>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li><strong>Supabase:</strong> Database and authentication provider (see: <a href="https://supabase.com/privacy" target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">Supabase Privacy Policy</a>)</li>
                <li><strong>Resend:</strong> Email delivery service (see: <a href="https://resend.com/legal/privacy-policy" target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">Resend Privacy Policy</a>)</li>
                <li><strong>Vercel:</strong> Hosting provider (see: <a href="https://vercel.com/legal/privacy-policy" target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">Vercel Privacy Policy</a>)</li>
                <li><strong>Vercel Analytics (Optional):</strong> Anonymized website analytics, only if you consent (see: <a href="https://vercel.com/docs/analytics/privacy-policy" target="_blank" rel="noopener noreferrer" className="text-blue-600 hover:underline">Vercel Analytics Privacy</a>)</li>
              </ul>

              <p className="text-sm text-gray-600 mt-3">
                We do not sell, rent, or share your personal information with third parties for marketing purposes.
              </p>
            </section>

            {/* Data Retention */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Data Retention</h2>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li><strong>Pending applications:</strong> Until the application deadline + 90 days</li>
                <li><strong>Rejected applications:</strong> 90 days after decision (or immediate deletion upon request)</li>
                <li><strong>Accepted participants:</strong> Workshop completion + 2 years for archival purposes</li>
                <li><strong>Withdrawn applications:</strong> Immediately deleted upon request</li>
              </ul>
              <p className="text-gray-700 mt-3">
                You may request earlier deletion of your data at any time by contacting us.
              </p>
            </section>

            {/* Your Rights */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Your Rights Under GDPR</h2>
              <p className="text-gray-700 leading-relaxed mb-3">You have the following rights regarding your personal data:</p>

              <div className="space-y-3">
                <div className="bg-blue-50 border-l-4 border-blue-600 p-4">
                  <h4 className="font-semibold text-blue-900 mb-1 flex items-center">
                    <Download className="mr-2 h-4 w-4" />
                    Right to Access and Data Portability
                  </h4>
                  <p className="text-sm text-blue-800">
                    You can view your application status at any time using the <Link href="/status" className="underline">Check Status</Link> page.
                    You can also export your complete application data in JSON format.
                  </p>
                </div>

                <div className="bg-green-50 border-l-4 border-green-600 p-4">
                  <h4 className="font-semibold text-green-900 mb-1">Right to Rectification</h4>
                  <p className="text-sm text-green-800">
                    You can request corrections to your application data by contacting us at contact@scios.tech
                  </p>
                </div>

                <div className="bg-red-50 border-l-4 border-red-600 p-4">
                  <h4 className="font-semibold text-red-900 mb-1 flex items-center">
                    <Trash2 className="mr-2 h-4 w-4" />
                    Right to Erasure (Right to be Forgotten)
                  </h4>
                  <p className="text-sm text-red-800">
                    You can delete your application at any time through the <Link href="/status" className="underline">Check Status</Link> page
                    or by contacting us. Deletion is permanent and cannot be undone.
                  </p>
                </div>

                <div className="bg-purple-50 border-l-4 border-purple-600 p-4">
                  <h4 className="font-semibold text-purple-900 mb-1">Right to Restrict Processing</h4>
                  <p className="text-sm text-purple-800">
                    You can request to restrict processing of your data by contacting us.
                  </p>
                </div>

                <div className="bg-amber-50 border-l-4 border-amber-600 p-4">
                  <h4 className="font-semibold text-amber-900 mb-1">Right to Object</h4>
                  <p className="text-sm text-amber-800">
                    You can object to processing of your data for specific purposes by contacting us.
                  </p>
                </div>

                <div className="bg-gray-50 border-l-4 border-gray-600 p-4">
                  <h4 className="font-semibold text-gray-900 mb-1">Right to Withdraw Consent</h4>
                  <p className="text-sm text-gray-800">
                    You can withdraw your application and consent to data processing at any time.
                  </p>
                </div>
              </div>

              <p className="text-gray-700 mt-4">
                To exercise any of these rights, please contact us at <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">contact@scios.tech</a>.
                We will respond to your request within 30 days.
              </p>
            </section>

            {/* Cookies */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Cookies</h2>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">Essential Cookies (Always Active)</h3>
              <p className="text-gray-700 leading-relaxed mb-2">
                These cookies are required for the website to function properly and cannot be disabled:
              </p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1">
                <li><strong>Authentication cookies:</strong> To maintain your login session (Supabase)</li>
                <li><strong>Consent cookies:</strong> To remember your cookie preferences (localStorage)</li>
              </ul>

              <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2">Analytics Cookies (Optional - Requires Your Consent)</h3>
              <p className="text-gray-700 leading-relaxed mb-2">
                With your explicit consent, we use Vercel Analytics to understand how visitors use our website:
              </p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1 mb-3">
                <li><strong>Page views:</strong> Which pages are visited and how often</li>
                <li><strong>Geographic location:</strong> Country/region level only (not precise location)</li>
                <li><strong>Device information:</strong> Browser type and device category</li>
                <li><strong>Session duration:</strong> How long visitors spend on the site</li>
              </ul>

              <div className="bg-purple-50 border border-purple-200 rounded-lg p-4 mt-3">
                <h4 className="font-semibold text-purple-900 mb-2">Privacy-Friendly Analytics</h4>
                <p className="text-sm text-purple-800">
                  Vercel Analytics is designed to be privacy-friendly:
                </p>
                <ul className="list-disc pl-6 text-sm text-purple-800 space-y-1 mt-2">
                  <li>Data is anonymized and aggregated</li>
                  <li>No personal information is collected</li>
                  <li>No cross-site tracking</li>
                  <li>Not used for advertising purposes</li>
                  <li>You can opt out at any time through cookie preferences</li>
                </ul>
              </div>

              <p className="text-sm text-gray-600 mt-3">
                You can manage your analytics cookie preferences at any time by clearing your browser&apos;s
                localStorage or revisiting the cookie consent banner.
              </p>
            </section>

            {/* Data Security */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Data Security</h2>
              <p className="text-gray-700 leading-relaxed">
                We implement appropriate technical and organizational measures to protect your personal data:
              </p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1 mt-2">
                <li>Encryption in transit (HTTPS/TLS)</li>
                <li>Encryption at rest (database encryption)</li>
                <li>Password hashing using industry-standard algorithms</li>
                <li>Role-based access control (Row Level Security)</li>
                <li>Regular security updates and monitoring</li>
              </ul>
            </section>

            {/* International Transfers */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">International Data Transfers</h2>
              <p className="text-gray-700 leading-relaxed">
                Your data may be transferred to and processed in countries outside the European Economic Area (EEA),
                including the United States. We ensure adequate protection through:
              </p>
              <ul className="list-disc pl-6 text-gray-700 space-y-1 mt-2">
                <li>Use of services with Standard Contractual Clauses (SCCs)</li>
                <li>GDPR-compliant data processing agreements with service providers</li>
              </ul>
            </section>

            {/* Children's Privacy */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Children&apos;s Privacy</h2>
              <p className="text-gray-700 leading-relaxed">
                Our services are not directed to individuals under 18 years of age. We do not knowingly collect
                personal information from children. If you believe we have collected information from a child,
                please contact us immediately.
              </p>
            </section>

            {/* Changes to Policy */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Changes to This Policy</h2>
              <p className="text-gray-700 leading-relaxed">
                We may update this Privacy Policy from time to time. We will notify you of any material changes
                by posting the new policy on this page and updating the effective date. Your continued use of our
                services after changes constitutes acceptance of the updated policy.
              </p>
            </section>

            {/* Complaints */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3">Complaints</h2>
              <p className="text-gray-700 leading-relaxed">
                If you believe your data protection rights have been violated, you have the right to lodge a
                complaint with your local data protection authority.
              </p>
            </section>

            {/* Contact */}
            <section>
              <h2 className="text-2xl font-bold text-gray-900 mb-3 flex items-center">
                <Mail className="mr-2 h-6 w-6 text-blue-600" />
                Contact Us
              </h2>
              <p className="text-gray-700 leading-relaxed">
                If you have any questions about this Privacy Policy or our data practices, please contact us:
              </p>
              <div className="bg-blue-50 p-4 rounded-lg mt-3">
                <p className="text-gray-800">
                  <strong>Email:</strong> <a href="mailto:contact@scios.tech" className="text-blue-600 hover:underline">contact@scios.tech</a><br />
                  <strong>Subject Line:</strong> MIRA Privacy Inquiry
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
                <Link href="/status" className="text-blue-600 hover:underline">
                  Check Status
                </Link>
                <span className="text-gray-400">•</span>
                <Link href="/code-of-conduct" className="text-blue-600 hover:underline">
                  Code of Conduct
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
