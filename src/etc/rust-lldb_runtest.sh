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
(echo '
breakpoint set --name comma
run'
sleep 2
echo 'next'
sleep 1
echo 'frame variable'
sleep 1
echo 'exit') | src/etc/rust-lldb test | grep 'Nyarlathotep'
