import type {ReactNode} from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import Heading from '@theme/Heading';

import styles from '@site/src/pages/index.module.css';

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<'svg'>>;
  description: ReactNode;
};

const FeatureList: FeatureItem[] = [
  {
    title: '高性能',
    Svg: require('@site/static/img/undraw_docusaurus_mountain.svg').default,
    description: (
      <>
        基于 libvips，最快的图像处理库之一。
        使用流式处理和缓存，最大限度减少内存使用并提高速度。
      </>
    ),
  },
  {
    title: '跨平台',
    Svg: require('@site/static/img/undraw_docusaurus_tree.svg').default,
    description: (
      <>
        支持 Android、iOS、macOS、Windows 和 Linux。
        移动端和桌面端均捆绑原生库。
      </>
    ),
  },
  {
    title: '简洁的 Pipeline API',
    Svg: require('@site/static/img/undraw_docusaurus_react.svg').default,
    description: (
      <>
        流畅的链式 API，直观的图像处理体验。
        支持缩放、裁剪、旋转、模糊、锐化等 300+ 种操作。
      </>
    ),
  },
];

function Feature({title, Svg, description}: FeatureItem) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
        <Heading as="h1" className="hero__title">
          {siteConfig.title}
        </Heading>
        <p className="hero__subtitle">Flutter 和 Dart 高性能图像处理库</p>
        <div className={styles.buttons}>
          <Link
            className="button button--secondary button--lg"
            to="/docs/">
            快速开始
          </Link>
          <Link
            className="button button--outline button--lg"
            style={{marginLeft: '1rem'}}
            href="https://pub.dev/packages/libvips_ffi">
            在 pub.dev 查看
          </Link>
        </div>
      </div>
    </header>
  );
}

export default function Home(): ReactNode {
  return (
    <Layout
      title="Flutter 和 Dart 高性能图像处理库"
      description="libvips_ffi - libvips 图像处理库的 Flutter FFI 绑定。支持缩放、裁剪、旋转、模糊等 300+ 种快速跨平台图像操作。">
      <HomepageHeader />
      <main>
        <section className={styles.features}>
          <div className="container">
            <div className="row">
              {FeatureList.map((props, idx) => (
                <Feature key={idx} {...props} />
              ))}
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
