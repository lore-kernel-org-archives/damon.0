Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784817729
	for <damon@lists.linux.dev>; Sun, 12 Nov 2023 19:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilsJm/vr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2906DC433C7;
	Sun, 12 Nov 2023 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699818375;
	bh=3hLtCq4IeSzVAzt9xwdt8SFMTkOmxWIve71ZhjNphZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilsJm/vrsBo6Yu1ARBJXfw+m015LoFYGrGhL/3VpYDAsxMUdX9vYwdMYJDtgee/3r
	 2BobP/nc2JGuXBqoYQqTNwcHNW5Ul9h5jQBXL8J9jNE/kU9f+YyP4IB3ucA1GKwMF/
	 aVX7CwYjHhsScSiQ6bEPXWZXfsqDaxSSXIIamlhSeqRsvgt7urc/TcfeDoBssuSlIs
	 5nsUjlIN3IEX+FEQIB4x0276ygds0KDvX8pHGguetiHuUDPLdMrlnI0JiCa8UY/bm7
	 Hd5jdrzrPWfkBHm2Us92VOCJDsEJu9z7ez2YSTrZ29EZEOa9USrpWHji/+z1pjDsqj
	 yaPQldDJREiJg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/8] mm/damon/sysfs-schemes: implement a command for scheme quota goals only commit
Date: Sun, 12 Nov 2023 19:46:03 +0000
Message-Id: <20231112194607.61399-5-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To update DAMOS quota goals, users need to enter 'commit' command to the
'state' file of the kdamond, which reads and commits not only the goals
but entire inputs.  It is inefficient.  Implement yet another 'state'
file input command for reading and committing only the scheme quota
goals, namely 'commit_schemes_quota_goals'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-common.h  |  3 +++
 mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
 mm/damon/sysfs.c         | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/mm/damon/sysfs-common.h b/mm/damon/sysfs-common.h
index 5ff081226e28..4c37a166eb81 100644
--- a/mm/damon/sysfs-common.h
+++ b/mm/damon/sysfs-common.h
@@ -56,3 +56,6 @@ int damon_sysfs_schemes_update_regions_stop(struct damon_ctx *ctx);
 int damon_sysfs_schemes_clear_regions(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx);
+
+void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 10d8678e48ea..273fb7862fce 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1888,6 +1888,22 @@ static void damos_sysfs_set_quota_score(
 	}
 }
 
+void damos_sysfs_set_quota_scores(struct damon_sysfs_schemes *sysfs_schemes,
+		struct damon_ctx *ctx)
+{
+	struct damos *scheme;
+	int i = 0;
+
+	damon_for_each_scheme(scheme, ctx) {
+		struct damon_sysfs_scheme *sysfs_scheme;
+
+		sysfs_scheme = sysfs_schemes->schemes_arr[i];
+		damos_sysfs_set_quota_score(sysfs_scheme->quotas->goals,
+				&scheme->quota);
+		i++;
+	}
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 2d31390edfc0..f6952cec9f19 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -994,6 +994,11 @@ enum damon_sysfs_cmd {
 	DAMON_SYSFS_CMD_OFF,
 	/* @DAMON_SYSFS_CMD_COMMIT: Update kdamond inputs. */
 	DAMON_SYSFS_CMD_COMMIT,
+	/*
+	 * @DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS: Commit the quota goals
+	 * to DAMON.
+	 */
+	DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS,
 	/*
 	 * @DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS: Update scheme stats sysfs
 	 * files.
@@ -1025,6 +1030,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"on",
 	"off",
 	"commit",
+	"commit_schemes_quota_goals",
 	"update_schemes_stats",
 	"update_schemes_tried_bytes",
 	"update_schemes_tried_regions",
@@ -1351,6 +1357,24 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 			kdamond->contexts->contexts_arr[0]);
 }
 
+static int damon_sysfs_commit_schemes_quota_goals(
+		struct damon_sysfs_kdamond *sysfs_kdamond)
+{
+	struct damon_ctx *ctx;
+	struct damon_sysfs_context *sysfs_ctx;
+
+	if (!damon_sysfs_kdamond_running(sysfs_kdamond))
+		return -EINVAL;
+	/* TODO: Support multiple contexts per kdamond */
+	if (sysfs_kdamond->contexts->nr != 1)
+		return -EINVAL;
+
+	ctx = sysfs_kdamond->damon_ctx;
+	sysfs_ctx = sysfs_kdamond->contexts->contexts_arr[0];
+	damos_sysfs_set_quota_scores(sysfs_ctx->schemes, ctx);
+	return 0;
+}
+
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
  * @c:		The DAMON context of the callback.
@@ -1379,6 +1403,9 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active)
 	case DAMON_SYSFS_CMD_COMMIT:
 		err = damon_sysfs_commit_input(kdamond);
 		break;
+	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
+		err = damon_sysfs_commit_schemes_quota_goals(kdamond);
+		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
 		total_bytes_only = true;
 		fallthrough;
-- 
2.34.1

