

$_=<>;
chomp;
$prev_line=$_;
my @e=split;
$prev = $e[0];

while(<>){chomp;
	my @e=split;
	if($e[0] ne $prev){
		$prev_line.="<hr>"
	}
	print $prev_line."\n";
	$prev_line=$_;
	$prev = $e[0];
} 
print $prev_line;
