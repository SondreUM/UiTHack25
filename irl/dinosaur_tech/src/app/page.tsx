// app/page.tsx
'use client'
import MorseVisualizer from '@/components/morse-visualizer'

export default function Home() {
  return (
    <main className="p-8">
      <MorseVisualizer />
    </main>
  )
}