import { exec } from "child_process";
import type { HookHandler } from "../../src/hooks/hooks.js";

const handler: HookHandler = async (event) => {
  // Only run on startup
  if (event.type !== "gateway" || event.action !== "startup") {
    return;
  }

  console.log("[biblemate-startup] Running startup script...");

  // Execute the bash script
  exec("~/.openclaw/scripts/startup-biblemate.sh", (error, stdout, stderr) => {
    if (error) {
      console.error(`[biblemate-startup] Execution error: ${error.message}`);
      return;
    }
    if (stderr) {
      // Some services output logs to stderr even on success, but we log it anyway
      console.warn(`[biblemate-startup] stderr: ${stderr}`);
    }
    if (stdout) {
      console.log(`[biblemate-startup] stdout: ${stdout}`);
    }
  });
};

export default handler;
