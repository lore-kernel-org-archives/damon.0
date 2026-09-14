Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D747F2F8;
	Mon, 14 Sep 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395819; cv=none; b=UT0YVQhFE2wwCeprbJXCLroGzlf2a3Ni44so75zRJvux7gVOwK/fWkwCo+ILlo8IYx360a04cKsQXo6DQ2DClsddBvsaJAoUlxnbRvWr5caZ5o4MhuLnu5FtOfZh7tTCBXGVuHWCdQ2aiW9P+v2dK1ziTWx71sGR7SXXY5+a9gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395819; c=relaxed/simple;
	bh=tpVaEb4AYEZ73fAxIIPOmUa+AX18NBp3TqT+frNo5vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxwTit2ZdI/Qi6Pi9/9nmaoWh0Iq10Ez8GF2lusCbIltwWntTp83KVBT4pdtWrbkcWnL84DS7tCeFMUMmHQBN2+qRKqUD2Iys4qllcw1vo8tX2S85AO8p8YhRVtNYA47TA+xYvjUl7Rx+nM66eQaL00aCjGKSktg2XbVFO2gGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh0m6NXa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh0m6NXa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F791F0089C;
	Mon, 14 Sep 2026 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395817;
	bh=SymGB/Aunbf5NpktH/MrAmxXwvCzvOB6NopidPvvPWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kh0m6NXajRuL3CuLqc5aJQNDFZ3RSvXdrkKyvR2jqMPtFkDWwdkniXPWWgcrnctzq
	 8Jewn5hAICL5YkGtDhBgQk/TGlMY2TwK6I6mqlqZFJSbLBkLzk/M+9060VTlcIRUF/
	 T+4rQk2mcjJVtIQQOkP2nKQUSyJ6kof8xGCz/Bm/j7h0bFIyYbjHIfHxPr81bQN8Ug
	 O/IXla/2RVPpFZN19noahFBlE2K4iOdNIfrPlH7sTtOW3XI1yqEH4gCmaNPbWwjewi
	 qfvn5visdXISBS4SmEM7y7wjxhhMTXruMeDi2Qf2Lqs8LcLRZOAeCv9ODieO53q6yv
	 T5trV7T1wBAPg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon/sysfs-schemes: drop centralized filter range arg validations
Date: Mon, 14 Sep 2026 07:23:22 -0700
Message-ID: <20260914142327.92510-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914142327.92510-1-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is validating wrong range arguments for DAMOS
filters.  Now the core layer is doing the same validation.  Drop the
duplicated validation in DAMON sysfs interface.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8c8ab82c8facc..a4ec5d54cfbd1 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2832,27 +2832,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_ADDR) {
 			filter->addr_range = sysfs_filter->addr_range;
-			if (filter->addr_range.end <
-					filter->addr_range.start) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_TARGET) {
 			filter->target_idx = sysfs_filter->target_idx;
 		} else if (filter->type == DAMOS_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
 			filter->range_min = sysfs_filter->range_min;
 			filter->range_max = sysfs_filter->range_max;
-			if (filter->range_min > filter->range_max) {
-				damos_destroy_filter(filter);
-				return -EINVAL;
-			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
