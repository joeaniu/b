# GitHub Pages配置指南

## ✅ 已完成

- [x] published/目录初始化为独立Git仓库
- [x] quartz.config.ts配置（baseUrl: joeaniu.github.io/b）
- [x] GitHub Actions工作流创建
- [x] 代码已推送到GitHub

## 📋 待完成步骤

### 步骤1：配置GitHub Pages

1. **访问仓库设置**
   ```
   https://github.com/joeaniu/b/settings/pages
   ```

2. **配置Source**
   - 在 "Build and deployment" 部分
   - **Source** 选择：`GitHub Actions`
   - 点击 Save（如果有）

   ```
   ┌─────────────────────────────────┐
   │ Source                          │
   │ ○ Deploy from a branch          │
   │ ● GitHub Actions       ← 选这个  │
   └─────────────────────────────────┘
   ```

3. **确认仓库可见性**
   - GitHub Pages免费版要求仓库必须是 **Public**
   - 在 Settings → General → Danger Zone 检查

### 步骤2：触发首次部署

#### 方法1：自动触发（推荐）

推送代码已自动触发，无需额外操作。

#### 方法2：手动触发

如果需要手动触发：
1. 访问 `https://github.com/joeaniu/b/actions`
2. 选择左侧的 "Deploy Quartz to GitHub Pages"
3. 点击右上角 "Run workflow"
4. 选择 `master` 分支
5. 点击 "Run workflow"

### 步骤3：监控部署进度

1. **访问Actions页面**
   ```
   https://github.com/joeaniu/b/actions
   ```

2. **查看工作流状态**
   - 点击最新的工作流运行
   - 观察各步骤进度
   - 等待所有步骤完成（约2-5分钟）

3. **成功标志**
   ```
   ✓ Checkout blog repository
   ✓ Setup Node.js
   ✓ Setup pnpm
   ✓ Clone Quartz
   ✓ Install Quartz dependencies
   ✓ Prepare content
   ✓ Build Quartz
   ✓ Upload artifact
   ✓ Deploy to GitHub Pages
   ```

### 步骤4：验证网站

1. **访问博客地址**
   ```
   https://joeaniu.github.io/b/
   ```

2. **验证清单**
   - [ ] 网站可以访问（不是404）
   - [ ] 首页显示 "欢迎来到我的知识库"
   - [ ] 可以点击 "测试文章" 链接
   - [ ] 代码高亮正常显示
   - [ ] 数学公式正常渲染
   - [ ] 浏览器console无404错误
   - [ ] 样式正常（无混乱）

## 🔧 故障排查

### 问题1：Actions工作流失败

**检查权限**：
1. 访问 `https://github.com/joeaniu/b/settings/actions`
2. 找到 "Workflow permissions"
3. 选择：`Read and write permissions`
4. 勾选：`Allow GitHub Actions to create and approve pull requests`
5. 点击 Save

### 问题2：404 - 网站无法访问

**等待DNS生效**：
- 首次部署可能需要5-10分钟
- 刷新几次或等待一会儿

**检查Pages配置**：
- 确认 Settings → Pages → Source 是 "GitHub Actions"
- 确认仓库是 Public

### 问题3：样式混乱/资源404

**检查baseUrl**：
```typescript
// published/quartz.config.ts
baseUrl: "joeaniu.github.io/b"  // 必须包含仓库名
```

如果修改了baseUrl：
```bash
cd published/
git add quartz.config.ts
git commit -m "fix: 调整baseUrl"
git push
```

### 问题4：rsync: command not found

**GitHub Actions中rsync不可用**：

编辑 `published/.github/workflows/deploy.yml`，替换 rsync 命令：

```yaml
- name: Prepare content
  run: |
    # 复制配置文件
    cp quartz.config.ts quartz-build/
    
    # 复制内容（使用find + cp替代rsync）
    mkdir -p quartz-build/content
    find . -maxdepth 1 -name "*.md" ! -name "README.md" -exec cp {} quartz-build/content/ \;
    # 复制子目录（如果有）
    if [ -d "images" ]; then cp -r images quartz-build/content/; fi
    if [ -d "posts" ]; then cp -r posts quartz-build/content/; fi
```

## 🎯 成功后的效果

访问 `https://joeaniu.github.io/b/` 应该看到：

- ✅ 漂亮的首页
- ✅ 响应式设计
- ✅ 搜索功能
- ✅ 暗色模式切换
- ✅ 代码高亮
- ✅ 数学公式渲染

## 📝 日常使用

### 发布新文章

```bash
# 在Obsidian中编辑
# published/my-new-article.md

# 提交并推送
cd published/
git add my-new-article.md
git commit -m "发布：我的新文章"
git push

# 等待2-5分钟自动部署
# 访问 https://joeaniu.github.io/b/ 查看更新
```

### 本地预览

```bash
# 在外部Quartz目录
cd ~/tools/quartz
ln -sf ~/Documents/jowork/thiki_vault/agent-chats/published content
node ./quartz/bootstrap-cli.mjs build --serve

# 访问 http://localhost:8080
```

## 🎊 完成Phase 3

验证成功后，Phase 3 完成！🎉

**下一步**：Phase 4 - 图床配置（PicGo + GitHub）

---

📅 创建时间：2025年10月22日

