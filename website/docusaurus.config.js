// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer').themes.github;
const darkCodeTheme = require('prism-react-renderer').themes.dracula;

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'Power BI Business Analytics',
  tagline: 'หลักสูตรเข้มข้น 12 ชั่วโมง - เน้นการใช้งานเชิงธุรกิจจริง',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://your-docusaurus-site.com',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployments, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'your-org', // Usually your GitHub org/user name.
  projectName: 'power-bi-business-analytics-course', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'th',
    locales: ['th', 'en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl: 'https://github.com/your-org/power-bi-business-analytics-course/tree/main/website/',
          routeBasePath: '/', // Serve the docs at the site's root
        },
        blog: false, // Disable blog
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: 'img/docusaurus-social-card.jpg',
      navbar: {
        title: 'Power BI Business Analytics',
        logo: {
          alt: 'Power BI Logo',
          src: 'img/Logo-9Expert.png',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'tutorialSidebar',
            position: 'left',
            label: 'หลักสูตร',
          },
          {
            href: 'https://github.com/your-org/power-bi-business-analytics-course',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'หลักสูตร',
            items: [
              {
                label: 'Module 1: Business Intelligence Overview',
                to: '/modules/01-foundation/01-business-intelligence-overview',
              },
              {
                label: 'Module 2: AdventureWorks OLTP',
                to: '/modules/01-foundation/02-data-sources-adventureworks',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/your-org/power-bi-business-analytics-course',
              },
              {
                label: 'Issues',
                href: 'https://github.com/your-org/power-bi-business-analytics-course/issues',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Power BI Business Analytics Course. Built with Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
        additionalLanguages: ['powershell', 'dax', 'm'],
      },
    }),
};

module.exports = config;
