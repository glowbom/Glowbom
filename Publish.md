## How to publish the app:

### 1. Export the project

Press the **"Export"** button on the bottom right to export the **.glowbom** project file and the source code:

[![Picture](https://user-images.githubusercontent.com/2455891/97621828-0e203c00-19e9-11eb-862a-5c299793932f.png)](https://glowbom.com/){:target="_blank" rel="noopener"}

Or say: **"Export code please."**

### 2. Replace data files

You download the data file **.glowbom** and an archive that has two folders **build-web** and **source-flutter**:

[![Picture](https://user-images.githubusercontent.com/2455891/97621832-0f516900-19e9-11eb-8e75-3bc5848e8521.png)](https://glowbom.com/){:target="_blank" rel="noopener"}

The **build-web** folder contains a ready-to-deploy web app.

The **source-flutter** folder contains the app source code that can be compiled to iOS, Android, and a web app.

Replace the **build-web/assets/assets/(preset_name).glowbom** file with your **.glowbom** file:

[![Picture](https://user-images.githubusercontent.com/2455891/97621833-0f516900-19e9-11eb-876e-a98b0d7531e0.png)](https://glowbom.com/){:target="_blank" rel="noopener"}

Replace the **source-flutter/app/assets/(preset_name).glowbom** file with your **.glowbom** file:

[![Picture](https://user-images.githubusercontent.com/2455891/97621835-0f516900-19e9-11eb-9488-a05062f45a24.png)](https://glowbom.com/){:target="_blank" rel="noopener"}

### 3. Build and Deploy

### Automatic Deployment

To build and deploy the app automatically, we reccommend using [**Codemagic**](https://codemagic.io/){:target="_blank" rel="noopener"}. With **Codemagic**, you can easily build your project and publish it to **Google Play**, **App Store** or the web.

### Manual Deployment

The **build-web** folder contains a ready-to-deploy web app that can be deployed to any hosting.

We recommend using [**Netlify**](https://www.netlify.com/products/edge/){:target="_blank" rel="noopener"} to publish the web app. It allows you to drag & drop the web app folder directly to the dashboard. The web app deploys automatically, and you will get the app link shortly after that. Optionally, you will be able to connect the web app with the custom domain or subdomain.

Create an account on [**Netlify**](https://www.netlify.com/products/edge/){:target="_blank" rel="noopener"} to get started.

### Mobile Apps

To build the app for **iOS** or **Android** manually, you need to install [**Flutter**](https://flutter.dev/docs/get-started/install){:target="_blank" rel="noopener"}, a software development kit created by **Google**. The **source-flutter** folder contains the **Flutter** project that can be compiled to **iOS**, **Android**, and a web app.
