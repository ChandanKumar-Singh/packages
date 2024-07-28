# Create directories
$directories = @(
    "src/controllers",
    "src/middlewares",
    "src/models",
    "src/routes",
    "src/services",
    "src/utils",
    "config",
    "logs",
    "tests"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Path $dir -Force
}

# Create files
$files = @(
    "src/controllers/authController.mjs",
    "src/controllers/socketController.mjs",
    "src/middlewares/authMiddleware.mjs",
    "src/models/userModel.mjs",
    "src/routes/authRoutes.mjs",
    "src/routes/socketRoutes.mjs",
    "src/services/authService.mjs",
    "src/utils/jwtUtils.mjs",
    "src/utils/socketUtils.mjs",
    "server.mjs",
    ".env",
    ".gitignore",
    "package.json",
    "README.md",
    "config/config.mjs",
    "tests/auth.test.mjs",
    "tests/socket.test.mjs"
)

foreach ($file in $files) {
    New-Item -ItemType File -Path $file -Force
}
