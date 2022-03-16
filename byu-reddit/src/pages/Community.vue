<template>
  <v-card>
      <v-container>
        <v-row>
              <v-col>
                <v-avatar size="200">
                  <img :src="'https://byu-reddit-media.s3.us-west-2.amazonaws.com/' + community.communitypicture"/>
                </v-avatar>
              </v-col>
              <v-col cols=9>
                <v-row dense>
                  <v-col>
                    <v-card-title><h1>{{ community.communityname }}</h1></v-card-title>
                    <v-card-subtitle>{{ community.description }}</v-card-subtitle>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col>
                      
                  </v-col>
                </v-row>
              </v-col>
        </v-row>
      </v-container>
    <v-sheet
      id="scrolling-techniques-7"
      class="overflow-y-auto"
    >
      <v-container >
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
  name: "CommunityPage",
  data: function () {
    return {
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