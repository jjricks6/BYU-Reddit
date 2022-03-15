<!-- eslint-disable -->

<template>
  <v-card class="overflow-hidden">
    <v-sheet
      id="scrolling-techniques-7"
      class="overflow-y-auto"
    >
      <v-container >
        <!-- We need to figure out how to load more as you scroll-->
        <FullPost
          :id="this.post.id"
          :title="this.post.posttitle"
          :content="this.post.postcontent"
          :community="this.post.poster_username"
          :community_picture="this.post.profilepicture"
          :time_posted="this.post.postdatetime"
          :vote_score="this.post.post_votescore"
          :num_comments="this.post.num_comments"
        />
        <!-- Insert comment component here. You will have ot pass in props just like we are doing with FullPost above-->
        <Comments/>
      </v-container>
    </v-sheet>
  </v-card>
</template>

<script>
import Api from "../api";
import FullPost from "../components/FullPost.vue"
import Comments from "../components/Comments.vue"

export default {
  components:{
    FullPost,
    Comments
  },
  name: "PostPage",
  data: function () {
    return {
      loading: false,
      post: [],
      comments: [],
      filter_items: ["Top", "Popular"]
    };
  },
  created: function () {
    this.loading = true;
    console.log(this.$route)
    Api.getPost(this.$route.params.id).then((res) => {
      this.post = res.data[0];
      this.comments = res.data;
      console.log(this.post)
    });
  },
};
</script>