#!/bin/bash
# 多平台发布辅助脚本

set -e

ARTICLE=$1

if [ -z "$ARTICLE" ]; then
  echo "用法: ./publish-to-platforms.sh <文章路径>"
  echo "示例: ./publish-to-platforms.sh published/my-article.md"
  exit 1
fi

if [ ! -f "$ARTICLE" ]; then
  echo "❌ 文件不存在: $ARTICLE"
  exit 1
fi

echo "📝 多平台发布辅助工具"
echo "====================="
echo "📄 文章: $ARTICLE"
echo ""

# 1. 发布到博客（Git推送）
echo "1️⃣  发布到博客 (ec.thiki.net)"
echo "---"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
git add "$(basename "$ARTICLE")"
git commit -m "发布: $(basename "$ARTICLE" .md)"
git push
echo "✅ 博客发布成功"
echo ""

# 2. 准备微信公众号版本
echo "2️⃣  准备微信公众号版本"
echo "---"
WECHAT_VERSION="/tmp/wechat-$(basename "$ARTICLE")"
cp "$ARTICLE" "$WECHAT_VERSION"

echo "📋 文章已复制到剪贴板（Windows）"
cat "$ARTICLE" | clip.exe 2>/dev/null || cat "$ARTICLE" | pbcopy 2>/dev/null || echo "⚠️  请手动复制内容"

echo ""
echo "✅ 准备完成"
echo ""

# 3. 发布指南
echo "📚 发布指南"
echo "==========="
echo ""
echo "🟢 微信公众号："
echo "   1. 访问: https://editor.mdnice.com/"
echo "   2. 粘贴内容 (Ctrl+V)"
echo "   3. 选择主题（推荐：绿意、橙心）"
echo "   4. 点击【复制】"
echo "   5. 登录公众号后台 → 新建图文 → 粘贴 → 发布"
echo ""
echo "🔵 知乎："
echo "   1. 访问: https://www.zhihu.com/creator"
echo "   2. 写文章 → Markdown模式"
echo "   3. 粘贴内容"
echo "   4. 发布"
echo ""
echo "🟠 掘金："
echo "   1. 访问: https://juejin.cn/editor/drafts"
echo "   2. Markdown编辑器"
echo "   3. 粘贴内容"
echo "   4. 发布"
echo ""
echo "🔴 CSDN："
echo "   1. 访问: https://mp.csdn.net/mp_blog/creation/editor"
echo "   2. Markdown编辑器"
echo "   3. 粘贴内容"
echo "   4. 发布"
echo ""

# 4. 打开常用链接
echo "🌐 自动打开相关网站..."
echo ""

# Windows
if command -v cmd.exe &> /dev/null; then
  cmd.exe /c start https://editor.mdnice.com/ 2>/dev/null
  echo "✅ Markdown Nice 已打开"
fi

# macOS
if command -v open &> /dev/null; then
  open https://editor.mdnice.com/
  echo "✅ Markdown Nice 已打开"
fi

echo ""
echo "🎉 发布流程准备完成！"
echo "⏱️  预计耗时: 10-15分钟（所有平台）"

