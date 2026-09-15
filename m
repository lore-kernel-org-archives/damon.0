Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD53C2790;
	Tue, 15 Sep 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482849; cv=none; b=oHH/zg2g7QjTILjJ9Dm8bipsah71tt7S6aUIdGhezRqAs1TewBYRHrJKodh5tr13Jw4ZwusdWDoli5u0RV+89xH3lqlU40y2B69XSqUrU9nF5FdMfGvqjj6Q/kTFYFeI4UhxtKkjdj8z3G9AhY39eYw3ake1uQ2QYXX/rKLl4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482849; c=relaxed/simple;
	bh=5ihobwKf06K/b4ktjNPhcJTyeADUOmqNgxJ4hcRrmdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEY55vvzQzYTHD/IDwgAJRTNAdonx8S3yBPz5VWu2rKUIt2QMfcEtdEo6vqHEGkW18geUWsPHvSVjcTGVco2kIuZQUncP5pcOVfdnu1fct8D/0zCtkBNjF6DgLeTzdnIAk/8C52F3EnsHMlf90mCk1npjgnVSRQ7eCfuM47PFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB65qSxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB65qSxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982D91F00898;
	Tue, 15 Sep 2026 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482847;
	bh=oJU2qf6RfTrTOINNEF0BpYTy8ds1otoxQWBYuiCLwZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MB65qSxbkWAKcFKSS1JoPP7/RNuup+iughXzsMXlu1Uc8vSwNzfRKdhTcdciBfKJn
	 a89BjNR2YLYplIPtao/LiMbpGTFkaitPUtKXi09Ng418X7QijGt2hk245hq32FrVUX
	 XwHVAyOxgaOird8ttLlLvxed/IEgZNe8+/TQgTljDsqA8DeIY18EEYBji34CSrJHRp
	 SzhkTcb8Cwa2ml/FPzeKXE9UNhSgSrNZTeHUOVfNpQoOJJGfr0TepIvTxdbGuVJM/h
	 TzrgAZ9RopO8f1dnhK9AEC7T6xTT3j4YB7uWmdyorb1kdYGeCkg7C378E+zTqXiazJ
	 YmrZ3Vxv95iOQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/8] mm/damon/core: commit hugepage_size type damon filter
Date: Tue, 15 Sep 2026 07:33:51 -0700
Message-ID: <20260915143359.91472-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend data attribute probe filters commit logic for the new
hugepage_size filter type.  Since it needs to carry the size range of
the hugepage, update the logic to update the size range fields of the
commit destination filter struct.  While doing that, validate the given
range and propagate an error if it is invalid.  Add the error handling
in the callers, too.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e0414d2adcb41..dd4317df42ff4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1818,7 +1818,7 @@ static int damon_commit_preps(struct damon_probe *dst, struct damon_probe *src)
 	return 0;
 }
 
-static void damon_commit_filter(struct damon_filter *dst,
+static int damon_commit_filter(struct damon_filter *dst,
 		struct damon_filter *src)
 {
 	dst->type = src->type;
@@ -1828,23 +1828,33 @@ static void damon_commit_filter(struct damon_filter *dst,
 	case DAMON_FILTER_TYPE_MEMCG:
 		dst->memcg_id = src->memcg_id;
 		break;
+	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
+		if (src->range_max < src->range_min)
+			return -EINVAL;
+		dst->range_min = src->range_min;
+		dst->range_max = src->range_max;
+		break;
 	default:
 		break;
 	}
+	return 0;
 }
 
 static int damon_commit_filters(struct damon_probe *dst,
 		struct damon_probe *src)
 {
 	struct damon_filter *dst_filter, *next, *src_filter, *new_filter;
-	int i = 0, j = 0;
+	int i = 0, j = 0, err;
 
 	damon_for_each_filter_safe(dst_filter, next, dst) {
 		src_filter = damon_nth_filter(i++, src);
-		if (src_filter)
-			damon_commit_filter(dst_filter, src_filter);
-		else
+		if (src_filter) {
+			err = damon_commit_filter(dst_filter, src_filter);
+			if (err)
+				return err;
+		} else {
 			damon_destroy_filter(dst_filter);
+		}
 	}
 
 	damon_for_each_filter_safe(src_filter, next, src) {
@@ -1859,6 +1869,14 @@ static int damon_commit_filters(struct damon_probe *dst,
 		case DAMON_FILTER_TYPE_MEMCG:
 			new_filter->memcg_id = src_filter->memcg_id;
 			break;
+		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
+			if (src_filter->range_max < src_filter->range_min) {
+				damon_destroy_filter(new_filter);
+				return -EINVAL;
+			}
+			new_filter->range_min = src_filter->range_min;
+			new_filter->range_max = src_filter->range_max;
+			break;
 		default:
 			break;
 		}
-- 
2.47.3
