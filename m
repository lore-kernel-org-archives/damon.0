Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49426B09C;
	Wed, 26 Feb 2025 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551819; cv=none; b=VVTjyn9zUjc2KWJMgdr5e2ETlZrrdYhJzuAIxBUh1z2CntjakdnvQT7U8MtfbFWRqD52Egigihvaz+tna455h82yLBYCkUAhlMrzRrPNh/yDBqXKM3ueDvUuPG3E4fKkCQHoAKYnsd7WaSZ3N2y13fEl2yq19U+sUrf1IleRrpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551819; c=relaxed/simple;
	bh=A9kUtW/vUg0eJWtZD6pmVLozHOg4c74YXKaYzr3PmRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTX/dPtePM9hhavuTGIsn2jXBu4F4Xoh22udt1ObvUwQcnBsU5u7yFs7MXiehRrX42qo6NgIB0pHvkcrlT+npI3iekJkugqDO5eYBWFHjt6IM0mEVZRB2bINolbGWP7Pw1mgTFNXtQouizepLXyhYudJlmZfrpStBiQFJD0znd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1VUa9Tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1VUa9Tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FECBC4CEEA;
	Wed, 26 Feb 2025 06:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740551819;
	bh=A9kUtW/vUg0eJWtZD6pmVLozHOg4c74YXKaYzr3PmRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u1VUa9TlCpJ6kmtrlPET5GNYjsXSI2WrULZys0ykm4efcjqil6Y+mFt2nGwzo5eLJ
	 ePQC78kT9F7g3yy7DGEm5r21ku2OpNLSV+S2mK1272WKYfBQ1gPZpBScgWneMkbcI+
	 Owd5vUURIHYkBFHqIdvDRGsIYYzJV1mIl9O18ksRlWIHEqAKwMRVx/KznMkjhNYaLE
	 optqYDTULzCapSsFFGZmxXuzJblRowlcC51/Pgr6KI/ZjyB/y92QCkzcdFm0oSDRLA
	 upDbHHpdf0v+5OHZRPE79eKaxcLeYRV6/xkJyvlpqfJDBECuo3MpOfXBk49BRU0Sy0
	 w3AwyPHF3QPFw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/13] mm/damon/sysfs: handle commit command using damon_call()
Date: Tue, 25 Feb 2025 22:36:42 -0800
Message-Id: <20250226063651.513178-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226063651.513178-1-sj@kernel.org>
References: <20250226063651.513178-1-sj@kernel.org>
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

Instead use damon_call().  It provides a synchronization mechanism that
built inside DAMON's core layer, so more efficient than DAMON sysfs
interface's own one.  Also it isolates the implementation inside the
core layer, and hence makes it easier to be maintained.  Finally, it
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
