{*<!-- {[The file is published on the basis of YetiForce Public License that can be found in the following directory: licenses/License.html]} --!>*}
<script type="text/javascript">
	
	YetiForce_Bar_Widget_Js('YetiForce_Alltimecontrol_Widget_Js',{},{
		loadChart : function() {
			var thisInstance = this;
			var chartData = thisInstance.generateData();
			var options = {
				xaxis: {
					minTickSize: 1,
					ticks: chartData['ticks']
				},
				yaxis: {
					min: 0 ,
					tickDecimals: 0
				},
				grid: {
					hoverable: true,
					clickable: true
				},
				series: {
					bars: {
						show: true,
						barWidth: 0.8,
						dataLabels: false,
						align: "center",
						lineWidth: 0,
					},
					stack: true
				},
				legend: {
					show: true,
			        labelFormatter: function(label, series) {
			      		return('<b>'+label+'</b>: '+chartData['legend'][label]+' h');
					}
				}
			};
			thisInstance.plotInstance = $.plot(thisInstance.getPlotContainer(false), chartData['chartData'], options);
		}
	});
</script>
<div class="dashboardWidgetHeader">
	{foreach key=index item=cssModel from=$STYLES}
		<link rel="{$cssModel->getRel()}" href="{$cssModel->getHref()}" type="{$cssModel->getType()}" media="{$cssModel->getMedia()}" />
	{/foreach}
	{foreach key=index item=jsModel from=$SCRIPTS}
		<script type="{$jsModel->getType()}" src="{$jsModel->getSrc()}"></script>
	{/foreach}
	<div class="row">
		<div class="col-md-8">
			<div class="dashboardTitle" title="{vtranslate($WIDGET->getTitle(), $MODULE_NAME)}"><strong>&nbsp;&nbsp;{vtranslate($WIDGET->getTitle(),$MODULE_NAME)}</strong></div>
		</div>
		<div class="col-md-4">
			<div class="box pull-right">
				{if Users_Privileges_Model::isPermitted('OSSTimeControl', 'CreateView')}
					<a class="btn btn-xs btn-default" onclick="Vtiger_Header_Js.getInstance().quickCreateModule('OSSTimeControl'); return false;">
						<span class='glyphicon glyphicon-plus' border='0' title="{vtranslate('LBL_ADD_RECORD')}" alt="{vtranslate('LBL_ADD_RECORD')}"></span>
					</a>
				{/if}
				<a class="btn btn-xs btn-default" href="javascript:void(0);" name="drefresh" data-url="{$WIDGET->getUrl()}&linkid={$WIDGET->get('linkid')}&content=data">
					<span class="glyphicon glyphicon-refresh" hspace="2" border="0" align="absmiddle" title="{vtranslate('LBL_REFRESH')}" alt="{vtranslate('LBL_REFRESH')}"></span>
				</a>
				{if !$WIDGET->isDefault()}
					<a class="btn btn-xs btn-default" name="dclose" class="widget" data-url="{$WIDGET->getDeleteUrl()}">
						<span class="glyphicon glyphicon-remove" hspace="2" border="0" align="absmiddle" title="{vtranslate('LBL_CLOSE')}" alt="{vtranslate('LBL_CLOSE')}"></span>
					</a>
				{/if}
			</div>
		</div>
	</div>
	<hr class="widgetHr"/>
	<div class="row" >
		<div class="col-sm-6">
			<div class="input-group input-group-sm">
				<span class=" input-group-addon"><span class="glyphicon glyphicon-calendar iconMiddle "></span></span>
				<input type="text" name="time" title="{vtranslate('LBL_CHOOSE_DATE')}" class="dateRange widgetFilter width90 form-control" value="{implode(',',$DTIME)}"/>
			</div>	
		</div>
		<div class="col-sm-6">
			{include file="dashboards/SelectAccessibleTemplate.tpl"|@vtemplate_path:$MODULE_NAME}
		</div>
	</div>
</div>

<div class="dashboardWidgetContent allTimeControl paddingBottom10">
	{include file="dashboards/TimeControlContents.tpl"|@vtemplate_path:$MODULE_NAME}
</div>

