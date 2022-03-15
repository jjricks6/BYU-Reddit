<template>
  <component :is="tag" class="comment-details">
    <v-layout row wrap align-baseline>
      <v-flex xs12 class="comment-details__comment">
        <span class="comment__metadata">
          <strong>{{ comment.author }}</strong> &bull;
          <span :title="comment.modified_date">{{ formattedTimestamp }}</span>
        </span>
        
        <span class="comment-details__comment">{{ comment.comment }}</span>
        
        <button
          v-if="!isReadOnly && activeReply_ !== comment.id"
          @click.stop="handleReplyClick(comment.id)"
          class="comment-details__button"
          type="button"
        >Reply</button>
      </v-flex>

      <comment-form
        :parent="comment"
        @input="$emit('input', $event)"
        @saved="activeReply_ = null"
        class="flex xs12 comment-details__reply"
        v-if="activeReply_ === comment.id"
        :value="getComment(`tmp_${comment.id}`)"
        :ref="`commentReplyForm_${comment.id}`"
        v-bind="{commentableId: comment.commentable_id, commentableType: comment.commentable_type}"
      />

      <ul
        v-if="showReplies && comment.children.length > 0"
        class="comment-details__children flex xs12"
      >
        <comment-details
          :activeReply.sync="activeReply_"
          :key="[$options.name, childComment.id].join('_')"
          :newCommentMap.sync="newCommentMap_"
          @input="$emit('input', $event)"
          showReplies
          v-bind="{comment: childComment, isReadOnly}"
          v-for="childComment in comment.children"
        />
      </ul>
    </v-layout>
  </component>
</template>
<script>
import moment from "moment";

import commentForm from "./comment-form.vue";

export default {
  name: "comment-details",

  props: {
    /**
     * The comment of which to show details
     */
    comment: {
      type: Object /** @type {Comment} */,
      required: true
    },

    /**
     * Whether to disable comment actions
     */
    isReadOnly: Boolean,

    /**
     * Whether to show comment replies
     */
    showReplies: Boolean,

    /**
     * The ID of the comment to which the user is currently replying
     */
    activeReply: {
      type: [String, Number, Boolean],
      default: false
    },

    /**
     * A list of new comments
     */
    newCommentMap: {
      type: Array,
      default() {
        return [];
      }
    }
  },

  computed: {
    /**
     * @returns {string}
     */
    tag() {
      return this.showReplies ? "li" : "div";
    },

    /**
     * Get the comment timestamp, formatted as a relative date
     * @returns {string}
     */
    formattedTimestamp() {
      return moment(this.comment.modified_date).fromNow();
    },

    /**
     * Prevent mutating state by using a instance of `activeReply`, and emit any changes.
     * @returns {number}
     * @see this.activeReply
     */
    activeReply_: {
      get() {
        if (
          this.newCommentMap.findIndex(
            comment => comment.id === `tmp_${this.comment.id}`
          ) !== -1
        ) {
          return this.comment.id;
        }

        return this.activeReply;
      },
      set(parentId) {
        if (this.activeReply === parentId) return;

        // Remove the discarded comment
        let newCommentMapClone = this.newCommentMap.slice();
        let previousReplyIndex = newCommentMapClone.findIndex(
          comment => comment.id === `tmp_${this.activeReply}`
        );
        newCommentMapClone.splice(previousReplyIndex, 1);

        this.$emit("update:newCommentMap", newCommentMapClone);

        // Emit the new active reply
        this.$emit("update:activeReply", parentId);
      }
    },

    /**
     * Prevent mutating state by using a instance of `newCommentMap`, and emit any changes.
     * @returns {Array}
     * @see this.newCommentMap
     */
    newCommentMap_: {
      get() {
        return this.newCommentMap;
      },
      set(newCommentMap) {
        // Emit the new comment map
        this.$emit("update:newCommentMap", newCommentMap);
      }
    }
  },

  methods: {
    handleReplyClick(commentId) {
      // Update the active reply
      this.activeReply_ = commentId;

      // Focus the input
      this.$nextTick(function() {
        this.$refs[`commentReplyForm_${commentId}`].$refs.input.focus();
      });
    },

    getComment(id) {
      return this.newCommentMap_.find(comment => comment.id === id);
    }
  },

  components: {
    commentForm
  }
};
</script>

<style scoped>
.comment-details {
  margin: 20px 0;
  padding-left: 10px;
  list-style: none;
  border-left: 2px solid #eee;
}

.comment__metadata {
  display: block;
  color: gray;
  margin-bottom: 5px;
  font-size: 12px;
}

.comment-details__children,
.comment-details__reply {
  margin-left: 25px !important;
}

.comment-details__button {
  display: block;
  color: #1976d2;
  font-size: 12px;
  margin: 5px 0;
  padding: 0;
  border: 0;
  cursor: pointer;
}

.comment-details__button:hover,
.comment-details__button:focus {
  text-decoration: underline;
}
</style>
