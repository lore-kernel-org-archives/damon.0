Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927B26A1DF;
	Thu,  6 Mar 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283957; cv=none; b=MufOHF2z22/6dOvUGeLxwyhQEjDPkUOvSEBOOuQzR6a0BUeXKqnozG1OhLqSfg/P38Yprz4sv8oPdEn2QHW+blQFi96mBRomgTQIi7oUENYAFeDKm0ogicSEnZ4RYnI65Jnj83gbpJrh02Ya8Vyqb2dF3Me3OBOmN5yp3NlQ/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283957; c=relaxed/simple;
	bh=kjRBOvHWNbdf/mQwA1XYqEBxVUEwRjN/LUXLXxN91ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7h8bnulPr5tlVJBeGnJnHMXtEPvqTxiOZd3ZeZytm0GFsvuLIpLDBunMZQNaEAu7mXpoveOlsMJr/rbjcxLpA+/ngjFKEJniuZWmYAIdRU/CnQ6HR/g3Hzi81CR8i0mBqqQTNIZTxNX8wHG+x5+XHrCK8+MlPxI9bumL7cahrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmBJepJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmBJepJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CFEC4CEE9;
	Thu,  6 Mar 2025 17:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283957;
	bh=kjRBOvHWNbdf/mQwA1XYqEBxVUEwRjN/LUXLXxN91ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmBJepJD665aLJmGQxhQbg3r5uCZI03NRdxNpdG+KwHddc86qPBdSRAQMFQ3yfnD5
	 09FCigyvExD6n59jKLLfJQFgVHXaekyCo6Xxgu9m01Lfm5jpm3mqHwHQ40bZxrmGpN
	 1Aef85s16/6RGAPVPLckJ8/8Il0wJShRPayR0ziXlJNWe2oEzYM8a/1Soix28O8znn
	 iLRgp53OMwhf35xMdsEndfPegP/HRBVMiQorpbOYyCukclBrIiy27d2Wt9h2HWurOI
	 UpoGbqg6MBK9TFXQhiYZVs2s0oRLfTryt6K3wb0VRCAkrg9w1THC6kFWRNiYevY7KX
	 eNxld9XLVJ0Zg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/13] mm/damon/sysfs: handle commit command using damon_call()
Date: Thu,  6 Mar 2025 09:58:59 -0800
Message-Id: <20250306175908.66300-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is using damon_callback->after_aggregation hook
with its self-implemented synchronization mechanism for the hook.  It is
inefficient, complicated, and take up to one aggregation interval to
complete, which can be long on some configs.

Use damon_call() instead.  It provides a synchronization mechanism that
built inside DAMON's core layer, so more efficient than DAMON sysfs
interface's own one.  Also it isolates the implementation inside the
core layer, and hence it makes the code easier to maintain.  Finally, it
takes up to one sampling interval, which is much shorter than the
aggregation interval in common setups.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 87e4c6e3614e..c55a2cee4b74 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1451,8 +1451,9 @@ static struct damon_ctx *damon_sysfs_build_ctx(
  *
  * Returns error if the sysfs input is wrong.
  */
-static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_commit_input(void *data)
 {
+	struct damon_sysfs_kdamond *kdamond = data;
 	struct damon_ctx *param_ctx, *test_ctx;
 	int err;
 
@@ -1550,11 +1551,6 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 	if (!kdamond || kdamond->damon_ctx != c)
 		goto out;
 	switch (damon_sysfs_cmd_request.cmd) {
-	case DAMON_SYSFS_CMD_COMMIT:
-		if (!after_aggregation)
-			goto out;
-		err = damon_sysfs_commit_input(kdamond);
-		break;
 	default:
 		break;
 	}
@@ -1712,11 +1708,7 @@ static int damon_sysfs_update_schemes_tried_regions(
  * @cmd:	The command to handle.
  * @kdamond:	The kobject wrapper for the associated kdamond.
  *
- * This function handles a DAMON sysfs command for a kdamond.  For commands
- * that need to access running DAMON context-internal data, it requests
- * handling of the command to the DAMON callback
- * (@damon_sysfs_cmd_request_callback()) and wait until it is properly handled,
- * or the context is completed.
+ * This function handles a DAMON sysfs command for a kdamond.
  *
  * Return: 0 on success, negative error code otherwise.
  */
@@ -1730,6 +1722,9 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_turn_damon_on(kdamond);
 	case DAMON_SYSFS_CMD_OFF:
 		return damon_sysfs_turn_damon_off(kdamond);
+	case DAMON_SYSFS_CMD_COMMIT:
+		return damon_sysfs_damon_call(
+				damon_sysfs_commit_input, kdamond);
 	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_commit_schemes_quota_goals,
-- 
2.39.5
