// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SupplyChain {
    struct Step {
        Status status;
        string metadata;
    }

    enum Status {
        CREATED,
        READY_FOR_PICK_UP,
        PICKED_UP,
        READY_FOR_DELIVERY,
        DELIVERED
    }

    event RegisteredStep(
        uint256 productId,
        Status status,
        string metadata,
        address author
    );

    mapping(uint256 => Step[]) public products;

    function registerProduct(uint256 productId) public returns (bool success) {
        require(products[productId].length == 0, "This product already exists");
        products[productId].push(Step(Status.CREATED, ""));
        return success;
    }

    function registerStep(uint256 productId, string calldata metadata)
        public
        returns (bool success)
    {
        require(products[productId].length > 0, "This product doesn't exist");
        Step[] memory stepsArray = products[productId];
        uint256 currentStatus = uint256(
            stepsArray[stepsArray.length - 1].status
        ) + 1;
        if (currentStatus > uint256(Status.DELIVERED)) {
            revert("The product has no more steps");
        }
        Step memory step = Step(Status(currentStatus), metadata);
        products[productId].push(step);
        emit RegisteredStep(
            productId,
            Status(currentStatus),
            metadata,
            msg.sender
        );
        success = true;
    }
}
