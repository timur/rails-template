const defaultTheme = require("tailwindcss/defaultTheme");
const colors = require("tailwindcss/colors");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/controllers/**/*.rb",
    "./app/components/**/*.{rb,erb,haml,html,slim}",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./test/components/previews/**/*.rb",
  ],
  theme: {
    extend: {
      colors: {
        primary: colors.indigo,
        secondary: colors.green,
        neutral: colors.gray,
      },
      keyframes: {
        slidein: {
          from: {
            opacity: "0",
            transform: "translateY(-10px)",
          },
          to: {
            opacity: "1",
            transform: "translateY(0)",
          },
        },
        zoomin: {
          from: {
            opacity: "0",
            transform: "scale(.3)",
          },
          to: {
            opacity: "1",
            transform: "scale(1)",
          },
        },        
      },
      animation: {
        slidein: "slidein 1s ease var(--slidein-delay, 0) forwards",
        zoomin: "zoomin .3s ease-in forwards",
      },
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};
