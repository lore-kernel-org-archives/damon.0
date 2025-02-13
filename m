Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC6156653;
	Thu, 13 Feb 2025 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739411098; cv=none; b=DivZKz2tWwmiD9N13LnMWIVuUUTFvNr8qNFipzyeq9XbURKWsPY1NSGdKuYmsW4vX1lrn0JzD2ssnCC29ssHj9lbmP2C6Yj4l7rrT1I1LTUpvOHd/6kEDg/UIzjx6ObtvF6t8SeGyNP6PqcKGHKmImbi4xfSInTUltwNqvSJwoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739411098; c=relaxed/simple;
	bh=5mT7etGAhFimYWHp8UnnlxRdq2vvO4qVjTFtFfnATX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zb3RL5PjzsCaIi/NwRG3dvZnlOI74yoaoJ6Zdl0g3JfILy0CWBmwAJ3Aimi2lcy7GIQsW+DFDOSebzegwmMbTdL+/XIj8aZVFXlTeI/jzJMty8tQ3SppVEGWgoLcEDKcZoZh+xq9m1EGjLrGKPN1JEat2nOFYzxmApVEOJGDtUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crw6qJnY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crw6qJnY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C108C4CEE8;
	Thu, 13 Feb 2025 01:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739411098;
	bh=5mT7etGAhFimYWHp8UnnlxRdq2vvO4qVjTFtFfnATX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=crw6qJnYGnrLWb24ECzEINhxpjP3mM72df9H+zpoOtoR8AB6uExB0pLzuuQWNOUsS
	 NrOGmSwrw369SR/lm6+IxcpVnKf8XZw2fN6E0Z0rvPKzHtKFGZuo+ewP8MNMr4DWoI
	 NrDAf3zXl1wdUmj5PsQ8qfuvf56wTTsTUFOHCflsiHGRGGhQp04K5KUnj2owNS/B6h
	 XqU2ZiDM/5WnPZoFfuRJ8i5EYB7JzSRwDIcokE3FMcQ3SRE4HlY/4HewfnQmxNutoj
	 b52EfXn+0jWiBYaPPL+1i2rH/+0FqqoDlrVIa1hpZZjgUBE6FTgN0fw24sOhrgZITn
	 1cAF3/y9x/LPQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/8] mm/damon/sysfs: implement a command to update auto-tuned monitoring intervals
Date: Wed, 12 Feb 2025 17:44:35 -0800
Message-Id: <20250213014438.145611-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250213014438.145611-1-sj@kernel.org>
References: <20250213014438.145611-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON kernel API callers can show auto-tuned sampling and aggregation
intervals from the monmitoring attributes data structure.  That can be
useful for debugging or tuning of the feature.  DAMON user-space ABI
users has no way to see that, though.  Implement a new DAMON sysfs
interface kdamond state command, namely 'update_tuned_intervals', for
the purpose.  Once the command is written to the kdamond state file, the
tuned sampling and aggregation intervals will be updated to the
corresponding sysfs interface.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index f9bfe9ea0ae6..b1829ee67762 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1213,6 +1213,11 @@ enum damon_sysfs_cmd {
 	 * effective size quota of the scheme in bytes.
 	 */
 	DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS,
+	/*
+	 * @DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS: Update the tuned monitoring
+	 * intevals.
+	 */
+	DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS,
 	/*
 	 * @NR_DAMON_SYSFS_CMDS: Total number of DAMON sysfs commands.
 	 */
@@ -1230,6 +1235,7 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"update_schemes_tried_regions",
 	"clear_schemes_tried_regions",
 	"update_schemes_effective_quotas",
+	"update_tuned_intervals",
 };
 
 /*
@@ -1502,6 +1508,17 @@ static int damon_sysfs_upd_schemes_effective_quotas(void *data)
 	return 0;
 }
 
+static int damon_sysfs_upd_tuned_intervals(void *data)
+{
+	struct damon_sysfs_kdamond *kdamond = data;
+	struct damon_ctx *ctx = kdamond->damon_ctx;
+
+	kdamond->contexts->contexts_arr[0]->attrs->intervals->sample_us =
+		ctx->attrs.sample_interval;
+	kdamond->contexts->contexts_arr[0]->attrs->intervals->aggr_us =
+		ctx->attrs.aggr_interval;
+	return 0;
+}
 
 /*
  * damon_sysfs_cmd_request_callback() - DAMON callback for handling requests.
@@ -1723,6 +1740,9 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_schemes_effective_quotas,
 				kdamond);
+	case DAMON_SYSFS_CMD_UPDATE_TUNED_INTERVALS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_upd_tuned_intervals, kdamond);
 	default:
 		break;
 	}
-- 
2.39.5
