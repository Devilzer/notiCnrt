// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract Notes {
    struct Note {
        uint id;
        string content;
        bool isDeleted;
    }

    mapping(address => mapping(uint => Note)) private notes;
    mapping(address => uint) private noteCount;

    function createNote(string calldata _content) external {
        uint currentId = noteCount[msg.sender]++;
        notes[msg.sender][currentId] = Note(currentId, _content, false);
    }

    function readNote(uint _id) external view returns (string memory) {
        require(!notes[msg.sender][_id].isDeleted, "Note is deleted");
        return notes[msg.sender][_id].content;
    }

     function updateNote(uint _id, string calldata _newContent) external {
        require(!notes[msg.sender][_id].isDeleted, "Note is deleted");
        notes[msg.sender][_id].content = _newContent;
    }

    function deleteNote(uint _id) external {
        require(!notes[msg.sender][_id].isDeleted, "Note is already deleted");
        notes[msg.sender][_id].isDeleted = true;
    }

    function getNoteCount() external view returns (uint) {
        return noteCount[msg.sender];
    }



}