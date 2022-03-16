/* eslint-disable */

<template>
  <v-card class="overflow-hidden">
    <v-sheet
      id="scrolling-techniques-7"
      class="overflow-y-auto"
    >
      <v-container >
        <v-row>
          <v-col cols="8">
            <v-card-title>
              Explore
            </v-card-title>
          </v-col>
          <v-spacer></v-spacer>
          <v-col cols="2.5">
            <v-btn plain @click="overlay = !overlay">
              Create Community
            </v-btn>
            <v-overlay
              z-index="1"
              :value="overlay"
              opacity=".9"
              >
              <v-container>
                <v-row>
                <v-col cols="11">
                  </v-col>
                  <v-col cols="1">
                    <v-btn icon>
                        <v-icon @click="overlay = false">
                            mdi-close
                        </v-icon>
                    </v-btn>
                  </v-col>
                </v-row>
                    <CreateCommunity/>
              </v-container>
            </v-overlay>
          </v-col>
        </v-row>
        <v-row>
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
import CreateCommunity from "../components/CreateCommunity.vue"

export default {
  components:{
    Post,
    CreateCommunity
  },
  name: "HomePage",
  data: function () {
    return {
      loading: false,
      overlay: false,
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