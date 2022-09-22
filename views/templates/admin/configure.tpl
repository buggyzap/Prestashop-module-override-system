{*
* 2007-2022 PrestaShop
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
*  @author    PrestaShop SA <contact@prestashop.com>
*  @copyright 2007-2022 PrestaShop SA
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<style>
	.bootstrap .hidden {
		display: inherit !important;
		visibility: inherit !important;
	}
</style>
<div id="module-override-app"> 
	<div class="relative flex min-h-full flex-col">
	  <nav class="flex-shrink-0 bg-indigo-600">
	    <div class="mx-auto max-w-7xl px-2 sm:px-4 lg:px-8">
	      <div class="relative flex h-16 items-center justify-between">
	        <div class="flex flex-1 justify-center lg:justify-end">
	          <div class="w-full px-2 lg:px-6">
	            <label for="search" class="sr-only">{l s='Search overrides' mod='module_override'}</label>
	            <div class="relative text-indigo-200 focus-within:text-gray-400">
	              <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
	                <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
	                  <path fill-rule="evenodd" d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z" clip-rule="evenodd" />
	                </svg>
	              </div>
	              <input id="search-overrides" name="search" class="block w-full rounded-md border border-transparent bg-indigo-400 bg-opacity-25 py-2 pl-10 pr-3 leading-5 text-indigo-100 placeholder-indigo-200 focus:bg-white focus:text-gray-900 focus:placeholder-gray-400 focus:outline-none focus:ring-0 sm:text-sm" placeholder="{l s='Search overrides' mod='module_override'}..." type="search">
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </nav>
	  <div class="mx-auto w-full max-w-7xl flex-grow lg:flex xl:px-8 bg-white">
	    <div class="min-w-0 flex-1 xl:flex">
	      <div class="bg-white lg:min-w-0 lg:flex-1 pb-16">
	        <div class="border-b border-t border-gray-200 pr-6 pt-4 pb-4 xl:border-t-0 xl:pt-6">
	          <div class="flex items-center">
	            <h1 class="flex-1 text-lg font-medium">{l s='Module overrides' mod='module_override'}</h1>
	          </div>
	        </div>
	        <ul role="list" class="grid grid-cols-4 gap-8 mt-12">
						{foreach from=$available_overrides item=$override}
						<li>
							<div class="p-6 max-w-sm bg-white rounded-lg border border-gray-200 shadow-md dark:bg-gray-800 dark:border-gray-700">
								<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="mb-2 w-10 h-10 text-blue-500">
								  <path stroke-linecap="round" stroke-linejoin="round" d="M21 7.5l-9-5.25L3 7.5m18 0l-9 5.25m9-5.25v9l-9 5.25M3 7.5l9 5.25M3 7.5v9l9 5.25m0-9v9" />
								</svg>
				        <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
									<span>{$override.name}</span>
								</h5>
								<p class="mb-3 font-normal text-gray-700 dark:text-gray-400 flex items-center">
									{l s='Version' mod='module_override'} {$override.version}
								</p>
						    <p class="mb-3 font-normal text-gray-700 dark:text-gray-400 flex items-center">
									<span>
										<span class="h-4 w-4 {if $override.is_overriden}bg-green-100{else}bg-red-100{/if} rounded-full flex items-center justify-center" aria-hidden="true">
											<span class="h-2 w-2 {if $override.is_overriden}bg-green-400{else}bg-red-400{/if} rounded-full"></span>
										</span>
									</span>
									<span class="ml-2">{if $override.is_overriden}{l s='Active' mod='module_override'}{else}{l s='Inactive' mod='module_override'}{/if}</span>
								</p>
								<form method="POST" action="">
									<input type="hidden" name="module_name" value="{$override.name}" />
									<input type="hidden" name="module_version" value="{$override.version}" />
									<input type="hidden" name="toggle_override" value="1" />
									<button type="submit" class="{if $override.is_overriden}bg-red-700 hover:bg-red-800 focus:ring-red-300{else}bg-green-700 hover:bg-green-800 focus:ring-green-300{/if} inline-flex items-center py-2 px-3 text-sm font-medium text-center text-white rounded-lg focus:ring-4 focus:outline-none mt-2 toggle_override">
										{if $override.is_overriden}{l s='Remove' mod='module_override'}{else}{l s='Apply' mod='module_override'}{/if} override
										<svg aria-hidden="true" class="ml-2 -mr-1 w-4 h-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M10.293 3.293a1 1 0 011.414 0l6 6a1 1 0 010 1.414l-6 6a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-4.293-4.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
									</button>
								</form>
							</div>
						</li>
						{/foreach}
	        </ul>
	      </div>
	    </div>
	  </div>
	</div>
</div>
