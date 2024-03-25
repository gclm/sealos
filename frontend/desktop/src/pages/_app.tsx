import { theme } from '@/styles/chakraTheme';
import '@/styles/globals.scss';
import { getCookie } from '@/utils/cookieUtils';
import { ChakraProvider } from '@chakra-ui/react';
import { Hydrate, QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { appWithTranslation, useTranslation } from 'next-i18next';
import type { AppProps } from 'next/app';
import Router from 'next/router';
import NProgress from 'nprogress';
import 'nprogress/nprogress.css';
import '@sealos/driver/src/driver.css';
import { useEffect } from 'react';
import { useSystemConfigStore } from '@/stores/config';
import { useGlobalStore } from '@/stores/global';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      // refetchOnWindowFocus: false,
      retry: false
      // cacheTime: 0
    }
  }
});

//Binding events.
Router.events.on('routeChangeStart', () => NProgress.start());
Router.events.on('routeChangeComplete', () => NProgress.done());
Router.events.on('routeChangeError', () => NProgress.done());

const App = ({ Component, pageProps }: AppProps) => {
  const { i18n } = useTranslation();
  const { initSystemConfig } = useSystemConfigStore();
  const { initSystemEnv } = useGlobalStore();

  useEffect(() => {
    initSystemConfig();
    initSystemEnv();
  }, []);

  useEffect(() => {
    const lang = getCookie('NEXT_LOCALE');
    i18n?.changeLanguage?.(lang);
  }, [i18n]);

  return (
    <QueryClientProvider client={queryClient}>
      <Hydrate state={pageProps.dehydratedState}>
        <ChakraProvider theme={theme}>
          <Component {...pageProps} />
        </ChakraProvider>
      </Hydrate>
    </QueryClientProvider>
  );
};
export default appWithTranslation(App);
