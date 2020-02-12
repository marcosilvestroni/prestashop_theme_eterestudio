{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file=$layout}

{block name='head_seo' prepend}
  <link rel="canonical" href="{$product.canonical_url}">
{/block}

{block name='head' append}
  <meta property="og:type" content="product">
  <meta property="og:url" content="{$urls.current_url}">
  <meta property="og:title" content="{$page.meta.title}">
  <meta property="og:site_name" content="{$shop.name}">
  <meta property="og:description" content="{$page.meta.description}">
  <meta property="og:image" content="{$product.cover.large.url}">
  <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
  <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
  <meta property="product:price:amount" content="{$product.price_amount}">
  <meta property="product:price:currency" content="{$currency.iso_code}">
  {if isset($product.weight) && ($product.weight != 0)}
    <meta property="product:weight:value" content="{$product.weight}">
    <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='content'}

  <section id="main" itemscope itemtype="https://schema.org/Product">
    <meta itemprop="url" content="{$product.url}">

    {block name='product_activation'}
      {include file='catalog/_partials/product-activation.tpl'}
    {/block}

    {block name='page_content_container'}
      <section id="content" class="page-content">
        {block name='page_content'}
          <div id="studio-grid-container">
              <div id="studio-grid"></div>
          </div>
          <div class="product">
              {block name='product_cover'}
                <div id="product-cover" class=" product-cover product-box">
                  <img src="{$product.cover.bySize.product_cover_image.url}" alt="{$product.cover.legend}" title="{$product.cover.legend}"  itemprop="image">
                </div>
              {/block}

              <div id="product-info" class="product-info product-box">
              
                  <header class="product-header">
                    {block name='page_header'}
                      <h1 itemprop="name">{block name='page_title'}{$product.name|replace:' ':'#'}{/block}</h1>
                    {/block}
                  </header>

                  {block name='product_description_short'}
                    <div class="product-description-short" itemprop="description">{$product.description_short nofilter}</div>
                  {/block}

                  <div class="product-actions">
                    {block name='product_buy'}
                      <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                        <input type="hidden" name="token" value="{$static_token}">
                        <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                        <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id">

                        

                          {block name='product_prices'}
                            {include file='catalog/_partials/product-prices.tpl'}
                          {/block}

                          {block name='product_variants'}
                            {include file='catalog/_partials/product-variants.tpl'}
                          {/block}


                          {block name='product_features'}
                          {if $product.features}
                            <section class="product-features">
                              <h3>{l s='Data sheet' d='Shop.Theme.Catalog'}</h3>
                              <ul>
                                {foreach from=$product.features item=feature}
                                  <li>{$feature.name} - {$feature.value}</li>
                                {/foreach}
                              </ul>
                            </section>
                          {/if}
                        {/block}
                                    
                          {block name='product_add_to_cart'}
                            {include file='catalog/_partials/product-add-to-cart.tpl'}
                          {/block}

                      </form>
                    {/block}
                  </div>

                  {block name='product_description'}
                    <div id="product-description">{$product.description nofilter}</div>
                  {/block}
              </div>

              

              {block name='product_images'}
            
              {foreach from=$product.images item=image key=k}
              {if $k>0 and $k<7}
              {assign var=urlsrc value="product_image_`$k`"}
                <div id="product-image-{$k}" class=" product-image-{$k} product-box">
                  <img src="{$image.bySize[$urlsrc].url}" 
                  alt="{$image.legend}" 
                  title="{$image.legend}" 
                  itemprop="image">
                </div>
                {/if}
              {/foreach}

          {/block}
        </div>

          {block name='product_discounts'}
            {include file='catalog/_partials/product-discounts.tpl'}
          {/block}

          {if $product.is_customizable && count($product.customizations.fields)}
            {block name='product_customization'}
              {include file='catalog/_partials/product-customization.tpl' customizations=$product.customizations}
            {/block}
          {/if}

          {block name='product_footer'}
            {hook h='displayFooterProduct' product=$product category=$category}
          {/block}

          {block name='product_attachments'}
            {if $product.attachments}
              <section class="product-attachments">
                <h3>{l s='Download' d='Shop.Theme.Actions'}</h3>
                {foreach from=$product.attachments item=attachment}
                  <div class="attachment">
                    <h4>
                      <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                        {$attachment.name}
                      </a>
                    </h4>
                    <p>{$attachment.description}</p>
                    <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                      {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                    </a>
                  </div>
                {/foreach}
              </section>
            {/if}
          {/block} 
          {foreach from=$product.extraContent item=extra key=extraKey}
            <div class="{$extra.attr.class}" id="extra-{$extraKey}">
              {$extra.content nofilter}
            </div>
          {/foreach}
        {/block}
      </section>
    {/block}

    {block name='page_footer_container'}
      <footer class="page-footer">
        {block name='page_footer'}

        {/block}
      </footer>
    {/block}

  </section>

 {block name='javascript_head'}
      {include file="../_partials/jscustom.tpl" }
    {/block}


{/block}
