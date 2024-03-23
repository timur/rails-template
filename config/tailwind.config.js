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
        scaleincenter: {
          '0%': { 
            transform: 'scale(0)',
            opacity: '1'
          },
          '100%': {
            transform: 'scale(1)',
            opacity: '1'
          }
        },
        skeletonLoading: {
          '0%': { backgroundColor: 'hsl(200, 20%, 70%)' },
          '100%': { backgroundColor: 'hsl(200, 20%, 95%)' },
        },        
      },
      animation: {
        slidein: "slidein 1s ease var(--slidein-delay, 0) forwards",
        zoomin: "zoomin .3s ease-in forwards",
        skeletonLoading: "skeletonLoading 1s linear infinite alternate",
        scaleincenter: "scaleincenter .5s cubic-bezier(0.250, 0.460, 0.450, 0.940) forwards"
      },
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
      flexGrow: {
        999999999: '999999999'
      }
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};