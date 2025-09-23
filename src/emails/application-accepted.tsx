import {
  Body,
  Button,
  Container,
  Column,
  Head,
  Heading,
  Hr,
  Html,
  Link,
  Preview,
  Row,
  Section,
  Text,
} from '@react-email/components'
import * as React from 'react'

interface ApplicationAcceptedEmailProps {
  applicantName: string
  inviteLink: string
  workshopDates?: string
  workshopLocation?: string
}

export const ApplicationAcceptedEmail = ({
  applicantName = 'Researcher',
  inviteLink = 'https://mrna-nine.vercel.app/signup',
  workshopDates = 'May 12-15, 2026',
  workshopLocation = 'Columbia University, New York City',
}: ApplicationAcceptedEmailProps) => {
  const previewText = `Congratulations! You've been accepted to the Modular Research Attribution Workshop`

  return (
    <Html>
      <Head />
      <Preview>{previewText}</Preview>
      <Body style={main}>
        <Container style={container}>
          <Section style={header}>
            <Heading style={h1}>🎉 Congratulations, {applicantName}!</Heading>
          </Section>

          <Section style={content}>
            <Text style={paragraph}>
              We are thrilled to inform you that you have been <strong>accepted</strong> to participate in the
              Modular Research Attribution Workshop!
            </Text>

            <Text style={paragraph}>
              After careful review of your application, the selection committee was impressed by your research
              background and potential contributions to our workshop. You are one of only <strong>20 researchers</strong> selected
              from a highly competitive pool of applicants worldwide.
            </Text>

            <Section style={highlightBox}>
              <Heading as="h2" style={h2}>
                Workshop Details
              </Heading>
              <Row>
                <Column style={iconColumn}>📅</Column>
                <Column>
                  <Text style={detailText}>
                    <strong>Dates:</strong> {workshopDates}
                  </Text>
                </Column>
              </Row>
              <Row>
                <Column style={iconColumn}>📍</Column>
                <Column>
                  <Text style={detailText}>
                    <strong>Location:</strong> {workshopLocation}
                  </Text>
                </Column>
              </Row>
              <Row>
                <Column style={iconColumn}>💰</Column>
                <Column>
                  <Text style={detailText}>
                    <strong>Support:</strong> Travel stipends up to $500 available
                  </Text>
                </Column>
              </Row>
            </Section>

            <Section style={ctaSection}>
              <Heading as="h2" style={h2}>
                Next Steps
              </Heading>
              <Text style={paragraph}>
                To secure your spot, please create your participant account within the next <strong>7 days</strong>:
              </Text>
              <Button
                style={button}
                href={inviteLink}
              >
                Create Your Account →
              </Button>
              <Text style={smallText}>
                This personalized link will expire in 7 days and can only be used once.
              </Text>
            </Section>

            <Section style={infoSection}>
              <Heading as="h3" style={h3}>
                What to Expect
              </Heading>
              <Text style={paragraph}>
                Once you create your account, you&apos;ll have access to:
              </Text>
              <ul style={list}>
                <li>Detailed workshop schedule and session information</li>
                <li>Participant directory to connect with other researchers</li>
                <li>Pre-workshop reading materials and resources</li>
                <li>Logistics information including venue, travel, and accommodation</li>
                <li>Collaboration tools and discussion forums</li>
              </ul>
            </Section>

            <Hr style={hr} />

            <Text style={paragraph}>
              We look forward to your participation in shaping the future of scientific attribution and modular research.
              If you have any questions, please don&apos;t hesitate to reach out to us at{' '}
              <Link href="mailto:workshop@modularresearch.org" style={link}>
                workshop@modularresearch.org
              </Link>
              .
            </Text>

            <Text style={paragraph}>
              Warm regards,
              <br />
              <strong>The Modular Research Workshop Team</strong>
            </Text>
          </Section>

          <Section style={footer}>
            <Text style={footerText}>
              Modular Research Attribution Workshop
              <br />
              Spring 2026 • Columbia University
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
  fontSize: '20px',
  fontWeight: '600',
  lineHeight: '1.3',
  marginTop: '0',
  marginBottom: '16px',
}

const h3 = {
  color: '#374151',
  fontSize: '16px',
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

const highlightBox = {
  backgroundColor: '#f0f9ff',
  borderLeft: '4px solid #2563eb',
  borderRadius: '4px',
  padding: '16px',
  marginBottom: '24px',
  marginTop: '24px',
}

const detailText = {
  color: '#1f2937',
  fontSize: '14px',
  lineHeight: '20px',
  marginBottom: '8px',
}

const iconColumn = {
  width: '24px',
  fontSize: '18px',
  paddingRight: '12px',
  verticalAlign: 'top' as const,
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

const infoSection = {
  marginTop: '24px',
  marginBottom: '24px',
}

const list = {
  color: '#374151',
  fontSize: '14px',
  lineHeight: '24px',
  paddingLeft: '20px',
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