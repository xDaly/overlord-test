import { existsSync } from "node:fs"
import path from "node:path"

import type { NextConfig } from "next"

const rootEnv = path.resolve(process.cwd(), "..", ".env")
if (existsSync(rootEnv)) process.loadEnvFile(rootEnv)

const nextConfig: NextConfig = {}

export default nextConfig
