import type { Loader, LoaderContext } from "astro/loaders";
import { z } from "astro:content";
import fs from 'node:fs';

export function glslLoader(options: { dir: string }): Loader {
  return {
    name: 'glsl-loader',
    load: async (context: LoaderContext): Promise<void> => {
      const files = fs.readdirSync(options.dir);
      files.forEach((file) => {
        const filePath = `${options.dir}/${file}`;
        const code = fs.readFileSync(filePath, 'utf-8');
        context.store.set({
          id: file,
          data: {
            slug: file,
            code,
          },
          filePath,
        });
      });

      context.watcher?.add(options.dir);  
      context.watcher?.on('change', (fullFilePath) => {
        const fileName = fullFilePath.split('/').pop()!;
        const filePath = `${options.dir}/${fileName}`;

        if (fileName.endsWith('.glsl')) {
          const code = fs.readFileSync(filePath, 'utf-8');
          context.store.set({
            id: fileName,
            data: {
              slug: fileName,
              code,
            },
            filePath,
          });
        }
      });
    },
    schema: z.object({
      slug: z.string(),
      code: z.string(),
    }),
  };
}

// loader: () => {
//   const files = fs.readdirSync('./src/shaders');
//   return files.map((file) => ({
//     id: file,
//     slug: file,
//     code: fs.readFileSync(`./src/shaders/${file}`, 'utf-8'),
//   }));
// },