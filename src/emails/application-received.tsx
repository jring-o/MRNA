import {
  Body,
  Container,
  Head,
  Heading,
  Hr,
  Html,
  Link,
  Preview,
  Section,
  Text,
} from '@react-email/components'
import * as React from 'react'

interface ApplicationReceivedEmailProps {
  applicantName: string
  applicationId: string
  submittedAt: string
}

export const ApplicationReceivedEmail = ({
  applicantName = 'Researcher',
  applicationId = 'APP-2026-001',
  submittedAt = new Date().toLocaleDateString(),
}: ApplicationReceivedEmailProps) => {
  const previewText = `Your application to MIRA has been received`

  return (
    <Html>
      <Head />
      <Preview>{previewText}</Preview>
      <Body style={main}>
        <Container style={container}>
          <Section style={header}>
            <Heading style={h1}>Application Received ✓</Heading>
          </Section>

          <Section style={content}>
            <Text style={paragraph}>
              Dear {applicantName},
            </Text>

            <Text style={paragraph}>
              Thank you for applying to <strong>MIRA, Modular Interoperable Research Attribution</strong>.
              We have successfully received your application and it is now under review.
            </Text>

            <Section style={detailsBox}>
              <Heading as="h2" style={h2}>
                Application Details
              </Heading>
              <Text style={detailText}>
                <strong>Application ID:</strong> {applicationId}
                <br />
                <strong>Submitted:</strong> {submittedAt}
                <br />
                <strong>Status:</strong> Under Review
              </Text>
            </Section>

            <Section style={timelineSection}>
              <Heading as="h2" style={h2}>
                What Happens Next?
              </Heading>
              <Text style={paragraph}>
                Our selection committee will review all applications after the deadline. Here&apos;s the timeline:
              </Text>
              <ul style={list}>
                <li><strong>Application Deadline:</strong> January 1, 2026</li>
                <li><strong>Review Period:</strong> January 1-15, 2026</li>
                <li><strong>Decisions Announced:</strong> January 15, 2026</li>
                <li><strong>Workshop Dates:</strong> June 7-11, 2026</li>
                <li><strong>Location:</strong> The Deerstone Eco Hideaway, Ireland</li>
              </ul>
            </Section>

            <Text style={paragraph}>
              You can check the status of your application at any time by visiting:{' '}
              <Link href="https://mrna-nine.vercel.app/status" style={link}>
                https://mrna-nine.vercel.app/status
              </Link>
            </Text>

            <Text style={paragraph}>
              We appreciate your interest in advancing scientific attribution methods and look forward
              to reviewing your application. All applicants will be notified of their status on January 15, 2026.
            </Text>

            <Hr style={hr} />

            <Text style={paragraph}>
              If you have any urgent questions, please contact us at{' '}
              <Link href="mailto:workshop@modularresearch.org" style={link}>
                workshop@modularresearch.org
              </Link>
              .
            </Text>

            <Text style={paragraph}>
              Best regards,
              <br />
              <strong>The MIRA Team</strong>
            </Text>
          </Section>

          <Section style={footer}>
            <Text style={footerText}>
              MIRA - Modular Interoperable Research Attribution
              <br />
              June 2026 • The Deerstone Eco Hideaway, Ireland
            </Text>
          </Section>
        </Container>
      </Body>
    </Html>
  )
}

// Styles
const main = {
  backgroundColor: '#f6f9fc',
  fontFamily: '-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Ubuntu,sans-serif',
}

const container = {
  backgroundColor: '#ffffff',
  margin: '0 auto',
  padding: '20px 0 48px',
  marginBottom: '64px',
  borderRadius: '5px',
  boxShadow: '0 1px 3px rgba(0, 0, 0, 0.12)',
}

const header = {
  padding: '24px',
  backgroundColor: '#10b981',
  borderRadius: '5px 5px 0 0',
}

const h1 = {
  color: '#ffffff',
  fontSize: '24px',
  fontWeight: '600',
  lineHeight: '1.3',
  margin: '0',
  textAlign: 'center' as const,
}

const h2 = {
  color: '#1f2937',
  fontSize: '18px',
  fontWeight: '600',
  lineHeight: '1.3',
  marginTop: '0',
  marginBottom: '12px',
}

const content = {
  padding: '24px 48px',
}

const paragraph = {
  color: '#374151',
  fontSize: '15px',
  lineHeight: '24px',
  marginBottom: '16px',
}

const detailsBox = {
  backgroundColor: '#f0fdf4',
  borderLeft: '4px solid #10b981',
  borderRadius: '4px',
  padding: '16px',
  marginBottom: '24px',
  marginTop: '24px',
}

const detailText = {
  color: '#1f2937',
  fontSize: '14px',
  lineHeight: '22px',
  marginBottom: '8px',
}

const timelineSection = {
  marginTop: '24px',
  marginBottom: '24px',
}

const list = {
  color: '#374151',
  fontSize: '14px',
  lineHeight: '24px',
  paddingLeft: '20px',
  marginTop: '8px',
}

const hr = {
  borderColor: '#e5e7eb',
  margin: '32px 0',
}

const link = {
  color: '#2563eb',
  textDecoration: 'underline',
}

const footer = {
  backgroundColor: '#f9fafb',
  padding: '24px',
  borderRadius: '0 0 5px 5px',
}

const footerText = {
  color: '#6b7280',
  fontSize: '13px',
  lineHeight: '20px',
  textAlign: 'center' as const,
  margin: '0',
}

export default ApplicationReceivedEmail