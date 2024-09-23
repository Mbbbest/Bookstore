//Not done with test yet

// use starknet::ContractAddress;

// use snforge_std::{declare, ContractClassTrait, DeclareResultTrait};

// // use Bookstore_contract::IBookstoreSafeDispatcher;
// // use Bookstore_contract::IBookstoreSafeDispatcherTrait;
// use bookstore_contract::IBookstoreDispatcher;
// use bookstore_contract::IBookstoreDispatcherTrait;

// fn deploy_contract(name: ByteArray) -> ContractAddress {
//     let contract = declare(name).unwrap().contract_class();
//     let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
//     contract_address
// }


// #[test]
// fn test_add_bookstore() {
//     let contract_address = deploy_contract("Bookstore");
//     let dispatcher = IBookstoreDispatcher { contract_address };
    
//     let book_id: felt252 = 1;
//     let name: felt252 = felt252::from_str("Cairo programming").unwrap();
//     let author: felt252 = felt252::from_str("Kevin Chibium").unwrap();
//     let price: felt252 = 1000;
    
//     dispatcher.add_book(book_id, name, author, price);
    
//     let added_book = dispatcher.get_book(book_id);
//     assert_eq!(added_book.name, name);
//     assert_eq!(added_book.author, author);
//     assert_eq!(added_book.price, price);
// }
