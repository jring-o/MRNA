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

interface AdminNewApplicationEmailProps {
  applicantName: string
  applicantEmail: string
  organization: string
  submittedAt: string
  applicationId: string
  reviewLink: string
}

export const AdminNewApplicationEmail = ({
  applicantName = 'John Doe',
  applicantEmail = 'john@example.com',
  organization = 'MIT',
  submittedAt = new Date().toLocaleString(),
  applicationId = 'APP-2026-001',
  reviewLink = 'https://mrna-nine.vercel.app/admin/applications',
}: AdminNewApplicationEmailProps) => {
  const previewText = `New workshop application from ${applicantName} (${organization})`

  return (
    <Html>
      <Head />
      <Preview>{previewText}</Preview>
      <Body style={main}>
        <Container style={container}>
          <Section style={header}>
            <Heading style={h1}>🆕 New Application Received</Heading>
          </Section>

          <Section style={content}>
            <Text style={paragraph}>
              A new application has been submitted for MIRA, Modular Interoperable Research Attribution.
            </Text>

            <Section style={applicantBox}>
              <Heading as="h2" style={h2}>
                Applicant Information
              </Heading>
              <Row style={infoRow}>
                <Column style={labelColumn}>Name:</Column>
                <Column style={valueColumn}>{applicantName}</Column>
              </Row>
              <Row style={infoRow}>
                <Column style={labelColumn}>Email:</Column>
                <Column style={valueColumn}>
                  <Link href={`mailto:${applicantEmail}`} style={link}>
                    {applicantEmail}
                  </Link>
                </Column>
              </Row>
              <Row style={infoRow}>
                <Column style={labelColumn}>Organization:</Column>
                <Column style={valueColumn}>{organization}</Column>
              </Row>
              <Row style={infoRow}>
                <Column style={labelColumn}>Application ID:</Column>
                <Column style={valueColumn}>{applicationId}</Column>
              </Row>
              <Row style={infoRow}>
                <Column style={labelColumn}>Submitted:</Column>
                <Column style={valueColumn}>{submittedAt}</Column>
              </Row>
            </Section>

            <Section style={ctaSection}>
              <Text style={paragraph}>
                Review this application and provide your feedback:
              </Text>
              <Button style={button} href={reviewLink}>
                Review Application →
              </Button>
            </Section>

            <Section style={statsBox}>
              <Heading as="h3" style={h3}>
                Current Application Stats
              </Heading>
              <Text style={statsText}>
                This brings the total number of applications to review.
                Remember, we&apos;re selecting 20 participants for the workshop.
              </Text>
            </Section>

            <Hr style={hr} />

            <Text style={smallText}>
              This is an automated notification. To manage your email preferences, visit your admin settings.
            </Text>
          </Section>

          <Section style={footer}>
            <Text style={footerText}>
              MIRA Admin
              <br />
              <Link href="https://mrna-nine.vercel.app/admin" style={footerLink}>
                Go to Admin Dashboard
              </Link>
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
  padding: '20px',
  backgroundColor: '#7c3aed',
  borderRadius: '5px 5px 0 0',
}

const h1 = {
  color: '#ffffff',
  fontSize: '22px',
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

const applicantBox = {
  backgroundColor: '#faf5ff',
  borderLeft: '4px solid #7c3aed',
  borderRadius: '4px',
  padding: '16px',
  marginBottom: '24px',
  marginTop: '24px',
}

const infoRow = {
  marginBottom: '8px',
}

const labelColumn = {
  width: '140px',
  fontSize: '14px',
  fontWeight: '600',
  color: '#6b7280',
  verticalAlign: 'top' as const,
}

const valueColumn = {
  fontSize: '14px',
  color: '#1f2937',
  verticalAlign: 'top' as const,
}

const ctaSection = {
  textAlign: 'center' as const,
  marginTop: '28px',
  marginBottom: '28px',
}

const button = {
  backgroundColor: '#7c3aed',
  borderRadius: '5px',
  color: '#fff',
  fontSize: '16px',
  fontWeight: '600',
  textDecoration: 'none',
  textAlign: 'center' as const,
  display: 'inline-block',
  padding: '12px 32px',
}

const statsBox = {
  backgroundColor: '#f9fafb',
  borderRadius: '4px',
  padding: '16px',
  marginTop: '24px',
}

const statsText = {
  color: '#374151',
  fontSize: '14px',
  lineHeight: '22px',
  margin: '0',
}

const smallText = {
  color: '#6b7280',
  fontSize: '13px',
  lineHeight: '20px',
  marginTop: '8px',
}

const hr = {
  borderColor: '#e5e7eb',
  margin: '24px 0',
}

const link = {
  color: '#7c3aed',
  textDecoration: 'underline',
}

const footer = {
  backgroundColor: '#f9fafb',
  padding: '20px',
  borderRadius: '0 0 5px 5px',
}

const footerText = {
  color: '#6b7280',
  fontSize: '13px',
  lineHeight: '20px',
  textAlign: 'center' as const,
  margin: '0',
}

const footerLink = {
  color: '#7c3aed',
  textDecoration: 'underline',
  fontSize: '13px',
}

export default AdminNewApplicationEmail