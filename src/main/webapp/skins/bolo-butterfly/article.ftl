<#--

    Solo - A small and beautiful blogging system written in Java.
    Copyright (c) 2010-present, b3log.org

    Solo is licensed under Mulan PSL v2.
    You can use this software according to the terms and conditions of the Mulan PSL v2.
    You may obtain a copy of Mulan PSL v2 at:
            http://license.coscl.org.cn/MulanPSL2
    THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
    See the Mulan PSL v2 for more details.

-->
<#include "../../common-template/macro-common_head.ftl">
<#include "macro-comments.ftl">
<#include "../../common-template/macro-comment_script.ftl">

<!DOCTYPE html>
<html>
<head>
    <@head title="${article.articleTitle} - ${blogTitle}" description="${article.articleAbstract?html}">
        <link rel="stylesheet"
              href="${staticServePath}/skins/${skinDirName}/css/base.css?${staticResourceVersion}"/>
        <#if previousArticlePermalink??>
            <link rel="prev" title="${previousArticleTitle}" href="${servePath}${previousArticlePermalink}">
        </#if>
        <#if nextArticlePermalink??>
            <link rel="next" title="${nextArticleTitle}" href="${servePath}${nextArticlePermalink}">
        </#if>
    </@head>
</head>
<body class="fn__flex-column">
<div id="pjax" class="fn__flex-1">
    <#if pjax><!---- pjax {#pjax} start ----></#if>
    <#include "define-header.ftl">
    <@header type="article"></@header>
    <div class="article__top" style="background-image: url(${article.articleImg1URL})">
        <div style="background-image: url(${article.articleImg1URL})"></div>
        <canvas id="articleTop"></canvas>
    </div>

    <main class="layout_post" id="content-inner">
        <article id="post">
            <div class="article">
                <div class="ft__center">
                    <div class="article__meta">
                        <time>
                            ${article.articleCreateDate?string("yyyy-MM-dd")} / ${article.articleUpdateDate?string("yyyy-MM-dd")}
                        </time>
                        /
                        <#list article.articleTags?split(",") as articleTag>
                            <a rel="tag"
                               href="${servePath}/tags/${articleTag?url('UTF-8')}">${articleTag}</a> &nbsp;
                        </#list>
                    </div>
                    <h2 class="article__title">
                        ${article.articleTitle}
                        <#if article.articlePutTop>
                            <sup>
                                ${topArticleLabel}
                            </sup>
                        </#if>
                    </h2>
                    <#include "../../common-template/share.ftl">
                </div>
                <div class="wrapper">
                    <section id="article-container">
                        ${article.articleContent}
                        <#if "" != article.articleSign.signHTML?trim>
                            <div>
                                ${article.articleSign.signHTML}
                            </div>
                        </#if>
                    </section>
                </div>
            </div>

            <#if article?? && article.articleToC?? && article.articleToC?size &gt; 0>
                <div class="post__toc">
                    <#include "../../common-template/toc.ftl"/>
                </div>
            </#if>

            <div class="article__bottom">
                <div class="wrapper">
                    <#if interactive == "on">
                        <section class="comments">
                            <ul class="commentwrap">
                                <@comments commentList=articleComments article=article count=article.articleCommentCount></@comments>
                            </ul>
                        </section>
                    </#if>
                </div>
            </div>
        </article>
    </main>
    <#if pjax><!---- pjax {#pjax} end ----></#if>
</div>
<script type="text/javascript"
        src="${staticServePath}/skins/${skinDirName}/js/TweenMax.min.js?${staticResourceVersion}"
        charset="utf-8"></script>
<#include "footer.ftl">
<#if article?? && article.articleToC?? && article.articleToC?size &gt; 0>
    <svg viewBox="0 0 32 32" width="100%" height="100%" class="side__top side__top--toc">
        <path d="M30 18h-28c-1.1 0-2-0.9-2-2s0.9-2 2-2h28c1.1 0 2 0.9 2 2s-0.9 2-2 2zM30 6.25h-28c-1.1 0-2-0.9-2-2s0.9-2 2-2h28c1.1 0 2 0.9 2 2s-0.9 2-2 2zM2 25.75h28c1.1 0 2 0.9 2 2s-0.9 2-2 2h-28c-1.1 0-2-0.9-2-2s0.9-2 2-2z"></path>
    </svg>
</#if>
<#if pjax><!---- pjax {#pjax} start ----></#if>
<@comment_script oId=article.oId commentable=article.commentable>
    page.tips.externalRelevantArticlesDisplayCount = "${externalRelevantArticlesDisplayCount}";
    <#if 0 != randomArticlesDisplayCount>
        page.loadRandomArticles('<h3>${randomArticlesLabel}</h3>');
    </#if>
    <#if 0 != externalRelevantArticlesDisplayCount>
        page.loadExternalRelevantArticles("<#list article.articleTags?split(",") as articleTag>${articleTag}<#if articleTag_has_next>,</#if></#list>",
        '<h3>${externalRelevantArticlesLabel}</h3>');
    </#if>
    <#if 0 != relevantArticlesDisplayCount>
        page.loadRelevantArticles('${article.oId}', '<h3>${relevantArticlesLabel}</h3>');
    </#if>
    Skin.initArticle()
</@comment_script>
<#if pjax><!---- pjax {#pjax} end ----></#if>
</body>
</html>
