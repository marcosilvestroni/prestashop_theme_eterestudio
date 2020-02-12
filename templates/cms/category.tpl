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
{extends file='page.tpl'}

{* 
{block name='page_title'}
  {$cms_category.name}
{/block} *}

{block name='page_content'}
<div class="{$cms_category.link_rewrite}">
  {block name='cms_sub_categories'}
    {if $sub_categories}
        {foreach from=$sub_categories item=sub_category}
        <div class="static-block {$sub_category.link_rewrite}">
          {if $sub_category.pages}
            {foreach from=$sub_category.pages item=cms_page}
              <div class="static-block-content {$cms_page.meta_title} media-box">{$cms_page.content nofilter}</div>
            {/foreach}
          {/if}
        </div>
        {/foreach}
    {/if}
  {/block}
</div>

{if $cms_category.link_rewrite == "contatti"}
<script>
  document.querySelector("body").classList.add("body-background");
</script>
{/if}
{/block}
