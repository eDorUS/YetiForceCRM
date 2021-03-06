<?php
/*+***********************************************************************************************************************************
 * The contents of this file are subject to the YetiForce Public License Version 1.1 (the "License"); you may not use this file except
 * in compliance with the License.
 * Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
 * See the License for the specific language governing rights and limitations under the License.
 * The Original Code is YetiForce.
 * The Initial Developer of the Original Code is YetiForce. Portions created by YetiForce are Copyright (C) www.yetiforce.com. 
 * All Rights Reserved.
 *************************************************************************************************************************************/
class OSSPasswords_CheckPass_Action extends Vtiger_Action_Controller {

	public function checkPermission(Vtiger_Request $request)
	{
		$moduleName = $request->getModule();
		$moduleModel = Vtiger_Module_Model::getInstance($moduleName);

		$userPrivilegesModel = Users_Privileges_Model::getCurrentUserPrivilegesModel();
		$permission = $userPrivilegesModel->hasModulePermission($moduleModel->getId());

		if (!$permission) {
			throw new \Exception\NoPermitted('LBL_PERMISSION_DENIED');
		}
	}
	public function process(Vtiger_Request $request) {
		$moduleName = $request->getModule();
		$password = $request->get('password');
		
        $recordModel = Vtiger_Record_Model::getCleanInstance( $moduleName );
        
		$passOK = $recordModel->checkPassword( $password );
		
		if ( $passOK['error'] === true ) {
			$result = array( 'success' => false, 'message' => $passOK['message'] );
		}
		else {
			$result = array( 'success' => true, 'message' => '' );
		}
        
		$response = new Vtiger_Response();
		$response->setResult($result);
		$response->emit();
	}
}
