#!/bin/bash
# 本地测试部署脚本 - 模拟GitHub Actions的deploy.yml

set -e  # 遇到错误立即退出

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "SCRIPT_DIR: $SCRIPT_DIR"

QUARTZ_COPY_DIR="/c/workspaces/jo-workspaces/quartz"
PUBLISHED_DIR="$SCRIPT_DIR"
BUILD_DIR="$(dirname "$SCRIPT_DIR")/local-quartz-build"

echo "🔍 本地部署测试"
echo "================"
echo "📁 Published目录: $PUBLISHED_DIR"
echo "📁 构建目录: $BUILD_DIR"
echo ""

# 清理旧的构建目录
if [ -d "$BUILD_DIR" ]; then
  echo "🧹 清理旧的构建目录..."
  rm -rf "$BUILD_DIR"
fi

# 1. Clone Quartz
echo "📦 克隆Quartz v4.5.2, 直接复制本地Quartz目录副本"
# git clone --depth 1 https://github.com/jackyzha0/quartz.git "$BUILD_DIR"
cp -r $QUARTZ_COPY_DIR "$BUILD_DIR"
echo "✅ Quartz克隆完成"
echo ""

# 2. Install dependencies
echo "📦 安装依赖..."
cd "$BUILD_DIR"
pnpm install --prefer-offline
echo "✅ 依赖安装完成"
echo ""

# 3. Prepare content
echo "📝 准备内容..."
cd "$PUBLISHED_DIR"

# 复制配置文件
echo "  - 复制 quartz.config.ts"
cp quartz.config.ts "$BUILD_DIR/"

# 复制布局文件
if [ -f "quartz.layout.ts" ]; then
  echo "  - 复制 quartz.layout.ts"
  cp quartz.layout.ts "$BUILD_DIR/"
fi

# 复制自定义样式
if [ -f "styles/custom.scss" ]; then
  echo "  - 复制 custom.scss"
  mkdir -p "$BUILD_DIR/quartz/styles"
  cp styles/custom.scss "$BUILD_DIR/quartz/styles/"
fi

# 下载favicon
echo "  - 下载 favicon"
mkdir -p "$BUILD_DIR/quartz/static"
curl -sL -o "$BUILD_DIR/quartz/static/icon.png" \
  "https://cdn.jsdelivr.net/gh/joeaniu/images@master/2025/10/ec_1.png" || \
  echo "⚠️  Warning: Failed to download favicon"

# 清空content目录
echo "  - 清空Quartz示例内容"
rm -rf "$BUILD_DIR/content"
mkdir -p "$BUILD_DIR/content"

# 复制博客内容
echo "  - 复制博客内容"
rsync -av \
  --exclude='.git/' \
  --exclude='.github/' \
  --exclude='local-quartz-build/' \
  --exclude='quartz.config.ts' \
  --exclude='quartz.layout.ts' \
  --exclude='styles/' \
  --exclude='*.sh' \
  --exclude='README.md' \
  --exclude='github-pages-config.md' \
  --exclude='scripts-guide.md' \
  --include='*/' \
  --include='*.md' \
  --include='*.png' \
  --include='*.jpg' \
  --include='*.jpeg' \
  --include='*.gif' \
  --include='*.svg' \
  --include='CNAME' \
  --exclude='*' \
  "$PUBLISHED_DIR/" "$BUILD_DIR/content/"

echo ""
echo "=== 验证content目录内容 ==="
echo "目录结构："
find "$BUILD_DIR/content" -type d | sort
echo ""
echo "Markdown文件："
find "$BUILD_DIR/content" -name "*.md" | sort
echo ""

# 4. Build and Serve
echo "🔨 构建Quartz并启动开发服务器..."
echo "📍 预览地址: http://localhost:8080"
echo "⏹️  按 Ctrl+C 停止"
echo ""
echo "💡 提示: build --serve 会先构建，然后启动服务器并监听文件变化"
echo ""

cd "$BUILD_DIR"
node ./quartz/bootstrap-cli.mjs build --serve

