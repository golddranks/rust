#!/bin/sh -e

echo '
fn comma() { print!(", "); }
fn main() {
	let _who = "Nyarlathotep";
	print!("Hello");
	comma();
	println!("World!");
}' > test.rs
rustc -g test.rs
rm test.rs
echo '
breakpoint set --name comma
run
next
frame variable
exit' > test_lldb_batch.txt
python lldb_batchmode.py test test_lldb_batch.txt | grep 'Nyarlathotep'
rm test_lldb_batch.txt
