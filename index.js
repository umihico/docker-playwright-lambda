const playwright = require("playwright");

exports.handler = async () => {
  const browser = await playwright.chromium.launch({
    headless: true,
    args: [
      // Maybe some of these are not needed. I just copied them from https://github.com/umihico/docker-selenium-lambda
      "--no-sandbox",
      "--disable-gpu",
      "--window-size=1280x1696",
      "--single-process",
      "--disable-dev-shm-usage",
      "--disable-dev-tools",
      "--no-zygote",
    ],
  });
  const page = await browser.newPage();
  await page.goto("http://example.com");
  const textContent = await page.textContent("body");
  await browser.close();
  return textContent;
};

// Run the function if you want to test it locally: `npm run demo`
if (require.main === module) {
  (async () => {
    console.log(await exports.handler());
  })();
}
