// Bookstore contract 
// add book
// update book price
// get book

#[derive(Copy, Drop, Serde, starknet::Store)]
struct Book {
    name: felt252,
    author: felt252,
    price: felt252,
    owner: felt252,
}

#[starknet::interface]
pub trait IBookstore<TContractState> {
    fn add_book(ref self: TContractState, book_id: felt252, name: felt252, author: felt252, price: felt252);
    fn update_book_price(ref self: TContractState, book_id: felt252, new_price: felt252);
    fn get_book(self: @TContractState, book_id: felt252) -> Book;
}

#[starknet::contract]
pub mod Bookstore {
    use super::{Book, IBookstore};
    use core::starknet::{
        get_caller_address, ContractAddress,
        storage::{Map, StorageMapReadAccess, StorageMapWriteAccess}
    };

    #[storage]
    struct Storage {
        books: Map<felt252, Book>, // map book_id => Book struct
        owner_address: ContractAddress,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        BookAdded: BookAdded,
        BookPriceUpdated: BookPriceUpdated
    }

    #[derive(Drop, starknet::Event)]
    struct BookAdded {
        name: felt252,
        book_id: felt252,
        author: felt252,
        price: felt252
    }

    #[derive(Drop, starknet::Event)]
    struct BookPriceUpdated {
        name: felt252,
        book_id: felt252,
        new_price: felt252
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner_address: ContractAddress) {
        self.owner_address.write(owner_address)
    }

    #[abi(embed_v0)]
    impl BookstoreImpl of IBookstore<ContractState> {
        fn add_book(ref self: ContractState, book_id: felt252, name: felt252, author: felt252, price: felt252) {
            let owner_address = self.owner_address.read();

            assert(get_caller_address() == owner_address, 'Only owner can add books');
            let book = Book { name, author, price, owner: 0 };

            self.books.write(book_id, book);

            self.emit(BookAdded { name, book_id, author, price })
        }

        fn update_book_price(ref self: ContractState, book_id: felt252, new_price: felt252) {
            let owner_address = self.owner_address.read();

            assert(get_caller_address() == owner_address, 'Cannot update book price');
            let mut book = self.books.read(book_id);
            book.price = new_price;
            self.books.write(book_id, book);

            self.emit(BookPriceUpdated { name: book.name, book_id, new_price })
        }

        fn get_book(self: @ContractState, book_id: felt252) -> Book {
            self.books.read(book_id)
        }
    }
}