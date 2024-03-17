/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/views/**/*.{erb,liquid}",
    "./app/helpers/**.{rb}",
    "./app/javascript/**/*.{js,css}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
  safelist: [
    'p-3',
    'rounded-lg',
    'inline-block',
    'border-solid',
    'border-2',
    'mx-1',
    'border-emerald-200',
    'hover:bg-emerald-200'
  ]
}
