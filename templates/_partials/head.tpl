{block name='head_charset'}
  <meta charset="utf-8">
{/block}
{block name='head_ie_compatibility'}
  <meta http-equiv="x-ua-compatible" content="ie=edge">
{/block}

{block name='head_seo'}
  <title>{block name='head_seo_title'}{$page.meta.title}{/block}</title>
  <meta name="description" content="{block name='head_seo_description'}{$page.meta.description}{/block}">
  <meta name="keywords" content="{block name='head_seo_keywords'}{$page.meta.keywords}{/block}">
  <link href="https://fonts.googleapis.com/css?family=Space+Mono:400,700" rel="stylesheet"> 
  {if $page.meta.robots !== 'index'}
    <meta name="robots" content="{$page.meta.robots}">
  {/if}
  {if $page.canonical}
    <link rel="canonical" href="{$page.canonical}">
  {/if}

{/block}

{block name='head_viewport'}
  <meta name="viewport" content="width=device-width, initial-scale=1">
{/block}

{block name='head_icons'}
 {*  <link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?{$shop.favicon_update_time}"> *}
  <link rel="apple-touch-icon" sizes="120x120" href="/themes/eterestudio/assets/img/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="/themes/eterestudio/assets/img/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="/themes/eterestudio/assets/img/favicon-16x16.png">
  <link rel="manifest" href="img/site.webmanifest">
  <link rel="mask-icon" href="/themes/eterestudio/assets/img/safari-pinned-tab.svg" color="#5bbad5">
  <meta name="msapplication-TileColor" content="#da532c">
  <meta name="theme-color" content="#ffffff">
  {* <link rel="shortcut icon" type="image/x-icon" href="{$shop.favicon}?{$shop.favicon_update_time}"> *}

{/block}

{block name='stylesheets'}
  {include file="_partials/stylesheets.tpl" stylesheets=$stylesheets}
{/block}

{block name='javascript_head'}
  {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}
{/block}

{block name='hook_header'}
  {$HOOK_HEADER nofilter}
{/block}

{block name='hook_extra'}{/block}
