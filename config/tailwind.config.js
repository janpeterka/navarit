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
