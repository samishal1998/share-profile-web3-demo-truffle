pragma solidity >=0.4.22 <0.9.0;

contract Accounts {
    address private owner;

    struct Account {
        string handle;
        string name;
        string subtitle;
        address owner;
        string profileImg;
        Link[] links;
    }


    struct Link {
        string label;
        string url;
        uint256 etherLimit;
        bool enabled;
        string thumbnail;
    }

    mapping(address => Account) private accounts;
    mapping(string => address) handles;


    constructor(){
        owner = msg.sender;

        // accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A];
        accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A].handle = "sami.01";
        accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A].name = "Sami 01";
        accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A].owner = 0x706a1415bc5ea0576B5a93bEe633F87E62CA759A;
        accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A].profileImg = "QmaCRdnW13YkDF9uXeYTPp2DNd2LYc5UsveZ6fo1PswBCH";
        accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A].links.push(Link("Knot","https://app.myknot.co/u/sami.mishal", .2 ether,true,"QmfHL3hPKLyFXoFMVozPSGkHQhwsgq7rcdgKckwBoxGGjh"));
        accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A].links.push(Link("WhatsApp","https://wa.me/201010187812", 0.2 ether,true, "QmWz3jsv16qunjMqCxwr4SxdTRwHR29uk1Cwp52jdzvNmh"));
        accounts[0x706a1415bc5ea0576B5a93bEe633F87E62CA759A].links.push(Link("WhatsApp PERSONAL","https://wa.me/20158199897", 1 ether,true, "QmWz3jsv16qunjMqCxwr4SxdTRwHR29uk1Cwp52jdzvNmh"));
        handles["sami.01"] = 0x706a1415bc5ea0576B5a93bEe633F87E62CA759A;

        // accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf];
        accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf].handle = "sami.02";
        accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf].name = "Sami 02";
        accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf].owner = 0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf;
        accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf].profileImg = "QmbBHM7hxdRPg9jhxBgR7vLof7ZJyk6Dya1AXvh5jzATJe";
        accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf].links.push(Link("Github","https://github.com/samishal1998", 0.3 ether,true,"QmfQRrpwfPL77tj3GXzKxb5wGP184Y2p8Ro8svCFqvUYpg"));
        accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf].links.push(Link("LinkedIn","https://www.linkedin.com/in/sami-mishal-612261161/",0.3 ether,true,"QmTK6cN84rE2UAYSLWb2wAiyvi1Uv7RwKGMByiJJ5miQqS"));
        accounts[0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf].links.push(Link("Facebook","https://www.facebook.com/samy.mishal/",2 ether,true,"QmfEjavziBL7wmgCWZVvqETtETEoCFqKFZELyzF98N312N"));
        handles["sami.02"] = 0x4c8C8Eb8A0cdEB8D448d485baAC488065326dbAf;


    }




    function getAccount(string memory _handle)  public  view returns (Account memory) {
        address accountAddress = handles[_handle];
        require(accountAddress != address(0), "no-account-associated-with-handle");

        Account memory account = accounts[accountAddress];

        for(int i = int(account.links.length - 1); i >= 0; i--){
            if(account.links[uint(i)].etherLimit > msg.sender.balance){
                delete account.links[uint(i)];
            }
        }
        return account;
    }

    function createAccount(Account memory _account) public {

        require(handles[_account.handle] == address(0),"Handle is already used");
        require(_account.owner != address(0), "Invalid Owner Address");
        //check if address is already used


        accounts[_account.owner].handle = _account.handle;
        accounts[_account.owner].name = _account.name;
        accounts[_account.owner].owner = _account.owner;
        delete accounts[_account.owner].links;
        for(uint i = 0; i<_account.links.length; i++){
            accounts[_account.owner].links.push(_account.links[i]);
        }
        handles[_account.handle] = _account.owner;

    }
}