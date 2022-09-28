# todo-smartcontract
solidity - html - css - javascript - web3 js - node js - npm - truffle - ganache - metamask


# first app - todo & block

[error](error%200df50c2bdd974a15815a2318587eec03.md)

# Aim

create a etherium smart contract with solidity - test against smart contract - deploy it to a blockchain - client side appication for todo list -

[Build Your First Blockchain App - Ethereum Todo List 2019](https://youtu.be/rzvk2kdjr2I)

- todos for creating this app
    
    connect the application with the web browser
    
    build client side application - in HTML CSS JAVASCRIPT
    
    connect the client side application to the blockchain
    
    create a smart contract
    
    create the to do list with etherium smart contract written in solidity
    
    compile and deploy to blockchain
    
    connect to blockchain network with personal account with etherium wallet in web browser
    
- tools required
    
    node JS (java script)
    
    Ganache - a personal blockchain (is like a real blockchain that public can access but its a local blockchain that run on your computer) - from blockchain development tools kit  (Ganache will make this run on server) - (develop smart contracts, run test agaist it, run scripts against he network, develop application that talk to this blockchain) 
    
    truffle framework - to develop etherium smart contract - with solidity. (develop smart contract, write test, deploy smart contracts to the blockchain, gives development console, develop client side application inside out project)
    
    metamask extention for google chrome (why? - etherium is a network - we need browser extension to connect to that network) - ( help - connect to blockchain with our personal account - interact with our smart contract) 
    

---

general setup for any blockchain project

# project setup

- means
    
    [terminal setup for m1](https://www.notion.so/terminal-setup-for-m1-56fd9ebbca214c9fac3bdd75e8acbe3a) 
    
    download node js from their website
    
    test if node install - $ node -v
    
    to download the latest npm version
    
    $ brew install npm
    
    ## build
    
    make a project directory (todo-app-one)
    
    $ truffle init
    
    create a package.json file - to pull development dependencies for the project
    
    $ touch package.json
    
    copy from github
    
    [https://github.com/dappuniversity/eth-todo-list/blob/master/package.json](https://github.com/dappuniversity/eth-todo-list/blob/master/package.json)
    
    npm install
    

# make contract

- means
    
    create smart contract file - use to build todo list
    
    - create a TodoList.sol
        
        ```jsx
        //declaring the solidity version using
        pragma solidity ^0.5.0;
        
        	
        //declaring the contract
        contract TodoList {
        	//initiate a variable that holds list count
        	//public allows to read the value
        	uint public taskCount = 0;
        
        }
        ```
        
    
    $ truffle compile - will create files in build - todolist.json - contains → abi  - bytecode (runs on etherium virtual machine)
    

# deploy - putting our smart contract in blockchain

- means
    
    connect this smart contract to the blockchian
    
    - update  truffle-config.js - configuration file -
        
        ```jsx
        module.exports = {
          networks: {
            development: {
              ///this is ganache (open ganache check server)
              host: "127.0.0.1",
              ///port ganache is running in
              port: 7545,
              network_id: "*" // Match any network id
            }
          },
          solc: {
            optimizer: {
              enabled: true,
              runs: 200
            }
          }
        }
        ```
        
    
    create a migration file 
    
    create as new migration file - named = 2_deploy_contracts.js  - in migration folder - what→ we are updating the state of blockchain - blockchain is a database of block in a chain - 
    
    copy code from another migration file in same folder
    
    - change code
        
        ```solidity
        const Todolist = artifacts.require("./TodoList.sol");
        
        module.exports = function(deployer) {
          deployer.deploy(Todolist);
        };
        ```
        
    
    $ truffle migrate - deploying the smart contract to the blockchain 
    
    result → decrease in etherium - in ganache
    
    > $ truffle migrate → runs migration files
    > 
    
    ---
    
    ![Screenshot 2022-08-02 at 2.41.24 PM.png](Screenshot_2022-08-02_at_2.41.24_PM.png)
    
    ---
    
    retriving smart contract from blockchain
    
    $ truffle console
    
    <> todoList = await TodoList.deployed()
    
    <> todoList
    
    to get the generated file
    
    <> todoList.address
    
    to get address
    
    <> todoList.taskCount()
    
    BN =0 
    
    we cant use this 
    
    so do this by retrieving
    
    <> todoList = await TodoList.taskCount()
    
    <> todoList.toNumber()
    
    built by truffle
    
    .sol → making contract
    
    .js → deploying contract
    

---

 

# making list

- TEST 1 : List tasks in the smart contract - as in contructor in Todolist.sol
    
    mske task in 
    
- TEST 2 : List tasks in the console - as in truffle
- TEST 3: List tasks in the client side application
- TEST 4: List tasks in the test

### in smart contract - TodoList.sol

```solidity
//code here

pragma solidity ^0.5.0;

contract Todolist {

	uint public taskCount = 0;

	struct Task {
		uint id;
		string content;
		bool done;

	}

	mapping(uint => Task) public tasks;

	function createTask(string memory _content) public {
		taskCount++;
		tasks[taskCount] = Task(taskCount, _content, false);
	}

	constructor() public {
		createTask("get milk");
		createTask("mail matt");
	}

}

```

# Making client side application

mkdir src 

cd src

touch index.html

touch app.js

## Browser sync configuration

bs config file - since we are using browser sync configuration

# web server - "lite-server": "^2.3.0"

 → package.json → "lite-server": "^2.3.0",  - to run client side application

create file bs-config.json 

- code
    
    ```json
    {
    	"server": {
    		"baseDir": [
    			"./src",
    			"./build/contracts"
    //we have to tell where todolist.json files are - src file - node files
    		], 
    		"routes": {
    		"/vendor": "./node_modules"
    		}
    	}
    }
    ```
    

## make a website

put code in index.html

- code
    
    ```html
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>Dapp University | Todo List</title>
    
        <!-- Bootstrap -->
        <link href="vendor/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    
        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    
        <style>
          main {
            margin-top: 60px;
          }
    
          #content {
            display: none;
          }
    
          form {
            width: 350px;
            margin-bottom: 10px;
          }
    
          ul {
            margin-bottom: 0px;
          }
    
          #completedTaskList .content {
            color: grey;
            text-decoration: line-through;
          }
        </style>
      </head>
      <body>
        <nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
          <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="http://www.dappuniversity.com/free-download" target="_blank">Dapp University | Todo List</a>
          <ul class="navbar-nav px-3">
            <li class="nav-item text-nowrap d-none d-sm-none d-sm-block">
              <small><a class="nav-link" href="#"><span id="account"></span></a></small>
            </li>
          </ul>
        </nav>
        <div class="container-fluid">
          <div class="row">
            <main role="main" class="col-lg-12 d-flex justify-content-center">
              <div id="loader" class="text-center">
                <p class="text-center">Loading...</p>
              </div>
              <div id="content">
                <!-- <form onSubmit="App.createTask(); return false;">
                  <input id="newTask" type="text" class="form-control" placeholder="Add task..." required>
                  <input type="submit" hidden="">
                </form> -->
                <ul id="taskList" class="list-unstyled">
                  <div class="taskTemplate" class="checkbox" style="display: none">
                    <label>
                      <input type="checkbox" />
                      <span class="content">Task content goes here...</span>
                    </label>
                  </div>
                </ul>
                <ul id="completedTaskList" class="list-unstyled">
                </ul>
              </div>
            </main>
          </div>
        </div>
    
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="vendor/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="vendor/truffle-contract/dist/truffle-contract.js"></script>
        <script src="app.js"></script>
      </body>
    </html>
    ```
    

## fill the uncompleated tasks in website(html)

run client side application using local server

```bash
$ npm run dev
```

# CLIENT SIDE APPLICATION ↔ BLOCKCHAIN(eth)  - WEB3.js

## make website talk to the blockchain? → with src/app.js

creating a way to talk to the blockchain - we want metamask use to connect to our dapp to talk to the blockchain - with web3.js

web3.js - read and write data btw blockchain and client side application

### BROWER ↔ BLOCKCHAIN  - METAMASK

- add this code from metamask website to app.js
    
    ```jsx
    //load web3 connection  - connection with blockchain
       // https://medium.com/metamask/https-medium-com-metamask-breaking-change-injecting-web3-7722797916a8
       connectToBlockchain: async () => {
        if (typeof web3 !== 'undefined') {
          App.web3Provider = web3.currentProvider
          web3 = new Web3(web3.currentProvider)
        } else {
          window.alert("Please connect to Metamask.")
        }
        // Modern dapp browsers...
        if (window.ethereum) {
          window.web3 = new Web3(ethereum)
          try {
            // Request account access if needed
            await ethereum.enable()
            // Acccounts now exposed
            web3.eth.sendTransaction({/* ... */})
          } catch (error) {
            // User denied account access...
          }
        }
        // Legacy dapp browsers...
        else if (window.web3) {
          App.web3Provider = web3.currentProvider
          window.web3 = new Web3(web3.currentProvider)
          // Acccounts always exposed
          web3.eth.sendTransaction({/* ... */})
        }
        // Non-dapp browsers...
        else {
          console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
        }
      }
    ```
    
    [https://medium.com/metamask/https-medium-com-metamask-breaking-change-injecting-web3-7722797916a8](https://medium.com/metamask/https-medium-com-metamask-breaking-change-injecting-web3-7722797916a8) this is updated. so use from github link for dapp universiry
    
- app.js code
    
    ```jsx
    App = {
        load: async () => {
            await App.connectToBlockchain()
    
            //await = waiting for metamask account(having eth) to connect to blockchain
            //continues executing only after connection is done ✅
            console.log('account is connected to blockchain')
        },
    
        connectToBlockchain: async () => {
            if (typeof web3 !== 'undefined') {
              App.web3Provider = web3.currentProvider
              web3 = new Web3(web3.currentProvider)
            } else {
              window.alert("Please connect to Metamask.")
            }
            // Modern dapp browsers...
            if (window.ethereum) {
              window.web3 = new Web3(ethereum)
              try {
                // Request account access if needed
                await ethereum.enable()
                // Acccounts now exposed
                web3.eth.sendTransaction({/* ... */})
              } catch (error) {
                // User denied account access...
              }
            }
            // Legacy dapp browsers...
            else if (window.web3) {
              App.web3Provider = web3.currentProvider
              window.web3 = new Web3(web3.currentProvider)
              // Acccounts always exposed
              web3.eth.sendTransaction({/* ... */})
            }
            // Non-dapp browsers...
            else {
              console.log('Non-Ethereum browser detected. You should consider trying MetaMask!')
            }
          }
    
    }
    
    $(() => {
        $(window).load(() => {
            App.load()
            console.log('banana')
        })
    })\
    ```
    

connect ganache virtual blockchain to metamask

make a network (local) (other than ethereum mainnet) in the metamask

copy rpc server, 1337, and ETH, any name to/in add network in metamask

make a new account in the metamask by importing private key of the ganache blockchain. when connected 

copy private key and paste it to metamask/account/import 

lets prove that website(src/app.js) is conected to the blockchain(ganach network) with the account (**0x2cC5BabbCdF56f28b0aE7B2FaC0F4236a234B000(the first one in ganache)**)

in code using async await  - code will continue executing only if it is connect
