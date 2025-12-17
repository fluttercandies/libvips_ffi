import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

const config: Config = {
  title: 'libvips_ffi',
  tagline: 'High-performance image processing for Flutter & Dart',
  favicon: 'img/favicon.ico',

  future: {
    v4: true,
  },

  url: 'https://fluttercandies.github.io',
  baseUrl: '/libvips_ffi/',

  organizationName: 'fluttercandies',
  projectName: 'libvips_ffi',

  onBrokenLinks: 'throw',

  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'zh-Hans'],
    localeConfigs: {
      en: {
        label: 'English',
        htmlLang: 'en-US',
      },
      'zh-Hans': {
        label: '简体中文',
        htmlLang: 'zh-Hans',
      },
    },
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          editUrl: 'https://github.com/fluttercandies/libvips_ffi/tree/main/docs/website/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    // Replace with your project's social card
    image: 'img/docusaurus-social-card.jpg',
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'libvips_ffi',
      logo: {
        alt: 'libvips_ffi Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'tutorialSidebar',
          position: 'left',
          label: 'Docs',
        },
        {
          href: 'https://pub.dev/packages/libvips_ffi',
          label: 'pub.dev',
          position: 'right',
        },
        {
          href: 'https://github.com/fluttercandies/libvips_ffi',
          label: 'GitHub',
          position: 'right',
        },
        {
          type: 'localeDropdown',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            {
              label: 'Getting Started',
              to: '/docs/',
            },
            {
              label: 'Packages',
              to: '/docs/packages/overview',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'GitHub Discussions',
              href: 'https://github.com/fluttercandies/libvips_ffi/discussions',
            },
            {
              label: 'FlutterCandies',
              href: 'https://github.com/fluttercandies',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/fluttercandies/libvips_ffi',
            },
            {
              label: 'pub.dev',
              href: 'https://pub.dev/packages/libvips_ffi',
            },
            {
              label: 'libvips',
              href: 'https://www.libvips.org/',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} FlutterCandies. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['dart', 'bash', 'yaml'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
