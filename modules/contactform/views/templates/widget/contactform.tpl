{*
* 2007-2015 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2015 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}



<section class="login-form dealer-form">
  <form action="{$urls.pages.contact}" method="post" {if $contact.allow_file_upload}enctype="multipart/form-data"{/if}>

    <header>
      {* <h1 class="h3">{l s='Send a message' d='Modules.Contactform.Shop'}</h1> *}
      <p>{l s='If you would like to add a comment about your order, please write it in the field below.' d='Modules.Contactform.Shop'}</p>
    </header>

    {if $notifications}
      <div class="notification {if $notifications.nw_error}notification-error{else}notification-success{/if}">
        <ul>
          {foreach $notifications.messages as $notif}
            <li>{$notif}</li>
          {/foreach}
        </ul>
      </div>
    {/if}

    {if !$notifications || $notifications.nw_error}
      <section class="form-fields ">
      <input type="hidden" value="2" name="id_contact"/>
        

          <input type="hidden" name="from"  value="{$contact.email}" />


        {* {if $contact.orders}
          <label>
            <span>{l s='Order reference' d='Modules.Contactform.Shop'}</span>
            <select name="id_order">
              <option value="">{l s='Select reference' d='Modules.Contactform.Shop'}</option>
              {foreach from=$contact.orders item=order}
                <option value="{$order.id_order}">{$order.reference}</option>
              {/foreach}
            </select>
          </label>
        {/if} *}

{*         {if $contact.allow_file_upload}
          <label>
            <span>{l s='Attach File' d='Modules.Contactform.Shop'}</span>
            <input type="file" name="fileUpload" />
          </label>
        {/if} *}

        <label>
          <span>{l s='Message' d='Modules.Contactform.Shop'}</span>
          <textarea class="form-group-input--value" cols="67" rows="3" name="message">{if $contact.message}{$contact.message}{/if}</textarea>
        </label>
        
        {hook h='displayGDPRConsent' id_module=$id_module}

      </section>

      <footer class="form-footer">
        <style>
          input[name=url] {
            display: none !important;
          }
        </style>
        <input type="text" name="url" value=""/>
        <input type="hidden" name="token" value="{$token}" />
        <button class="form-button" type="submit" name="submitMessage">
          {l s='Send' d='Modules.Contactform.Shop'}
        </button>
      </footer>
    {/if}
  </form>
</section>
