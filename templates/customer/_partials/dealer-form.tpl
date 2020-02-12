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
{block name='dealer_form'}
{* 
  {block name='customer_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

  <form action="{block name='customer_form_actionurl'}{$action}{/block}" id="dealer-form" method="post">

{assign var="fieldsDealer" value=[
  [
    "type"=>"text",
    "name"=>"nome",
    "label"=>"nome",
    "required"=>true,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"cognome",
    "label"=>"cognome",
    "required"=>true,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"email",
    "label"=>"email",
    "required"=>true,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"azienda",
    "label"=>"azienda",
    "required"=>true,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"indirizzo",
    "label"=>"indirizzo",
    "required"=>false,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"stato",
    "label"=>"stato",
    "required"=>false,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"citta",
    "label"=>"città",
    "required"=>false,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"telefono",
    "label"=>"stato",
    "required"=>false,
    "value"=>"",
    "errors"=>[]
  ],
  [
    "type"=>"text",
    "name"=>"piva",
    "label"=>"Partita IVA",
    "required"=>true,
    "value"=>"",
    "errors"=>[]
  ]

]}


    <section class="form-fields">
      {block "form_fields"}
        {foreach from=$fieldsDealer item="field"}
        <div class="field-box">
          {block "form_field"}
            {form_field field=$field}
          {/block}
          </div>
        {/foreach}
      {/block}
    </section>

    {block name='customer_form_footer'}
      <footer class="form-footer">
        <input type="hidden" name="submitCreate" value="1">
        {block "form_buttons"}
          <button class="form-button" data-link-action="save-customer" type="submit">
            {l s='Save' d='Shop.Theme.Actions'}
          </button>
        {/block}
      </footer>
    {/block}

  </form>
 *}
  <div class="typeform-widget" data-url="https://marco646.typeform.com/to/PzVJWU" style="width: 100%; height: 500px;"></div> <script> (function() { var qs,js,q,s,d=document, gi=d.getElementById, ce=d.createElement, gt=d.getElementsByTagName, id="typef_orm", b="https://embed.typeform.com/"; if(!gi.call(d,id)) { js=ce.call(d,"script"); js.id=id; js.src=b+"embed.js"; q=gt.call(d,"script")[0]; q.parentNode.insertBefore(js,q) } })() </script> <div style="font-family: Sans-Serif;font-size: 12px;color: #999;opacity: 0.5; padding-top: 5px;"> powered by <a href="https://admin.typeform.com/signup?utm_campaign=PzVJWU&utm_source=typeform.com-12588881-Basic&utm_medium=typeform&utm_content=typeform-embedded-poweredbytypeform&utm_term=EN" style="color: #999" target="_blank">Typeform</a> </div>
{/block}
