Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A92910
	for <damon@lists.linux.dev>; Mon,  6 Jun 2022 18:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBDAC3411D;
	Mon,  6 Jun 2022 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654539798;
	bh=N4cT2SKfYSnDGxoyHnmUEPdoAtmbrJGcDlJlH2/OfOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byQbhpHN3e9Y/GWGOgpUbWD+yN8h7nuKYxgeIVGGNlhspqY11BxajycI3nF/fw2gx
	 gnOBRV2snd9eFGeOh52JoJUOt7Mog9UxiTd/BlvWENXli84MvslqSslVZb6+DBuYkt
	 C9G+FZppmX0jtdWTZSaJ8acoyIHAHItRlX4CfXYFtctTSvDRbg8v6EWr/goMSTXD/3
	 4CtZhsv14/+uZz52T7rrJH8XaH06ZeVhyO3sFPERLu2WH04ERlUcjgeOMesK2hPKOc
	 P2W98Wf+/neUZNhpHaYvPSZistrlYbWlpmoNx0trUMBWDeVnJk2oR2Mldi1E3JshPA
	 awT6y401nW6Gw==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/6] mm/damon/reclaim: deduplicate 'commit_inputs' handling
Date: Mon,  6 Jun 2022 18:23:07 +0000
Message-Id: <20220606182310.48781-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606182310.48781-1-sj@kernel.org>
References: <20220606182310.48781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM's handling of 'commit_inputs' parameter is duplicated in
'after_aggregation()' and 'after_wmarks_check()' callbacks.  This commit
deduplicates the code for better maintenance.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 4b07c29effe9..c2ed962db23f 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -403,10 +403,21 @@ module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_RECLAIM (default: disabled)");
 
+static int damon_reclaim_handle_commit_inputs(void)
+{
+	int err;
+
+	if (!commit_inputs)
+		return 0;
+
+	err = damon_reclaim_apply_parameters();
+	commit_inputs = false;
+	return err;
+}
+
 static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 {
 	struct damos *s;
-	int err = 0;
 
 	/* update the stats parameter */
 	damon_for_each_scheme(s, c) {
@@ -417,22 +428,12 @@ static int damon_reclaim_after_aggregation(struct damon_ctx *c)
 		nr_quota_exceeds = s->stat.qt_exceeds;
 	}
 
-	if (commit_inputs) {
-		err = damon_reclaim_apply_parameters();
-		commit_inputs = false;
-	}
-	return err;
+	return damon_reclaim_handle_commit_inputs();
 }
 
 static int damon_reclaim_after_wmarks_check(struct damon_ctx *c)
 {
-	int err = 0;
-
-	if (commit_inputs) {
-		err = damon_reclaim_apply_parameters();
-		commit_inputs = false;
-	}
-	return err;
+	return damon_reclaim_handle_commit_inputs();
 }
 
 static int __init damon_reclaim_init(void)
-- 
2.25.1

