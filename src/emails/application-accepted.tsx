import {
  Body,
  Button,
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

interface ApplicationAcceptedEmailProps {
  applicantName: string
  inviteLink: string
}

export const ApplicationAcceptedEmail = ({
  applicantName = 'Researcher',
  inviteLink = 'https://mrna-nine.vercel.app/signup',
}: ApplicationAcceptedEmailProps) => {
  const previewText = `You're invited to MIRA - June 7-11, 2026 in Ireland`

  return (
    <Html>
      <Head />
      <Preview>{previewText}</Preview>
      <Body style={main}>
        <Container style={container}>
          <Section style={header}>
            <Heading style={h1}>You&apos;re Invited to MIRA!</Heading>
          </Section>

          <Section style={content}>
            <Text style={paragraph}>
              Dear {applicantName},
            </Text>

            <Text style={paragraph}>
              We are excited to invite you to join us for the in-person MIRA workshop
              in Ireland on <strong>June 7-11, 2026</strong>!
            </Text>

            <Section style={highlightBox}>
              <Heading as="h2" style={h2}>
                Please Confirm Your Attendance
              </Heading>
              <Text style={paragraph}>
                Please confirm your availability for these dates by <strong>February 13th</strong>.
                We have a rich waitlist, and if we don&apos;t receive a response, we&apos;ll need to
                invite another person to take your place.
              </Text>
              <Text style={boxParagraph}>
                By confirming your attendance, you are committing to <strong>3 hours of pre-workshop work</strong> to
                help us prepare and make the most of our time together.
              </Text>
            </Section>

            <Section style={ctaSection}>
              <Button
                style={button}
                href={inviteLink}
              >
                Confirm Your Attendance →
              </Button>
              <Text style={smallText}>
                This personalized link will expire after 7 days.
              </Text>
            </Section>

            <Text style={paragraph}>
              Once we have attendance sorted for everyone, we will reach out again with more
              information as we get started with MIRA over the next several weeks.
            </Text>

            <Hr style={hr} />

            <Text style={paragraph}>
              If you have any questions, please don&apos;t hesitate to reach out to us at{' '}
              <Link href="mailto:contact@scios.tech" style={link}>
                contact@scios.tech
              </Link>
              .
            </Text>

            <Text style={paragraph}>
              Looking forward to meeting you in Ireland!
              <br />
              <strong>The MIRA Team</strong>
            </Text>
          </Section>

          <Section style={footer}>
            <Text style={footerText}>
              MIRA - Modular Interoperable Research Attribution
              <br />
              June 7-11, 2026 • Ireland
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
  backgroundColor: '#2563eb',
  borderRadius: '5px 5px 0 0',
}

const h1 = {
  color: '#ffffff',
  fontSize: '28px',
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

const boxParagraph = {
  color: '#374151',
  fontSize: '15px',
  lineHeight: '24px',
  marginBottom: '0',
}

const highlightBox = {
  backgroundColor: '#f0f9ff',
  borderLeft: '4px solid #2563eb',
  borderRadius: '4px',
  padding: '16px',
  marginBottom: '24px',
  marginTop: '24px',
}

const ctaSection = {
  textAlign: 'center' as const,
  marginTop: '32px',
  marginBottom: '32px',
}

const button = {
  backgroundColor: '#2563eb',
  borderRadius: '5px',
  color: '#fff',
  fontSize: '16px',
  fontWeight: '600',
  textDecoration: 'none',
  textAlign: 'center' as const,
  display: 'inline-block',
  padding: '12px 32px',
  marginTop: '12px',
  marginBottom: '12px',
}

const smallText = {
  color: '#6b7280',
  fontSize: '13px',
  lineHeight: '20px',
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

export default ApplicationAcceptedEmail
