import { PageLayout, SharedLayout } from "./quartz/cfg"
import * as Component from "./quartz/components"

// 自定义布局配置
// 简化版本：去除默认Quartz元素，只保留版权信息

// 共享组件（所有页面）
export const sharedPageComponents: SharedLayout = {
  head: Component.Head(),
  header: [],  // 清空header，不显示任何顶部导航
  footer: Component.Footer({
    links: {
      // 只保留Quartz版权，去掉默认的GitHub链接等
    },
  }),
}

// 默认内容页面布局
export const defaultContentPageLayout: PageLayout = {
  beforeBody: [
    Component.Breadcrumbs(),       // 面包屑导航
    Component.ArticleTitle(),      // 文章标题
    Component.ContentMeta(),       // 创建/修改日期
    Component.TagList(),           // 标签
  ],
  left: [
    Component.PageTitle(),         // 站点标题（会添加logo）
    Component.MobileOnly(Component.Spacer()),
    Component.Search(),            // 搜索框
    Component.Darkmode(),          // 暗色模式切换
    Component.DesktopOnly(Component.Explorer()),  // 文件浏览器
  ],
  right: [
    Component.Graph(),             // 知识图谱
    Component.DesktopOnly(Component.TableOfContents()),  // 目录
    Component.Backlinks(),         // 反向链接
  ],
  afterBody: [],  
}

// 文件夹列表页布局
export const defaultListPageLayout: PageLayout = {
  beforeBody: [
    Component.Breadcrumbs(),
    Component.ArticleTitle(),
    Component.ContentMeta(),
  ],
  left: [
    Component.PageTitle(),
    Component.MobileOnly(Component.Spacer()),
    Component.Search(),
    Component.Darkmode(),
    Component.DesktopOnly(Component.Explorer()),
  ],
  right: [],
  afterBody: [],    // 正文下方的组件区域
}

