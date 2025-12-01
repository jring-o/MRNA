import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import { AuthHeader } from "@/components/layout/auth-header";
import { CookieConsent } from "@/components/cookie-consent";
import { ConditionalAnalytics } from "@/components/conditional-analytics";
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "MIRA 2026 - Modular Interoperable Research Attribution",
  description: "Catalyzing Modular Interoperable Research Attribution - A workshop to design and prototype interoperable frameworks for modular research attribution. June 7-11, 2026 in Ireland.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <div className="relative flex min-h-screen flex-col">
          <AuthHeader />
          <main className="flex-1">{children}</main>
        </div>
        <CookieConsent />
        <ConditionalAnalytics />
      </body>
    </html>
  );
}
