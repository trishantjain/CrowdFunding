// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    // Object
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    // This mapping is to access 'struct Campaign'
    // allows anyone to look up a Campaign struct by its integer ID.
    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    // '_' is to define that parameter is for only this function
    // 'memory' keyword with string parameter
    //* Function to Create Campaign
    function createCampaign(
        address _owner,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        string memory _image
    ) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns];

        // is everything okay?
        require(
            campaign.deadline < block.timestamp,
            "The deadline should be a date in the future."
        );

        // Below is executed if above condition is satisfied
        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    // 'payable' defines we are going to send some cryptocurrency throughout this function
    //* Function to Donate to Campaign
    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        // Checking if money is sent
        (bool sent, ) = payable(campaign.owner).call{value: amount}("");

        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    //* Function to Details of Donators
    function getDonators(
        uint256 _id
    ) public view returns (address[] memory, uint256[] memory) {
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    //* Function to Get all Campaign
    function getCampaigns() public view returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        for (uint i = 0; i < numberOfCampaigns; i++) {
            Campaign storage item = campaigns[i];
            allCampaigns[i] = item;
        }
    }
}
