use super::pow::get_pow;

trait BitOperationTrait<
    T,
    impl TCopyImpl: Copy<T>,
    impl TDropImpl: Drop<T>,
    impl TAddImpl: Add<T>,
    impl TMulImpl: Mul<T>,
    impl TDivRemImpl: DivRem<T>,
    impl TZeroableImpl: Zeroable<T>,
    impl TTryIntoNonZeroImpl: TryInto<T, NonZero<T>>
> {
    fn left_shift(self: T, count: u128) -> T;
    fn right_shift(self: T, count: u128) -> T;
}

impl BitOperation_u256 of BitOperationTrait<u256> {
    fn left_shift(self: u256, count: u128) -> u256 {
        let (result, overflow) = integer::u256_overflow_mul(self, get_pow(count));
        result
    }

    fn right_shift(self: u256, count: u128) -> u256 {
        if count == 0 || self == 0 {
            self
        } else {
            let self = self / 2;
            let count = count - 1;
            self.right_shift(count)
        }
    }
}

impl BitOperation_u128 of BitOperationTrait<u128> {
    fn left_shift(self: u128, count: u128) -> u128 {
        let (result, overflow) = integer::u128_overflowing_mul(
            self, get_pow(count).try_into().expect("overflow")
        );
        result
    }

    fn right_shift(self: u128, count: u128) -> u128 {
        if count == 0 || self == 0 {
            self
        } else {
            let self = self / 2;
            let count = count - 1;
            self.right_shift(count)
        }
    }
}


// use debug::PrintTrait;
// #[test]
// #[available_gas(300000000)]
// fn test() {
//     let mut a: u128= 0xffffffffffffffffffffffffffffffff;
//     let (result, overflow) = integer::u128_overflowing_mul(a, 2);

//     result.print();
//     overflow.print();
// }
//
//
//
// #[test]
// #[available_gas(300000000000000000)]
// fn test() {
//     let mut a: u256 = 1;
//     let mut b: u128 = 32;
//     let mut result: u256 = a.left_shift(b);
//     assert(result == 4294967296, 'left shift over');

//     a = 10790968445514836887420556568130333820280245786666631176819668653671936254856;
//     b = 10;
//     result = a.left_shift(b);
//     assert(
//         result == 49703210662154407479406349940110585906323142310776741314870220608315409178624,
//         'left shift error'
//     );

//     let c: u256 = 128;
//     let d: u128 = 3;
//     result = c.right_shift(d);
//     assert(result == 16, 'right shift over');

//     let n: u256 = 104616311173140485099082100255315365365044651156030064548209934585479422322683;
//     let rr = n.right_shift(10);
//     let gg = n / 1024;

//     assert(rr == gg, 'sss');
// }


