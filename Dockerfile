
FROM public.ecr.aws/lambda/nodejs@sha256:8463538be5cb8b8b829db360b5a59b2f4344ebc53edc837459f043fad6cf19a0

# Maybe some of these are not needed. I just copied them from https://github.com/umihico/docker-selenium-lambda
RUN dnf update -y && \
  dnf install -y atk cups-libs gtk3 libXcomposite alsa-lib \
  libXcursor libXdamage libXext libXi libXrandr libXScrnSaver \
  libXtst pango at-spi2-atk libXt xorg-x11-server-Xvfb \
  xorg-x11-xauth dbus-glib dbus-glib-devel nss mesa-libgbm

# To avoid 'Executable doesn't exist at /home/sbx_user1051/.cache/ms-playwright/chromium-1097/chrome-linux/chrome'
ENV PLAYWRIGHT_BROWSERS_PATH=0

COPY package*.json ./
RUN npm install && \
  npx playwright install

COPY index.js ./

CMD [ "index.handler" ]
