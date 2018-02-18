import React from 'react';

export default  React.createClass({
  handleSubmit: function(e) {
    e.preventDefault();

    let name = this.email.value;
    let description = this.description.value;

    const success = function(project) {
      var projects = this.state.data;
      projects.shift();
      projects.unshift(project);
      this.setState({data: projects});
    }

    if (!(name && description )) {return;}

        if (this.props.signedIn) {

          let data =JSON.stringify({project: {name: name, description: description}});
          this.props.optimisticUpdate({id: 'fake-id', name: name, description: description});
          this.props.writeToAPI('post', "/projects", data, success.bind(this));
          this.name.value = '';
          this.description.value = '';
        } else {
          alert('Please sign in to submit a project!');
        }
  },



  render: function() {
    return (
      <form  ref="projectForm" onSubmit={this.submitHandler}>
        <input type="text" placeholder="Project Name" name="name" ref={name => this.name = name} />
        <textarea  placeholder="Describe your project" name="description" ref={description => this.description = description}> </textarea>
        <button type="submit" className="">Create</button>
      </form>
    );
  }
});
