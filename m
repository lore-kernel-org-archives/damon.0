Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2911DEFE6;
	Fri, 28 Feb 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780217; cv=none; b=hlBhxFYnp/a2iD/hIlvqa7vDSAaqGyrY6JScfGylfQOZygrl3QjfLPKzV/0uHWpgskv/AvyCIX++Os8VNL/DkPFfAjWFQpdGTuml1wBL1rhlcddwzMJGZd9Wlm/CvGcuWuyn2NivuASfn8Ctzq6n/66vr325hQcDKQTQlqa8Y1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780217; c=relaxed/simple;
	bh=LSjpeMzXWVkQm84u7Pg3DRD/aAE+XvDLQxgeGEMx2JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rU6OCc8+r3sjrGZGlCQ2SABvTinSc7/CI8vSacWi/GL2dVPsbkKbUVqlyvXhTqw5btuwvR6trH/FioTViR9i3U1hRvRhOVMqoQOMAvjBpB+h6P1aqSrW0yV6qPQnc9V6XvdCVQAwmCcNlBzt15JgF4RT8jXwZ6INUHkBttZR+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyUvQ5RC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyUvQ5RC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C68C4CEE5;
	Fri, 28 Feb 2025 22:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740780217;
	bh=LSjpeMzXWVkQm84u7Pg3DRD/aAE+XvDLQxgeGEMx2JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyUvQ5RCMFQwflA+TMO8dM7S8jYiryk86Led7r9AWzRFl7xTVycCaRQSn1iJo6WYv
	 jztKcAwB8eAZ0Mkw/Tp1l2SfKnkW5IgmEZjQsG+pC3+R0t2eFqcLFn+SkJW2s+YPgT
	 Fq8ncuwkI7PWynynSVOXwUSMbMxEipKUZXQRZI8ClmQP3EewaVcrxLoybZrBGiWNHa
	 W6EPURqnOVVydku6UCehBFEThJRRLqGY0/9ZDtcGz2xiVRznycPdk/dAcUNjQjaDIb
	 ryk+5js4ai70mv6qkGpCl6Fa1PEi/gHMcPPqChg0z3KCjS8gloBVy2iDJXgealPOjR
	 0cOIV0q2sQX0Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/8] mm/damon/sysfs: implement a command to update auto-tuned monitoring intervals
Date: Fri, 28 Feb 2025 14:03:25 -0800
Message-Id: <20250228220328.49438-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228220328.49438-1-sj@kernel.org>
References: <20250228220328.49438-1-sj@kernel.org>
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
interface command, namely 'update_tuned_intervals', for the purpose.
If the command is written to the kdamond state file, the tuned sampling
and aggregation intervals will be updated to the corresponding sysfs
interface files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index fa5f004f0670..ccd435d234b9 100644
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
