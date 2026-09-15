Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2733C13E5;
	Tue, 15 Sep 2026 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438180; cv=none; b=Y55nCIhhzhZ+mbvOF9TJN/dgDiGr7dLCP6Rl4hE08DNhqONAD5bqbKIG6wZQcxlYVs65K5bic7ViCqrxSDB8eGvVql/ijSdrctg2yjnCXMcJ4YvyG16fa0YHkqrGeqZMwJRATCpMozPTQ9fsWDwwGqihG10/PHsU2Oa2mDzqlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438180; c=relaxed/simple;
	bh=7KJvTe+GpQnptvdSMySx0hYUtbdP3bQYiTs/AauomSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6Euhvhf4jV3gCoKnLjeon48LtKS/sNT1JUSyPjaJgfyHEF6ZneqDtZ4AfjhQcXJzO2jyLf1t2XL+YxDJI1OpAtEQGAQcZIN39RydBSdSgnhE0gOKwhOz+YKJ1/pzF3rxVTCW8JdrlOkGTGFJmNaQOIm2AHRnQnash5YODx746c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2HUmvDl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2HUmvDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA761F00893;
	Tue, 15 Sep 2026 02:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438178;
	bh=nYceecOh8VdULfAbqb5wdqVn5Jc9YupqRstrIojMs2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L2HUmvDl5Doa/t0qj0dO4MggM13j+UX4IjdJlFeJ9TKNBeoKyGTbe/UObXqWfVwry
	 reTBitSPAxcHjQ2ru03b4hmmklLyzcOP4N53LXAKsc3Y80KfjoLNVp02ZCOO+T0mkR
	 S2QckCnCeai/z++wwf+VAI2jsMTLH+kum3Qbn7XnM6sV87Y2X4LWztQR7+N3E6lQsf
	 ascroCQSmBJ254Eet6TrWBt0G8FG7Mn+H4lksaHT2kQK4CGFr2gHBYX9sEOqUtYF9x
	 U09Jhd0zKewp9VC15EhrfEQk7EgoltJUu7ZAA9f1rhQsxWnIZjjJSynBLoXXO/vIPd
	 lSkFEhTziJHOQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 2/8] mm/damon/core: commit hugepage_size type damon filter
Date: Mon, 14 Sep 2026 19:09:21 -0700
Message-ID: <20260915020929.102953-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915020929.102953-1-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
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
index 5212bfb8f85f2..2c9cbcff37fac 100644
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
