<template>
  <div>
    <b-jumbotron>
      <p>Welcome to BYU Reddit!</p>
      <b-button href="/#/Login">
        Login
      </b-button>
    </b-jumbotron>
    
    <br />
    <div v-if="loading">Loading Posts....</div>
    <ul v-else>
      <li v-for="post in posts" :key="post.postid">
        <router-link :to="`Community/${post.communityid}/${post.postid}`">{{
          post.postcontent
        }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "HomePage",
  data: function () {
    return {
      loading: false,
      posts: [],
    };
  },
  created: function () {
    this.loading = true;
    Api.getFeed().then((res) => {
      this.posts = res.data;
      this.loading = false;
    });
  },
};
</script>