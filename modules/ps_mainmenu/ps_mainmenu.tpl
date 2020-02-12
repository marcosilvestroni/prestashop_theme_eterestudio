{function name="menu" nodes=[] depth=0}
  {strip}
    {if $nodes|count}
        {foreach from=$nodes item=node}
          <li class="menu-item {$node.type}{if $node.current} menu-item-current{/if} ">
            <a href="{$node.url}" {if $node.open_in_new_window} target="_blank" {/if}>{$node.label}</a>
          </li>
        {/foreach}
    {/if}
  {/strip}
{/function}

<div class="menu">
<div class="menu-header">
  <div class="menu-icon">
    <img  class="icon-layout" src="{$urls.base_url}/themes/eterestudio/assets/img/menu_icon.png" alt="{$shop.name}">
  </div>
  <div class="menu-buylink">
    <a href="{$urls.base_url}index.php?id_cms=16&controller=cms&id_lang=1" title="Buy" rel="nofollow" >Buy</a>
  </div>
</div>
  <div class="menu-list">
    {menu nodes=$menu.children}
  </div>
  
</div>