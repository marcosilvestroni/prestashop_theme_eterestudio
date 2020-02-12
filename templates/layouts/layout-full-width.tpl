<!doctype html>
<html lang="{$language.locale}">

  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

  <body id="{$page.page_name}" class="{$page.body_classes|classnames}">
  <main>
    <div class="border"></div>
    <div class="container">

    <header id="header">
      {block name='header'}
        {include file='_partials/header.tpl'}
      {/block}

      
    </header>


   
      {block name='etere_top_left'}
        <div id="logo-star" class="logo">
          {block name='header_logo'}
            <a href="{$urls.base_url}" title="{$shop.name}">
              <img src="{$urls.base_url}themes/eterestudio/assets/img/logo.png" alt="{$shop.name}" class="icon-layout">
            </a>
          {/block}
          {hook h="displayEtereTopLeft"}
        </div>
      {/block}
      {block name='etere_top_right'}
        <div class="etere-top-right">
          {hook h="displayEtereTopRight"}
        </div>
      {/block}
      {block name='etere_bottom_left'}
        <div class="etere-bottom-left">
          {hook h="displayEtereBottomLeft"}
        </div>
      {/block}
      {block name='etere_bottom_right'}
        <div class="etere-bottom-right">
          {hook h="displayEtereBottomRight"}
        </div>
      {/block}
      {block name='notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}
    <div id="wrapper" class="main-content">

      {block name='content_wrapper'}
        <div id="content-wrapper" >
          {hook h="displayContentWrapperTop"}
          {block name='content'}
            <p>Hello world! This is HTML5 Boilerplate.</p>
          {/block}
          {hook h="displayContentWrapperBottom"}
        </div>
      {/block}

      {hook h="displayWrapperBottom"}
    </div>


    {* <footer id="footer">
      {block name='footer'}
        {include file='_partials/footer.tpl'}
      {/block}
    </footer> *}

    {block name='javascript_bottom'}
      {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
    {/block}

   

    </div>
  </main>
    
    

  </body>

</html>
