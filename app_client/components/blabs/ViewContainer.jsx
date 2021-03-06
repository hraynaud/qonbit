import React from 'react';
import View from'./View.jsx';

export default React.createClass({
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
      this.readBlabsFromAPI();
  },

  readBlabsFromAPI: function() {
    this.props.readFromAPI(this.props.origin + '/blabs', function(blabs) {
      this.setState({data: blabs});
    }.bind(this));
  },
  optimisticUpdate: function(blab) {
    var blabs = this.state.data;
    blabs.unshift(blab);
    this.setState({data: blabs});
  },
  writeBlabToAPI: function(data) {
    this.props.writeToAPI('post', this.props.origin + '/blabs', data, function(blab) {
      var blabs = this.state.data;
      blabs.shift();
      blabs.unshift(blab);
      this.setState({data: blabs});
    }.bind(this));
  },
  render: function() {
    return (
      <View  writeBlabToAPI={this.writeBlabToAPI} optimisticUpdate={this.optimisticUpdate} currentUser={this.props.currentUser} signedIn={this.props.signedIn} data={this.state.data}/>
    );
  }
});
