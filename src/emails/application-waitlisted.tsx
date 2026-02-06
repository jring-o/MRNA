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

interface ApplicationWaitlistedEmailProps {
  applicantName: string
}

export const ApplicationWaitlistedEmail = ({
  applicantName = 'Researcher',
}: ApplicationWaitlistedEmailProps) => {
  const previewText = `Update on your MIRA application`

  return (
    <Html>
      <Head />
      <Preview>{previewText}</Preview>
      <Body style={main}>
        <Container style={container}>
          <Section style={header}>
            <Heading style={h1}>MIRA Application Update</Heading>
          </Section>

          <Section style={content}>
            <Text style={paragraph}>
              Dear {applicantName},
            </Text>

            <Text style={paragraph}>
              Thank you for applying to MIRA!
            </Text>

            <Text style={paragraph}>
              We genuinely loved your application, your experience, and your ideas, and would love
              to work with you. Unfortunately, with limited spots available, we couldn&apos;t include
              everyone in the in-person workshop.
            </Text>

            <Section style={waitlistBox}>
              <Heading as="h2" style={h2}>
                You&apos;re on the Waitlist
              </Heading>
              <Text style={boxParagraph}>
                We have placed you on our waitlist and will let you know if anything changes
                within the next two weeks.
              </Text>
            </Section>

            <Text style={paragraph}>
              Either way, we&apos;ll keep you in the loop regarding workshop development and activities.
              We hope you&apos;ll join us in our quest to modularize the scientific endeavor over the
              years to come.
            </Text>

            <Hr style={hr} />

            <Text style={paragraph}>
              If you have any questions, please feel free to contact us at{' '}
              <Link href="mailto:contact@scios.tech" style={link}>
                contact@scios.tech
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
  backgroundColor: '#d97706',
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
  color: '#92400e',
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

const waitlistBox = {
  backgroundColor: '#fffbeb',
  borderLeft: '4px solid #d97706',
  borderRadius: '4px',
  padding: '16px',
  marginBottom: '24px',
  marginTop: '24px',
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

export default ApplicationWaitlistedEmail
