import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
    plugins: [react()],
    build: {
        rollupOptions: {
            output: {
                manualChunks(id) {
                    if (!id.includes('node_modules')) {
                        return;
                    }

                    if (id.includes('react') || id.includes('scheduler')) {
                        return 'react-vendor';
                    }

                    if (id.includes('recharts') || id.includes('d3-')) {
                        return 'charts-vendor';
                    }

                    if (id.includes('@tanstack/react-query')) {
                        return 'query-vendor';
                    }

                    if (id.includes('date-fns')) {
                        return 'date-vendor';
                    }

                    return 'vendor';
                },
            },
        },
    },
    resolve: {
        alias: {
            '@': path.resolve(__dirname, './src'),
        },
    },
    server: {
        port: 3000,
        proxy: {
            '/api': {
                target: 'http://localhost:3001',
                changeOrigin: true,
            },
        },
    },
});
