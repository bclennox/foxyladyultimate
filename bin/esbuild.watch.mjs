#!/usr/bin/env node

import * as esbuild from "esbuild";
import config from "./../config/esbuild.config.mjs";

const context = await esbuild.context(config);
await context.watch();
