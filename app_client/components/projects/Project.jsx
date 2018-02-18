import React from 'react';


export default React.createClass({
  render: function() {
    return (
      <li className="project">
      <span className="project-description">{this.props.description}: </span>
      <span className="project-name">{this.props.name}</span>
      </li>
    );
  }
});
