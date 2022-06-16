// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Event {
    event newEventCreated(string _event);

    mapping(address => mapping(uint256 => string)) public events;
    mapping(address => uint256) public eventsCounter;
    uint256 public threshold;
    address private owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can execute this function");
        _;
    }

    constructor(uint256 _threshold) {
        threshold = _threshold;
        owner = msg.sender;
    }

    function createEvent(string memory _event) public returns (bool success) {
        uint256 eventId = eventsCounter[msg.sender] + 1;
        if (eventId > threshold) {
            eventId = 1;
        }
        eventsCounter[msg.sender] = eventId;
        events[msg.sender][eventId] = _event;
        emit newEventCreated(_event);
        success = true;
    }

    function setThreshold(uint256 _threshold) public onlyOwner {
        threshold = _threshold;
    }
}
