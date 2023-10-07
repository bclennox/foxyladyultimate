import { sassPlugin } from "esbuild-sass-plugin";

const config = {
  entryPoints: ["app/javascript/application.js"],
  nodePaths: ["app/javascript"],
  bundle: true,
  sourcemap: true,
  minify: true,
  platform: "browser",
  outdir: "app/assets/builds",
  resolveExtensions: [".js", ".scss"],
  plugins: [
    sassPlugin()
  ],
  loader: {
    ".woff": "file",
    ".woff2": "file"
  }
};

export default config;
