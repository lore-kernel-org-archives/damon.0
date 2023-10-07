Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E15235
	for <damon@lists.linux.dev>; Sat,  7 Oct 2023 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jblyM3cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135EC433C7;
	Sat,  7 Oct 2023 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696709077;
	bh=k+E7o4trRwpUVpsgiWw9zd/8lmV+kOwn1CHhDi4J/Yo=;
	h=From:To:Cc:Subject:Date:From;
	b=jblyM3cEtrib/74xHI17sH3ZJytEYYeAjCDJPFD3KBCStlKs9wJ2HGxDFdvarbqFx
	 P36i22ZGZM67vyqEdfO9Ad3jx1oaK//GGZA5uBXorrNyJvqkq5qnAKDP3V+ZaLnAh2
	 lnmDVYg1qVN84i7cblbu/rhsRCro+/X6M3LTbksmIv1zXohwfC6C2WMYnKpP5LF3nw
	 VMkFPEsWGWpg5KxdeWJFzPh8lQX0cgNxP7+f1bOspOyGrTM+fU2vkjw3ycEjAq5AIE
	 O7yLzUTUHvd33/7pklmbQ53JP1Ni2pVLHSs0yw0YoLHOV0pPcH2ij2q6ez5KgWvQWF
	 JrOsensvDSjTg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/1] mm/damon/sysfs: check DAMOS regions update progress from before_terminate()
Date: Sat,  7 Oct 2023 20:04:32 +0000
Message-Id: <20231007200432.3110-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_SYSFS can receive DAMOS tried regions update request while kdamond
is already out of the main loop and before_terminate callback
(damon_sysfs_before_terminate() in this case) is not yet called.  And
damon_sysfs_handle_cmd() can further be finished before the callback is
invoked.  Then, damon_sysfs_before_terminate() unlocks damon_sysfs_lock,
which is not locked by anyone.  This happens because the callback
function assumes damon_sysfs_cmd_request_callback() should be called
before it.  Check if the assumption was true before doing the unlock, to
avoid this problem.

Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b86ba7b0a921..f60e56150feb 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1208,6 +1208,8 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 	return 0;
 }
 
+static bool damon_sysfs_schemes_regions_updating;
+
 static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
@@ -1219,8 +1221,10 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 	cmd = damon_sysfs_cmd_request.cmd;
 	if (kdamond && ctx == kdamond->damon_ctx &&
 			(cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS ||
-			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES)) {
+			 cmd == DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES) &&
+			damon_sysfs_schemes_regions_updating) {
 		damon_sysfs_schemes_update_regions_stop(ctx);
+		damon_sysfs_schemes_regions_updating = false;
 		mutex_unlock(&damon_sysfs_lock);
 	}
 
@@ -1340,7 +1344,6 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 static int damon_sysfs_cmd_request_callback(struct damon_ctx *c)
 {
 	struct damon_sysfs_kdamond *kdamond;
-	static bool damon_sysfs_schemes_regions_updating;
 	bool total_bytes_only = false;
 	int err = 0;
 
-- 
2.34.1

