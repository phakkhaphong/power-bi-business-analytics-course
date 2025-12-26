/**
 * Creating a sidebar enables you to:
 - create an ordered group of docs
 - render a sidebar for each doc of that group
 - provide next/previous navigation

 The sidebars can be generated from the filesystem, or explicitly defined here.

 Create as many sidebars as you need.
 */

// @ts-check

/** @type {import('@docusaurus/plugin-content-docs').SidebarsConfig} */
const sidebars = {
  // By default, Docusaurus generates a sidebar from the docs folder structure
  tutorialSidebar: [
      {
        type: 'category',
        label: '📚 ภาพรวมหลักสูตร',
        items: [
          'intro',
          'learning-path',
          'docs/course-context',
        ],
      },
    {
      type: 'category',
      label: '🏗️ Foundation & Data Engineering (3 ชั่วโมง)',
      items: [
        'modules/01-foundation/01-business-intelligence-overview/README',
        'modules/01-foundation/02-data-sources-adventureworks/README',
        'modules/01-foundation/03-power-query-transformation/README',
      ],
    },
    {
      type: 'category',
      label: '📊 Analytics & Visualizations (4 ชั่วโมง)',
      items: [
        'modules/02-analytics/04-sales-analytics/README',
        'modules/02-analytics/05-customer-analytics/README',
        'modules/02-analytics/06-product-analytics/README',
      ],
    },
    {
      type: 'category',
      label: '💡 DAX & Advanced Analytics (3 ชั่วโมง)',
      items: [
        'modules/03-dax/07-dax-business-intelligence/README',
        'modules/03-dax/08-advanced-analytics-ai/README',
      ],
    },
    {
      type: 'category',
      label: '🌐 Enterprise & Deployment (2 ชั่วโมง)',
      items: [
        'modules/04-enterprise/09-service-collaboration/README',
        'modules/04-enterprise/10-enterprise-deployment/README',
      ],
    },
    {
      type: 'category',
      label: '📖 เอกสารประกอบ',
      items: [
        'docs/faq',
        'docs/troubleshooting',
      ],
    },
      {
        type: 'category',
        label: '🛠️ แบบฝึกหัด',
        items: [
          'exercises/01-enterprise-bi-migration',
        ],
      },
  ],
};

module.exports = sidebars;
