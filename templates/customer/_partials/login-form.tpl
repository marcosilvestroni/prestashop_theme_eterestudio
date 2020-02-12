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
{block name='login_form'}

  {block name='login_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}
 

  <form id="login-form" action=" {block name='login_form_actionurl'}{$action}{/block}" method="post">

    <section class="form-fields">
      {block name='form_fields'}
        {foreach from=$formFields item="field"}
          <div class="field-box">
              {block name='form_field'}
                {form_field field=$field}
              {/block}
          </div>
        {/foreach}
      {/block}

      <p class="lost_password">
        <a href="{$urls.pages.password}" rel="nofollow">
          {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
        </a>
      </p>
    </section>

    {block name='login_form_footer'}
      <footer class="form-footer">
        <input type="hidden" name="submitLogin" value="1">
        {block name='form_buttons'}
          <button class="form-button" data-link-action="sign-in" type="submit">{l s='Sign in' d='Shop.Theme.Actions'}</button>
          {* <button class="form-button" data-link-action="sign-in" type="button">Login social</button> *}
          {hook h="HiFacebookConnect" button_size="big/small"}
        {/block}
      </footer>
    {/block}

  </form>
{/block}
