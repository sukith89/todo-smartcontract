
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