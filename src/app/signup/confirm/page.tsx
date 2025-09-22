export default function ConfirmSignupPage() {
  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8 text-center">
        <div>
          <h2 className="mt-6 text-3xl font-bold text-gray-900">
            Check your email!
          </h2>
          <p className="mt-2 text-sm text-gray-600">
            We've sent you a confirmation link to verify your email address.
          </p>
          <p className="mt-4 text-sm text-gray-600">
            Once confirmed, you'll be able to log in and access the workshop platform.
          </p>
        </div>
      </div>
    </div>
  )
}