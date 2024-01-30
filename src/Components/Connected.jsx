import React from "react";

const Connected = (props) => {
    return (
        <div className="connected-container">
            <h1 className="connected-header">You Are Connected To Metamask</h1>
            <p className="connected-account">Metamask Account: {props.account}</p>
            <p className="connected-account">Remaining Time For Voting: {props.remainingTime}</p>
            { props.showButton ? (
                <p className="connected-account">You Have Already Voted</p>
            ) : (
                <div>
                    <input type="number" placeholder="Entern Candidate Index" value={props.number} onChange={props.handleNumberChange}></input>
            <br />
            <button className="login-button" onClick={props.voteFunction}>Vote</button>

                </div>
            )}
            
            <table id="myTable" className="candidates-table">
                <thead>
                <tr>
                    <th>Index</th>
                    <th>Candidate Name</th>
                    <th>Candidate Votes</th>
                </tr>
                </thead>
                <tbody>
                {props.candidates.map((candidate, index) => (
                    <tr key={index}>
                    <td>{candidate.index}</td>
                    <td>{candidate.name}</td>
                    <td>{candidate.voteCount}</td>
                    </tr>
                ))}
                </tbody>
            </table>
            
        </div>
    )
}

export default Connected;