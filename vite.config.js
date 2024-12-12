import { defineConfig } from "vite";
import laravel from "laravel-vite-plugin";

export default defineConfig({
    server: {
        host: "0.0.0.0", // Make sure it's accessible outside the container
        port: 5173,
        hmr: {
            protocol: "ws", // use ws for hot-reloading (adjust if necessary)
            host: "localhost", // Or the IP of your Docker container if needed
        },
    },
    plugins: [
        laravel({
            input: ["resources/css/app.css", "resources/js/app.js"],
            refresh: true,
        }),
    ],
});
