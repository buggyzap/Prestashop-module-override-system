/** @type {import('tailwindcss').Config} */
module.exports = {
  important: "#module-override-app",
  content: ["./views/templates/**/*.tpl", "./views/js/*.js"],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('flowbite/plugin')
  ],
}
