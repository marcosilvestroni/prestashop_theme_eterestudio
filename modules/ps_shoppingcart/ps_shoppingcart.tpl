  

  <div id="_desktop_cart">
  <div class="blockcart cart-preview {if $cart.products_count > 0}active{else}inactive{/if}" data-refresh-url="{$refresh_url}">
    <div class="header">
      {if $cart.products_count > 0}
        <a rel="nofollow" href="{$cart_url}">
      {/if}
      <div class="bag">
        {if $cart.products_count > 0}<div class="cart-products-count">({$cart.products_count})</div>{/if}
        <img src="{$urls.base_url}/themes/eterestudio/assets/img/cart_icon.png" alt="{$shop.name}" class="icon-layout">
      </div>
      {if $cart.products_count > 0}
        </a>
      {/if}
    </div>
    <script>
      
        setTimeout(function(){
          
          if(document.getElementById("blockcart-modal")){
              $(".blockcart-modal").fadeOut("slow")
            }
        },2000)
      
    </script>
  </div>
</div>
