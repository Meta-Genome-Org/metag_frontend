import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  // Same output directory as Create React App, which the Dockerfile copies
  build: { outDir: 'build' },
  server: { port: 3000 },
});
