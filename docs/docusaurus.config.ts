import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  // TODO: サイト名を決めてください
  title: 'mastodon_client',
  tagline: 'A pure Dart Mastodon API client library',
  favicon: 'img/favicon.ico',

  future: {
    v4: true,
  },

  // TODO: GitHub Pages の URL を確認してください
  // ユーザーサイト（<user>.github.io）の場合は baseUrl: '/'
  // プロジェクトサイトの場合は baseUrl: '/mastodon_client/'
  url: 'https://librarylibrarian.github.io',
  baseUrl: '/mastodon_client/',

  organizationName: 'LibraryLibrarian',
  projectName: 'mastodon_client',

  onBrokenLinks: 'throw',

  markdown: {
    hooks: {
      onBrokenMarkdownLinks: 'warn',
    },
  },

  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'ja'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          routeBasePath: '/',
          editUrl:
            'https://github.com/LibraryLibrarian/mastodon_client/tree/main/docs/',
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'mastodon_client',
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'docsSidebar',
          position: 'left',
          label: 'Docs',
        },
        {
          type: 'localeDropdown',
          position: 'right',
        },
        {
          href: 'https://github.com/LibraryLibrarian/mastodon_client',
          label: 'GitHub',
          position: 'right',
        },
        {
          href: 'https://pub.dev/packages/mastodon_client',
          label: 'pub.dev',
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
              to: '/',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/LibraryLibrarian/mastodon_client',
            },
            {
              label: 'pub.dev',
              href: 'https://pub.dev/packages/mastodon_client',
            },
          ],
        },
      ],
      copyright: `Copyright \u00a9 ${new Date().getFullYear()} LibraryLibrarian. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['dart', 'yaml', 'bash'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
