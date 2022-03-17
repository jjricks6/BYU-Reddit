<!-- eslint-disable -->

<template>
  <v-card class="overflow-hidden">
    <v-sheet
      id="scrolling-techniques-7"
      class="overflow-y-auto"
    >
      <v-container >
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
        <!-- change later to Comments -->
        <div v-for="comment in comments" :key="comment.commentid"
        >
          <IndividualComment
            :commenttext="comment.commenttext"
            :commenter="comment.commenter"
            :parent_commentid="comment.parent_commentid"
            :comment_votescore="comment.comment_votescore"
            :commentid="comment.commentid"

          />
        </div>                  
      </v-container>
    </v-sheet>
  </v-card>
</template>

<script>
import Api from "../api";
import FullPost from "../components/FullPost.vue"
//import Comments from "../components/Comments.vue" 
import IndividualComment from "../components/IndividualComment.vue"  //change later to Comments.vue 

export default {
  components:{
    FullPost,
    //Comments
    IndividualComment            //change later to Comments.vue
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
      console.log(this.comments)
    });
  },
};
</script>