Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D45480DE3;
	Mon, 14 Sep 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397099; cv=none; b=Hc+kh6vzD0BUlr75zq5jJ69LFNmVFdBLuIBJyBFQiRgBoYirD9YqrN2Oc+rKNU1IqaopS4mRf/8ezZTFLP+GA60OVNycR4eluIcYrHHegCzyRbjhwngtybd51E+CI9+w/Q/DN4bKQNfrCxTkoTOxl4HexDjbyArsamz94htSElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397099; c=relaxed/simple;
	bh=3L1QorlNk/Wp+5GsNVmlGSsAYMdUuNhfHUcwQE6dUWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUB42S8lEyIsJr02LwZyIAFWEFolTaoN2lunmYrIUQpQsEkdpfFZWRYoBPpHLI4I41WXAjGVDcFSKNcJGC3kohYAtQCmDeMb3jrpsiGCRNIEAVFg5xiiWnF/ltSs+UWQyQ/ypOnrhTk9YmzQqDqPCErKJkz2vsHRJ5x1JKaFmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgHK9ARe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgHK9ARe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17AF1F00893;
	Mon, 14 Sep 2026 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397097;
	bh=PNN3COfz5szEevfjTAWMJ9flE3N9cABR9EM74E8BBgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgHK9AReoEvV/+ci8VgMmW/xHkPlzSWnb5f4Lbj7TfVOuluHbRME+i/sGujR/ygZB
	 2nGIA8jPm2wZ4aTFnMZmNHz95NJNlalFia+8gD7R4jcWgy1BeUFmMBAcJj4F9wyKEa
	 sM9OGzZ43rP5X2IWqy9okjmmhNSGWHPOJWlZyW9/8jz5EMzHPy2KuSJKiCxSLqTkve
	 LlMUsE9bo81dhMjMhr9AfyAeMYzveFZk1IID18ibY/6Ad6ysgD+OST6RJJGZP9l+Ha
	 dPn+ddDHVI6m8YgKs0AvJabQf3UHqjDoKI3/HNEoTUm/0L/pOdZ3QGzWv964WojrZD
	 ulmeibjDycXBw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/8] mm/damon/core: commit hugepage_size type damon filter
Date: Mon, 14 Sep 2026 07:44:39 -0700
Message-ID: <20260914144448.93732-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914144448.93732-1-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
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
 mm/damon/core.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5212bfb8f85f2..4cd7eec7b8ec5 100644
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
@@ -1859,6 +1869,12 @@ static int damon_commit_filters(struct damon_probe *dst,
 		case DAMON_FILTER_TYPE_MEMCG:
 			new_filter->memcg_id = src_filter->memcg_id;
 			break;
+		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
+			if (src_filter->range_max < src_filter->range_min)
+				return -EINVAL;
+			new_filter->range_min = src_filter->range_min;
+			new_filter->range_max = src_filter->range_max;
+			break;
 		default:
 			break;
 		}
-- 
2.47.3
