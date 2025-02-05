# Writeup

Extract base64-encoded wasm binary from the `luigi.html`.

Decode the binary `cat luigi.b64 | base64 -d > luigi.wasm`.

Inspect binary `wasm-objdump -x ./luigi.wasm`.

Notice some interesting exports:
```
- func[2] <get_flag_ptr> -> "get_flag_ptr"
- func[3] <get_flag_len> -> "get_flag_len"
- func[4] <decrypt_flag> -> "decrypt_flag"
```

Extend the script in `luigi.html` to solve the chall.

```js
const flag_ptr = luigi.get_flag_ptr();
const flag_len = luigi.get_flag_len();
luigi.decrypt_flag(flag_ptr, flag_len);
const flag_buffer = memory.slice(flag_ptr, flag_ptr + flag_len);
const flag = new TextDecoder().decode(flag_buffer);
console.log(await flag);
```
