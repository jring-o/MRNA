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

interface ApplicationRejectedEmailProps {
  applicantName: string
}

export const ApplicationRejectedEmail = ({
  applicantName = 'Researcher',
}: ApplicationRejectedEmailProps) => {
  const previewText = `Update on your Modular Research Attribution Workshop application`

  return (
    <Html>
      <Head />
      <Preview>{previewText}</Preview>
      <Body style={main}>
        <Container style={container}>
          <Section style={header}>
            <Heading style={h1}>Modular Research Attribution Workshop</Heading>
          </Section>

          <Section style={content}>
            <Text style={paragraph}>
              Dear {applicantName},
            </Text>

            <Text style={paragraph}>
              Thank you for your interest in the Modular Research Attribution Workshop and for taking the time
              to submit your application. We were impressed by the quality and diversity of applications we received
              from researchers around the world.
            </Text>

            <Text style={paragraph}>
              After careful consideration by our selection committee, we regret to inform you that we are unable
              to offer you a place in the Spring 2026 workshop. With only 20 spots available and hundreds of
              strong applications, the selection process was extremely competitive.
            </Text>

            <Text style={paragraph}>
              Please know that this decision does not reflect on your qualifications or potential as a researcher.
              The committee had to make difficult choices based on factors including research focus alignment,
              geographic diversity, and specific workshop objectives.
            </Text>

            <Section style={encouragementBox}>
              <Heading as="h2" style={h2}>
                Stay Connected
              </Heading>
              <Text style={paragraph}>
                We encourage you to:
              </Text>
              <ul style={list}>
                <li>Follow our progress and workshop outcomes on our website</li>
                <li>Consider applying for future workshops or related opportunities</li>
                <li>Join our mailing list for updates on modular research initiatives</li>
                <li>Connect with the broader modular research community online</li>
              </ul>
            </Section>

            <Text style={paragraph}>
              We genuinely appreciate your interest in advancing scientific attribution methods and hope you
              will continue to engage with this important work. The ideas and perspectives shared in your
              application contribute to our understanding of the challenges and opportunities in this field.
            </Text>

            <Hr style={hr} />

            <Text style={paragraph}>
              If you have any questions, please feel free to contact us at{' '}
              <Link href="mailto:workshop@modularresearch.org" style={link}>
                workshop@modularresearch.org
              </Link>
              .
            </Text>

            <Text style={paragraph}>
              Best wishes for your continued research,
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
  backgroundColor: '#6b7280',
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

const encouragementBox = {
  backgroundColor: '#f9fafb',
  borderLeft: '4px solid #6b7280',
  borderRadius: '4px',
  padding: '16px',
  marginBottom: '24px',
  marginTop: '24px',
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

export default ApplicationRejectedEmail