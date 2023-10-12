fn keccak_evm(input: Span<u256>) -> u256 {
    let output: u256 = keccak::keccak_u256s_be_inputs(input);

    (u256 {
        low: integer::u128_byte_reverse(output.high), high: integer::u128_byte_reverse(output.low)
    })
}
