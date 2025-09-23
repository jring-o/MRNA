// Test script to verify Resend email configuration
// Run with: node test-email.js

const RESEND_API_KEY = 're_4eaMSjma_8FMnHWbgC8doU59ZpF4RN6fv';

async function testEmail() {
  try {
    console.log('Testing Resend email configuration...\n');

    const response = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        from: 'Modular Research <onboarding@resend.dev>',
        to: ['jringo303@gmail.com'],
        subject: 'Test Email - Workshop Application System',
        html: `
          <h2>Test Email Successful!</h2>
          <p>This is a test email from your Modular Research Workshop application system.</p>
          <p>If you received this email, your Resend configuration is working correctly.</p>
          <p>The application confirmation emails should now be delivered successfully.</p>
        `,
      }),
    });

    const data = await response.json();

    if (response.ok) {
      console.log('✅ Email sent successfully!');
      console.log('Email ID:', data.id);
      console.log('\nCheck jringo303@gmail.com inbox for the test email.');
    } else {
      console.error('❌ Failed to send email:', data);
    }
  } catch (error) {
    console.error('❌ Error:', error);
  }
}

testEmail();