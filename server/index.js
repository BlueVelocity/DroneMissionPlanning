import express from "express";
import path from "path";
import { fileURLToPath } from 'url';
const app = express()

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const distPath = path.join(__dirname, 'dist');
app.use(express.static(distPath));

app.use((res, req, next) => {
  console.log("Requested path ")
})


// Fallback route for SPA routing
// This ensures that client-side routes work correctly
app.get('*', (req, res) => {
  res.sendFile(path.join(distPath, 'index.html'));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Serving static files from: ${distPath}`);
});
