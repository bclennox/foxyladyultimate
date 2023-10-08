#!/usr/bin/env node

import * as esbuild from "esbuild";
import config from "./../config/esbuild.config.mjs";

await esbuild.build(config);
