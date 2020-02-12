{**
* 2013 - 2018 HiPresta
*
* MODULE Facebook Connect
*
* @author    HiPresta <suren.mikaelyan@gmail.com>
* @copyright HiPresta 2018
* @license   Addons PrestaShop license limitation
* @link      http://www.hipresta.com
*
* NOTICE OF LICENSE
*
* Don't use this module on several shops. The license provided by PrestaShop Addons
* for all its modules is valid only once for a single shop.
*}

{if isset($hi_sc_fb_on) && $hi_sc_fb_on}
	{if $hi_sc_fb_button_size == 'big'}
		<div id="fb-root"></div>
		<a onclick="fb_login();"><button  class="form-button" title="{l s='Sign in with Facebook' mod='hifacebookconnect'}">Accedi via Facebook</button></a>
	{else}
		<a onclick="fb_login();"><button  class="form-button" title="{l s='Sign in with Facebook' mod='hifacebookconnect'}">Accedi via Facebook</button></a>
	{/if}
{/if}
