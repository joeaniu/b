# 我的知识库

[![Deploy to GitHub Pages](https://github.com/joeaniu/b/actions/workflows/deploy.yml/badge.svg)](https://github.com/joeaniu/b/actions/workflows/deploy.yml)

个人博客，使用 [Quartz](https://quartz.jzhao.xyz/) 构建并托管在 GitHub Pages。

🌐 **网站地址**：[https://joeaniu.github.io/b/](https://joeaniu.github.io/b/)

## 1. 仓库说明

此仓库是独立的博客发布仓库，嵌套在主vault的 `published/` 目录中：

```
主vault (私有Git服务器)
├── work-log/       # 私密内容
├── matrix/         # 私密内容
├── writing/        # 私密草稿
└── published/      # 此仓库 (GitHub公开)
    ├── .git/       # 独立的Git仓库
    ├── *.md        # 博客文章
    └── .github/    # 自动部署配置
```

**隔离策略**：
- 主vault的 `.gitignore` 忽略 `published/` 目录
- 此仓库独立管理，完全隔离私密内容
- 一个工作区同时管理两个Git仓库

## 2. 自动部署

每次推送到 `main` 分支时，GitHub Actions 会自动：

1. ✅ 克隆Quartz
2. ✅ 复制配置和内容
3. ✅ 构建静态站点
4. ✅ 部署到GitHub Pages

**部署时间**：约2-5分钟

查看部署状态：[Actions](https://github.com/joeaniu/b/actions)

## 3. 本地预览

在外部Quartz目录设置软链接：

```bash
# 在Quartz安装目录（一次性配置）
cd ~/tools/quartz
rm -rf content
ln -sf ~/Documents/jowork/thiki_vault/agent-chats/published content

# 启动预览服务器
node ./quartz/bootstrap-cli.mjs build --serve

# 访问 http://localhost:8080
```

## 4. 发布新文章

### 4.1. 在Obsidian中编辑

1. 在 `published/` 目录创建或编辑 Markdown 文件
2. 保存后在Git中提交并推送

### 4.2. 在Cursor/终端中操作

```bash
# 查看更改
cd published/
git status

# 添加新文章
git add my-new-article.md

# 提交
git commit -m "发布：我的新文章"

# 推送到GitHub（触发自动部署）
git push

# 等待2-5分钟后访问网站查看更新
```

## 5. 技术栈

- 📝 **内容编辑**：Obsidian / Markdown
- 🔨 **静态生成**：Quartz v4
- 🚀 **托管平台**：GitHub Pages
- 🤖 **CI/CD**：GitHub Actions
- 🎨 **主题**：自定义配置（`quartz.config.ts`）

## 6. 配置文件

### 6.1. `quartz.config.ts`

主要配置项：
- `pageTitle`: 网站标题
- `locale`: 语言设置（zh-CN）
- `baseUrl`: GitHub Pages域名
- `theme`: 主题颜色和字体
- `plugins`: 功能插件（代码高亮、数学公式等）

修改配置后提交推送，GitHub Actions会自动重新构建。

### 6.2. `.github/workflows/deploy.yml`

GitHub Actions工作流配置，定义了自动部署流程。

## 7. 特性

- ✅ **实时搜索**：全文搜索功能
- ✅ **双向链接**：Obsidian风格的 `[[链接]]`
- ✅ **代码高亮**：支持多种编程语言
- ✅ **数学公式**：LaTeX / KaTeX 支持
- ✅ **响应式设计**：移动端适配
- ✅ **暗色模式**：自动切换
- ✅ **RSS订阅**：自动生成
- ✅ **站点地图**：SEO优化

## 8. 维护指南

### 8.1. 更新依赖

Quartz会在每次部署时自动使用最新版本，无需手动维护。

### 8.2. 故障排查

如果部署失败：
1. 查看 [Actions日志](https://github.com/joeaniu/b/actions)
2. 检查 `quartz.config.ts` 语法
3. 确认Markdown文件格式正确

### 8.3. 性能优化

- 图片建议使用外部图床（PicGo + GitHub）
- 单个文章建议不超过1MB
- 避免上传视频等大文件

## 9. 参考资源

- [Quartz官方文档](https://quartz.jzhao.xyz/)
- [GitHub Pages文档](https://docs.github.com/pages)
- [Obsidian官网](https://obsidian.md/)

---

📅 **最后更新**：2025年10月22日
