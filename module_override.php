<?php
/**
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
*/

if (!defined('_PS_VERSION_')) {
    exit;
}

class Opensaas_core extends Module
{
    protected $config_form = false;

    public function __construct()
    {
        $this->name = 'module_override';
        $this->tab = 'front_office_features';
        $this->version = '1.0.0';
        $this->author = 'Marco Ingraiti';
        $this->need_instance = 0;

        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Module Override');
        $this->description = $this->l('Add overrides to Prestashop module php behaviours with a reversible management system');

        $this->ps_versions_compliancy = array('min' => '1.7', 'max' => _PS_VERSION_);
    }


    public function install()
    {
        return parent::install() &&
            $this->registerHook('backOfficeHeader')
    }


    public function hookBackOfficeHeader()
    {
        if (Tools::getValue('configure') == $this->name) {
            $this->context->controller->addCSS($this->_path.'views/css/back.css');
            $this->context->controller->addJs($this->_path.'views/js/back.js');
        }
    }

    public function getAvailableOverrides()
    {
        $override_folders = glob($this->local_path."module_overrides/*");
        $available_overrides = [];
        foreach($override_folders as $module_path){
            $module_name = explode("/", $module_path);
            $module_name = end($module_name);
            $is_installed = Module::isInstalled($module_name);
            if($is_installed === true){
                $module_instance = Module::getInstanceByName($module_name);
                $version_exist = is_dir($module_path."/".$module_instance->version);
                if($version_exist === true){
                    $available_overrides[$module_name] = [
                        "name" => $module_name,
                        "version" => $module_instance->version,
                        "is_overriden" => (bool)trim(file_get_contents($module_path."/".$module_instance->version."/.override"))
                    ];
                }
            }
        }
        return $available_overrides;
    }


    public function getContent()
    {
        if (((bool)Tools::isSubmit('toggle_override')) == true) {
            $this->toggleOverride();
        }
        $overrides = $this->getAvailableOverrides();
        $this->context->smarty->assign('available_overrides', $overrides);
        $output = $this->context->smarty->fetch($this->local_path.'views/templates/admin/configure.tpl');
        return $output;
    }


    protected function toggleOverride()
    {
        $ds = DIRECTORY_SEPARATOR;
        $module_name = $_POST["module_name"] ?? NULL;
        $module_version = $_POST["module_version"] ?? NULL;
        $module_path = $this->local_path."module_overrides$ds$module_name$ds$module_version$ds";
        $override_path = $module_path.".override";
        $is_overriden = (bool)trim(file_get_contents($override_path));
        $new_overriden = $is_overriden ? 0 : 1;
        $source = $module_path;
        $dest = _PS_CORE_DIR_.$ds."modules$ds$module_name$ds";
        foreach(
            $iterator = new \RecursiveIteratorIterator(
                new \RecursiveDirectoryIterator($source, \RecursiveDirectoryIterator::SKIP_DOTS),
                \RecursiveIteratorIterator::SELF_FIRST) as $item
            ){
                if($item->isDir()){
                    mkdir($dest . $ds . $iterator->getSubPathname());
                }else{
                    $sub_path = $iterator->getSubPathname();
                    if(strpos($item, ".override") !== false) continue;
                    if($new_overriden){
                        if(strpos($item, ".original") !== false) continue;
                    }else{
                        if(strpos($item, ".original") === false) continue;
                        $sub_path = str_replace(".original", "", $sub_path);
                    }
                    copy($item, $dest . $sub_path);
                }
            }
            file_put_contents($override_path, $new_overriden);
    }

}
