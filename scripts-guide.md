# 脚本使用指南

本目录包含两个辅助脚本，帮助你管理博客发布流程。

---

## 📁 脚本位置

```
published/
├── publish-to-platforms.sh   # 多平台发布辅助
├── test-deploy-local.sh       # 本地部署测试
└── ...其他文件
```

---

## 🚀 publish-to-platforms.sh

### 功能

- ✅ 自动提交并推送到GitHub（触发博客部署）
- ✅ 复制文章内容到剪贴板
- ✅ 自动打开Markdown Nice编辑器
- ✅ 显示各平台发布指南

### 使用方法

```bash
cd published
chmod +x publish-to-platforms.sh
./publish-to-platforms.sh my-article.md
```

### 工作流程

1. **自动部署到博客**
   - 提交文章到Git
   - 推送触发GitHub Actions
   - 2-3分钟后博客自动更新

2. **准备多平台发布**
   - 复制文章到剪贴板
   - 自动打开Markdown Nice
   - 显示各平台发布指南

3. **手动发布到其他平台**
   - 微信公众号：https://editor.mdnice.com/
   - 知乎：https://www.zhihu.com/creator
   - 掘金：https://juejin.cn/editor/drafts
   - CSDN：https://mp.csdn.net/mp_blog/creation/editor

### 预计耗时

- 博客自动部署：2-3分钟（等待）
- 微信公众号：3-5分钟（手动）
- 其他平台：各2-3分钟（手动）
- **总计**：约15分钟（所有平台）

---

## 🧪 test-deploy-local.sh

### 功能

- ✅ 完整模拟GitHub Actions部署流程
- ✅ 在本地验证配置和内容
- ✅ 实时预览构建结果
- ✅ 调试部署问题

### 使用方法

```bash
cd published
chmod +x test-deploy-local.sh
./test-deploy-local.sh
```

### 工作流程

1. **复制本地Quartz**（需要预先安装）
2. **安装依赖**（pnpm install）
3. **准备内容**：
   - 复制配置文件（quartz.config.ts、quartz.layout.ts）
   - 复制自定义样式（styles/custom.scss）
   - 下载favicon
   - 复制博客内容（排除不需要的文件）
4. **验证内容**：显示目录结构和文件列表
5. **构建并启动服务器**：http://localhost:8080

### 何时使用

**在推送到GitHub之前使用，验证**：
- ✅ 配置文件是否正确
- ✅ 内容是否完整
- ✅ 布局是否正常
- ✅ 样式是否生效
- ✅ 是否有意外文件（如quartz-build）

### 依赖

需要在本地安装Quartz：
```bash
cd /c/workspaces/jo-workspaces
git clone https://github.com/jackyzha0/quartz.git
cd quartz
pnpm install
```

脚本会复制这个本地Quartz副本进行测试。

---

## 📋 完整发布流程示例

### 发布新文章

```bash
# 1. 在Obsidian编写完成
# 位置：writing/my-new-article.md

# 2. 移动到published
mv ../writing/my-new-article.md .

# 3. 本地测试（可选但推荐）
./test-deploy-local.sh
# 访问 http://localhost:8080 验证
# Ctrl+C 停止服务器

# 4. 多平台发布
./publish-to-platforms.sh my-new-article.md
# 自动推送到GitHub
# 按照提示发布到其他平台

# 5. 验证博客
# 等待2-3分钟
# 访问：http://ec.thiki.net/
```

---

## 🔧 故障排查

### publish-to-platforms.sh问题

**问题：Git推送失败**
```bash
# 检查Git状态
git status

# 手动推送
git push
```

**问题：剪贴板复制失败**
```bash
# 手动复制
cat my-article.md
# 然后Ctrl+A, Ctrl+C
```

### test-deploy-local.sh问题

**问题：找不到Quartz目录**
```
错误：QUARTZ_COPY_DIR 不存在
```

解决：修改脚本中的路径
```bash
# 编辑 test-deploy-local.sh
# 第9行：QUARTZ_COPY_DIR="/c/workspaces/jo-workspaces/quartz"
# 改为你的实际路径
```

**问题：pnpm命令不可用**
```bash
# 安装pnpm
npm install -g pnpm
```

**问题：端口8080被占用**
```bash
# 查找并结束占用进程
netstat -ano | findstr :8080
taskkill /PID <进程ID> /F
```

---

## 🎯 最佳实践

1. **发布前先本地测试**
   - 运行 `test-deploy-local.sh`
   - 验证内容和布局
   - 避免线上部署失败

2. **使用Git提交消息规范**
   ```bash
   发布: 文章标题
   修复: 问题描述
   更新: 更新内容
   ```

3. **保持脚本可执行权限**
   ```bash
   chmod +x *.sh
   ```

4. **定期更新Quartz**
   ```bash
   cd /c/workspaces/jo-workspaces/quartz
   git pull
   pnpm install
   ```

---

## 📖 相关文档

- [多平台发布指南](../conversations/blog-wiki-best-practices/MULTI-PLATFORM-PUBLISHING.md)
- [GitHub Pages配置](./GITHUB-PAGES-CONFIG.md)
- [会话记忆](../conversations/blog-wiki-best-practices/context.md)

---

**最后更新**: 2025-10-25  
**维护者**: EC

