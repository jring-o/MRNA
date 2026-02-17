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

interface AdminMessageEmailProps {
  recipientName: string
  subject: string
  messageHtml: string
  authorName: string
  sentAt: string
  messagesUrl: string
}

export const AdminMessageEmail = ({
  recipientName = 'Participant',
  subject = 'New Message',
  messageHtml = '<p>Message content here</p>',
  authorName = 'Admin',
  sentAt = 'February 16, 2026',
  messagesUrl = 'https://mrna-nine.vercel.app/messages',
}: AdminMessageEmailProps) => {
  const previewText = `${subject} - from ${authorName}`

  return (
    <Html>
      <Head />
      <Preview>{previewText}</Preview>
      <Body style={main}>
        <Container style={container}>
          <Section style={header}>
            <Heading style={h1}>{subject}</Heading>
          </Section>

          <Section style={content}>
            <Text style={paragraph}>
              Hi {recipientName},
            </Text>

            <Text style={paragraph}>
              {authorName} sent a new message to the MIRA group:
            </Text>

            <Section style={highlightBox}>
              <div dangerouslySetInnerHTML={{ __html: messageHtml }} />
            </Section>

            <Section style={ctaSection}>
              <Button
                style={button}
                href={messagesUrl}
              >
                View on MIRA
              </Button>
            </Section>

            <Hr style={hr} />

            <Text style={paragraph}>
              If you have any questions, please reach out to us at{' '}
              <Link href="mailto:contact@scios.tech" style={link}>
                contact@scios.tech
              </Link>
              .
            </Text>

            <Text style={smallText}>
              Sent on {sentAt}
            </Text>
          </Section>

          <Section style={footer}>
            <Text style={footerText}>
              MIRA - Modular Interoperable Research Attribution
              <br />
              June 7-11, 2026 &bull; Ireland
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
  fontSize: '24px',
  fontWeight: '600',
  lineHeight: '1.3',
  margin: '0',
  textAlign: 'center' as const,
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

export default AdminMessageEmail
