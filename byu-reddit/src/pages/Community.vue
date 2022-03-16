<template>
  <v-card>
      <v-container>
        <v-row>
              <v-col>
                <v-avatar size="200">
                  <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/' + community.communitypicture"/>
                </v-avatar>
              </v-col>
              <v-col cols=7>
                <v-row dense>
                  <v-col>
                    <v-card-title><h1>{{ community.communityname }}</h1></v-card-title>
                    <v-card-subtitle>{{ community.description }}</v-card-subtitle>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="2">
                <v-btn @click="overlay = !overlay">
                  Add Post
                  <v-icon>
                    mdi-plus
                  </v-icon>
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
                        <CreatePost
                          :community="this.community.communityname"
                          :community_picture="this.community.communitypicture"
                        />
                  </v-container>
                  
                </v-overlay>
              </v-col>
        </v-row>
      </v-container>
    <v-sheet
      id="scrolling-techniques-7"
      class="overflow-y-auto"
    >
      <v-container >
        <v-row>
        </v-row>
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
import CreatePost from "../components/CreatePost.vue"

export default {
  components:{
    Post,
    CreatePost
  },
  name: "CommunityPage",
  data: function () {
    return {
      overlay: false,
      zIndex: 1,
      community: [],
      posts: [],
      filter_items: ["Top", "Popular"]
    };
  },
  created: function () {
    this.loading = true;
    console.log(this.$route)
    Api.getCommunity(this.$route.params.communityname).then((res) => {
      this.community = res.data[0];
      this.posts = res.data;
    });
  },
};
</script>

<style>
.title {
  font-size: 100;
}
</style>