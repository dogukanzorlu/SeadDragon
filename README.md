# SeadDragon

[SeadDragon](https://github.com/dogukanzorlu/SeadDragon) A simple ruby gem to encrypt json fields

# Table of Contents

* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
  * [Encrypt](#encrypt)
  * [Decrypt](#decrypt)

## Features

* Encyrpt json fields
* Decrypt json fields

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seaddragon', git: "https://github.com/dogukanzorlu/SeadDragon.git", :branch => "main"
```

Execute:

```bash
$ bundle install
```

## Usage

### Encrypt
```ruby
class EncryptJsonFields
  parse_json = JSON.parse('{username: "Joe", surname: "Doe", author: [{"username": "Mike", "surname": "Dave"}]}') 
  fields = "username,surname"
  # Key must be 32byte, IV must be 16byte
  encrypt = SeadDragon::SeadDragon.new(ENV["ENCRYPTED_KEY"], ENV["ENCRYPTED_IV"])
  result = encrypt.nested_hash_values(parse_json, fields, "encrypt").to_s
  
  render json: result 
  # => {username: "x9A:\xA2m\xD0", surname: "x9A:\xA2m\xD0", author: [{"username": "x9A:\xA2m\xD0", "surname": "x9A:\xA2m\xD0"}]}
end
```

### Decrypt

```ruby
class DecryptJsonFields
  parse_json = JSON.parse('{username: "x9A:\xA2m\xD0", surname: "x9A:\xA2m\xD0", author: [{"username": "x9A:\xA2m\xD0", "surname": "x9A:\xA2m\xD0"}]}') 
  fields = "username,surname"
  # Key must be 32byte, IV must be 16byte
  encrypt = SeadDragon::SeadDragon.new(ENV["ENCRYPTED_KEY"], ENV["ENCRYPTED_IV"])
  result = encrypt.nested_hash_values(parse_json, fields, "decrypt").to_s
  
  render json: result
  # => {username: "Joe", surname: "Doe", author: [{"username": "Mike", "surname": "Dave"}]}
end
```
