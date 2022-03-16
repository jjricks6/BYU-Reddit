/* eslint-disable */

<template>
  <v-card class="overflow-hidden">
    <v-sheet
      id="scrolling-techniques-7"
      class="overflow-y-auto"
    >
      <v-container >
        <v-row>
          <v-card-title>
            Explore
          </v-card-title>
        </v-row>
        <v-row>
        <!-- Filter -->
          <v-col cols='3'>
            <v-select
              :items="filter_items"
              default="hot"
              dense
              prepend-icon="mdi-fire"
            ></v-select>
          </v-col>
        </v-row>
        <!-- We need to figure out how to load more as you scroll-->
        <div v-for="post in posts" :key="post.id"
        >
          <Post
            :id="post.postid"
            :title="post.posttitle"
            :content="post.postcontent"
            :community="post.communityname"
            :community_picture="post.communitypicture"
            :time_posted="post.postdatetime"
            :vote_score="post.votescore"
            :num_comments="post.num_comments"
          />
        </div>
      </v-container>
    </v-sheet>
  </v-card>
</template>

<script>
import Api from "../api";
import Post from "../components/Post.vue"

export default {
  components:{
    Post
  },
  name: "HomePage",
  data: function () {
    return {
      loading: false,
      posts: [],
      filter_items: ["Top", "Popular"]
    };
  },
  created: function () {
    this.loading = true;
    Api.getExplore().then((res) => {
      this.posts = res.data;
      this.loading = false;
    });
  },
};
</script>