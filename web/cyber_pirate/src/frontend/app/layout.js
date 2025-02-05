import { Inter } from 'next/font/google'
import './globals.css'
import MatrixBackground from './MatrixBackground'

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  title: 'Cyber Pirate',
  description: 'Time to steal the secret flag',
}

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <MatrixBackground />
        {children}
      </body>
    </html>
  )
}
