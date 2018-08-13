module.exports = {
  title: 'Econometrics',
  description: 'ECON 417 McGarvey',
  base: '/Econ-417-McGarvey/',
  head: [
    ['link', { rel: 'shortcut icon', type: "image/x-icon", href: `./favicon.ico` }]
  ],
  themeConfig: {
    nav: [
      { text: 'Home', link: '/' },
      { text: 'GitHub', link: 'https://github.com/Infinite-Actuary/Econ-417-McGarvey' }
    ],
    sidebar: [
      '/',
      '/textbooks/',
      '/cps_data/',
      '/resources/',
      '/SHAZAM/'
    ]
  }
}