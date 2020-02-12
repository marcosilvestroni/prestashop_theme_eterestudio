
{block name='cart_detailed_product_line'}

<div class="cart-item-image">
  <span class="product-image"><img src="{$product.cover.medium.url}"></span>
</div>
<div class="cart-item-detail">
  <div class="product-name">
    <a href="{$product.url}" data-id_customization="{$product.id_customization|intval}">{$product.name}</a>
  </div>
  <div class="product-short">
   {$product.description_short nofilter}
  </div>
  
  {foreach from=$product.attributes key="attribute" item="value"}
    <div class="product-line product-attributes">
      <span class="label">{$attribute}:</span>
      <span class="value">{$value}</span>
    </div>
  {/foreach}

  {* {block name='cart_detailed_product_line_customization'}
    {if $product.customizations|count}
      {foreach from=$product.customizations item="customization"}
        {foreach from=$customization.fields item="field"}
          <span class="product-line-info">
            <span class="label">{$field.label}:</span>
            <span class="value">
              {if $field.type == 'text'}
                {if $field.id_module}
                  {$field.text nofilter}
                {else}
                 {$field.text}
                {/if}
              {elseif $field.type == 'image'}
                <img src="{$field.image.small.url}">
              {/if}
            </span>
          </span>
        {/foreach}
      {/foreach}
    {/if}
  {/block}
 *}
  {* <span class="product-availability">{$product.availability}</span> *}
  {* <div class="product-price">{$product.price}</div>
  {if $product.unit_price_full}
    <small class="sub">{$product.unit_price_full}</small>
  {/if} *}


  <div class="product-line product-quantity">
    <span class="label">
      quantità
    </span>
    
    {if $product.down_quantity_url}
    <a href="{$product.down_quantity_url}" class="js-decrease-product-quantity" data-link-action="update-quantity">-</a>
    {/if}
    <span class="value">
      {$product.quantity} 
    </span>
    {if $product.up_quantity_url}
      <a href="{$product.up_quantity_url}" class="js-increase-product-quantity" data-link-action="update-quantity">+</a>
    {/if}
   
    
  </div>

  <div class="product-line product-price">
    <span class="label">
      prezzo
    </span>
    <span class="separator"></span>
    {if isset($product.is_gift) && $product.is_gift}
      <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
    {else}
      <span class="value">{$product.total}</span>
    {/if}

  </div>

  <div class="product-remove">
    <a
      class="remove-from-cart"
      data-link-action="remove-from-cart"
      data-id-product="{$product.id_product|escape:'javascript'}"
      data-id-product-attribute="{$product.id_product_attribute|escape:'javascript'}"
      href="{$product.remove_from_cart_url}"
      rel="nofollow"
    >
      {l s='Remove' d='Shop.Theme.Actions'}
    </a>
  </div>

</div>
  
{/block}
