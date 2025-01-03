Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E61FCF60;
	Fri,  3 Jan 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926257; cv=none; b=lfK1CfGiDkynZ4KqyNuhnz1RPqkk0Rm2qjsJe+soP54nRY9JEZ6ERvLG+PzLjtLZM7jZpVr0ymvz4nlV3ddX4oZrbsvyDS2LfNiWZUIxpa5BLkyFmWOrFsdeNiebUakisz8KDMsBfjhOBPKRLvST4JQJnilcJP6b7DF+MqRTOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926257; c=relaxed/simple;
	bh=rbTL8cU3TZPcyGMSlZELKJLzpLND/6Ckurwp21Ndpas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FJFb6uPqvC7Z7goSdJJKCkeAnBv1t1zUJvlgSnETPVinjeE3VRxfYbXNzt6ixPCkzj7+jk40SPZMbbkIuHBtLZHicnvtgIGSxmMdcF8Nps+KQmXlRHogDlUk7adMxeDh1KAA1YQ1uJzOI+CJjJclIlTe+WTv/XK9EeLVd64bIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuPud1XT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuPud1XT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5289BC4CECE;
	Fri,  3 Jan 2025 17:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926257;
	bh=rbTL8cU3TZPcyGMSlZELKJLzpLND/6Ckurwp21Ndpas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MuPud1XTNdpWjKxTAN4F+wbJsgLZvLdZYH0KJLmKth0kVsf7jVwQrLIHw+N9qN9R6
	 JOGu08x22H8puHME/3+1jyzKrSQ2kpZ5dsQqh3Ri2S78gs6ei4cNzMY/KbWjPDhxb5
	 brktRmfBHiV8+0idfOUVGxIYxBkjQ3y8FjOPcYxnReEPYn3RtpowsjpTx1GamBVUtl
	 3s80v0c25U5yS+KlQ2cNZR+khOnSCVHhK5c0nC/Ej3BqM8D+wGv8tWEc8tCcel6nYS
	 JgvfDB5PTjJGwLdhXeHqZameoLpCeDOoNXj26IdqsTkS5DE4CJ+lH8Kfnl/t1rP2mz
	 bDQvGVOa7XOyw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 06/10] mm/damon/sysfs: use damon_call() for update_schemes_effective_quotas
Date: Fri,  3 Jan 2025 09:43:56 -0800
Message-Id: <20250103174400.54890-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103174400.54890-1-sj@kernel.org>
References: <20250103174400.54890-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface uses damon_callback with its own synchronization
facility to handle update_schemes_effective_quotas command.  But
damon_call() can support the use case without the additional
synchronizations.  Convert the code to use damon_call() instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7c2aa9830edc..917e6aca3f58 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1327,20 +1327,18 @@ static int damon_sysfs_commit_schemes_quota_goals(void *data)
 /*
  * damon_sysfs_upd_schemes_effective_quotas() - Update schemes effective quotas
  * sysfs files.
- * @kdamond:	The kobject wrapper that associated to the kdamond thread.
+ * @data:	The kobject wrapper that associated to the kdamond thread.
  *
  * This function reads the schemes' effective quotas of specific kdamond and
  * update the related values for sysfs files.  This function should be called
  * from DAMON callbacks while holding ``damon_syfs_lock``, to safely access the
  * DAMON contexts-internal data and DAMON sysfs variables.
  */
-static int damon_sysfs_upd_schemes_effective_quotas(
-		struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_upd_schemes_effective_quotas(void *data)
 {
+	struct damon_sysfs_kdamond *kdamond = data;
 	struct damon_ctx *ctx = kdamond->damon_ctx;
 
-	if (!ctx)
-		return -EINVAL;
 	damos_sysfs_update_effective_quotas(
 			kdamond->contexts->contexts_arr[0]->schemes, ctx);
 	return 0;
@@ -1400,9 +1398,6 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 			damon_sysfs_schemes_regions_updating = false;
 		}
 		break;
-	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
-		err = damon_sysfs_upd_schemes_effective_quotas(kdamond);
-		break;
 	default:
 		break;
 	}
@@ -1550,6 +1545,10 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
 		return damon_sysfs_schemes_clear_regions(
 			kdamond->contexts->contexts_arr[0]->schemes);
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_upd_schemes_effective_quotas,
+				kdamond);
 	default:
 		break;
 	}
-- 
2.39.5
