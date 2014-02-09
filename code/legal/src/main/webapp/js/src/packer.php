<?php
define('APPROOT', 'x:\\webapps\\qdds.gov.cn\\zixun\\web\\');
require_once APPROOT . 'js\\src\\class.JavaScriptPacker.php';

function encode($source, $mark, $en = true) {
	echo ' => ' . $source;
	$script = file_get_contents(APPROOT . $source);
	$t1 = microtime(true);
	if ($en) {
		$packer = new JavaScriptPacker($script, 'Normal', false, false);
		$packed = $packer->pack();
	} else {
		$packed = $script;
	}
	$t2 = microtime(true);
	$time = sprintf('%.4f', ($t2 - $t1));
	echo " 用时(" . $time . " s)\n";
	if ($mark)
		$mark .= '// ' . $mark . "\n";
	return $mark . $packed;
}
function encode2($source, $mark) {
	echo ' => ' . $source;
	$t1 = microtime(true);
	$script = '';
	foreach ($source as $js) {
		$script .= "\n" . file_get_contents(APPROOT . 'js\\src\\' . $js);
	}
	$packer = new JavaScriptPacker($script, 'Normal', false, false);
	$packed = $packer->pack();
	$t2 = microtime(true);
	$time = sprintf('%.4f', ($t2 - $t1));
	echo " 用时(" . $time . " s)\n";
	if ($mark)
		$mark .= '// ' . $mark . "\n";
	return $mark . $packed;
}
echo "<pre>\n";
echo "================开始混淆JS================\n";
$js_outer_str = encode2(array (
	'qdds.js',
	'qdds_im.js'
), '');
file_put_contents(APPROOT . 'zixun\\js\\qdds.js', $js_outer_str);
$js_outer_str = encode2(array (
	'qdds.js',
	'qdds_usr.js'
), '');
file_put_contents(APPROOT . 'zixun\\js\\qdds_manage.js', $js_outer_str);
$js_outer_str = encode2(array (
	'qdds.js',
	'qdds_client.js'
), '');
file_put_contents(APPROOT . 'zixun\\js\\client.js', $js_outer_str);
$js_outer_str = encode2(array (
	'qddsim.js'
), '');
file_put_contents(APPROOT . 'zixun\\js\\qddsim.js', $js_outer_str);

echo "ok.\n\nthe end\n</pre>";
?>