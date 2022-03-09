<template>
  <div>
    <div v-if="loading">Loading posts....</div>
    <br /><br />
    <b-table-simple hover small caption-top responsive>
      <b-thead>
        <b-tr>
          <b-th>Title</b-th>
          <b-th>userid</b-th>
          <b-th>date</b-th>
        </b-tr>
      </b-thead>
      <b-tbody>
        <b-tr v-for="post in posts" :key="post.postid">
          <b-td>{{ post.title }}</b-td>
          <b-td>{{ post.userid }}</b-td>
          <b-td>{{ post.content }}</b-td>
        </b-tr>
      </b-tbody>
    </b-table-simple>
  </div>
</template>

<script>
import Api from "../api";

export default {
  name: "PostList",
  data: function () {
    return {
      loading: false,
      articles: [],
    };
  },
  created: function () {
    this.loadPosts();
  },

  methods: {
    loadPosts() {
      this.loading = true;
      this.articles = [];
      Api.getPosts().then((res) => {
        this.articles = res.data;
        this.loading = false;
      });
    },
  },
};
</script>