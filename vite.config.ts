import tailwindcss from '@tailwindcss/vite';
import react from '@vitejs/plugin-react';
import path from 'path';
import {defineConfig} from 'vite';
import {historyApiPlugin} from './src/services/historyApiServerPlugin';
import {midjourneyApiPlugin} from './src/services/midjourneyApiServerPlugin';

export default defineConfig(() => {
  return {
    base: './',
    plugins: [react(), tailwindcss(), historyApiPlugin(), midjourneyApiPlugin()],
    resolve: {
      alias: {
        '@': path.resolve(__dirname, '.'),
      },
    },
    build: {
      chunkSizeWarningLimit: 2000,
      rollupOptions: {
        output: {
          manualChunks: {
            'vendor-react': ['react', 'react-dom'],
            'vendor-canvas': ['@tldraw/tldraw'],
            'vendor-data': ['xlsx', 'jszip', 'dexie'],
          },
        },
      },
    },
    server: {
      // HMR is disabled in AI Studio via DISABLE_HMR env var.
      // Do not modifyâfile watching is disabled to prevent flickering during agent edits.
      hmr: process.env.DISABLE_HMR !== 'true',
      // Disable file watching when DISABLE_HMR is true to save CPU during agent edits.
      watch: process.env.DISABLE_HMR === 'true' ? null : {},
    },
  };
});
