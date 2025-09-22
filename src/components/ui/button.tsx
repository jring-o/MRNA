import * as React from 'react'
import { cn } from '@/lib/utils'

interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost'
  size?: 'sm' | 'md' | 'lg'
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = 'primary', size = 'md', asChild = false, children, ...props }, ref) => {
    const baseClasses = 'inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-workshop-primary focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50'

    const variantClasses = {
      primary: 'bg-workshop-primary text-white hover:bg-workshop-accent',
      secondary: 'bg-workshop-secondary text-white hover:bg-workshop-primary',
      outline: 'border border-gray-300 bg-transparent hover:bg-gray-100',
      ghost: 'hover:bg-gray-100',
    }

    const sizeClasses = {
      sm: 'h-8 px-3 text-sm',
      md: 'h-10 px-4',
      lg: 'h-12 px-6 text-lg',
    }

    const classes = cn(
      baseClasses,
      variantClasses[variant],
      sizeClasses[size],
      className
    )

    // If asChild is true, we'll pass the className to the child element
    if (asChild && React.isValidElement(children)) {
      return React.cloneElement(children as any, {
        className: cn((children as any).props.className, classes),
        ref
      })
    }

    return (
      <button
        className={classes}
        ref={ref}
        {...props}
      >
        {children}
      </button>
    )
  }
)

Button.displayName = 'Button'

export { Button }