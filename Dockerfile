
FROM public.ecr.aws/lambda/nodejs@sha256:84db0b08e2ff9909b37588186427957eec2c4dac13853bcf4e394418cc7b2c2f

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
