const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    "./app/components/**/*.html.slim",
    "./app/components/**/*.rb",
    "./lib/builders/**/*.rb",
    "./config/initializers/simple_form.rb",

  ],
  safelist: [
    {
      pattern: /skew-y-(1|2|3)/
    },
    {
      pattern: /-skew-y-(1|2|3)/
    },
    {
      pattern: /m(r|l)-[0-9]+/
    },
     // these are used dynamically in DefaultFormBuilder
     'sm:col-span-2', 'sm:col-span-3', 'sm:col-span-4', 'sm:col-span-5', 'sm:col-span-6',
     'sm:col-span-7', 'sm:col-span-8', 'sm:col-span-9', 'sm:col-span-10', 'sm:col-span-11',
     'sm:col-span-full'
  ],
  theme: {
    extend: {
      colors: {
        peach: {
          100: "#F8ECE5",
          200: "#F5D7C4",
          300: "#F5C19F",
          500: "#F8A66B"

        },
        ocean: {
          100: "#EDF9FA",
          200: "#A0D3D9",
          300: "#5FAAB2",
          400: "#2E8F99",
          500: "#0D7583",
          600: "#0A5E73",
          700: "#085366",
          800: "#064959",
          900: "#04374D"       
        }
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    // require('flowbite/plugin'),

    // Add a custom config for turbo-frame
    function ({ addVariant }) {
      addVariant('turbo-frame-complete', 'turbo-frame[complete]&')
    }
  ]
}
