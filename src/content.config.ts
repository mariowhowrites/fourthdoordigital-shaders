import { defineCollection, z } from 'astro:content';
import { glslLoader } from './loader';

const shaderCollection = defineCollection({
  loader: glslLoader({ dir: './src/shaders' }),
});

export const collections = {
  shaders: shaderCollection,
};