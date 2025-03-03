Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F9D23BFA6;
	Mon,  3 Mar 2025 22:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040258; cv=none; b=p+5g1lcfiSaaURBhJSvq3hiZy2KhW4UE/DtVEf6yrcI/5Crw5wgS1zKcMEC0VbQUUF/OZGEfRbmUJqfHMvCEvLaF/xQyqKbH1W+8q+za7wv1ZXQ51R3iMQvhaiMYiNjAgX1kKW2/13/aSYOSKCcIAjD/K4iDRh1bO0MiYIIUYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040258; c=relaxed/simple;
	bh=LSjpeMzXWVkQm84u7Pg3DRD/aAE+XvDLQxgeGEMx2JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z0mI4ngt3pzXCquLxc1Pv3D8Q+EMyOkR6YpfosOiZQmCt72o18aNyH208YJMrHbjRvsscnl4KAPGutFTZi4BJbX01nNXRo8pYVB2hcnyFniSNneolhybkQJ6Mu329i9IGacSv1TMfsQLIVXrq5sgu6LWQ4JzVmMKykTCkvRFGCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3yMVWuR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3yMVWuR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DF7C4CEE5;
	Mon,  3 Mar 2025 22:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040257;
	bh=LSjpeMzXWVkQm84u7Pg3DRD/aAE+XvDLQxgeGEMx2JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3yMVWuRfTjd+OyCEQ1rThotSmYg5rgYu57djwTjR90VhkqveAnxODI3I0Pj4atbc
	 j3HFSGmVorGtEjAkBwVCQqmyVl658yX+bMgKswz48VI1lXTx42RxuJ2g4SgDYWPFZy
	 yvILiydHL10R9iiy+aARh+LsJ/oIfEOJyrnGyN2OKhsLLfqYlXRs9iJ0jiEAkKZXt+
	 vcG0ed+tEQ/o2YcJKlB9E+1A48j8Yw8lKAQZyiydaRBTPwNbc0noFrAs1fXFyzqVQU
	 q6O0BUlIqc3ns5CY4NALEzVr+EUdusKWYmRzW4MgM1hF2U+Q8AAaDjRVw8hsGz0w+o
	 e1nfPi6+CEJjg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon/sysfs: implement a command to update auto-tuned monitoring intervals
Date: Mon,  3 Mar 2025 14:17:23 -0800
Message-Id: <20250303221726.484227-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303221726.484227-1-sj@kernel.org>
References: <20250303221726.484227-1-sj@kernel.org>
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
