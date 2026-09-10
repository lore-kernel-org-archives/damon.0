Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54933394792;
	Thu, 10 Sep 2026 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013010; cv=none; b=V9sbsbOhwvJkANKtY5lrR8uv0MtiAim52w/HXjDm9ZjseZ7Vag5sy7vmK7r6TLOBHYYwm2Z/qJfX8kBTTy5cjLn2gs+9QfEBEamtKw2P6ctQVtZZ6k3MlNzuuf6awNagKop33BzgvrIajAZKT8nY1hkeBh+lkEM8xw+wZZiyFMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013010; c=relaxed/simple;
	bh=NxJNNkLIMwN7Y3HTJHZKVUGVJLfNN3bM8VvJRz993Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XL4uOdCSVpx7K+GUCDuV6JzFSg209jbrB1fXydBiSRNAYfYXehFGk8Vo8iSLLdDtoJsi/uyC6AeEUgSHlElABY5a62/GWIKc/s2i2ovcsN+Fr2b1b5N5nyJ0AJ0fFMysRF5KuKOO4i3MaXMo//CvumtZYFTHxuSa87gT5Dvyujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EE9Pf+qI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EE9Pf+qI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33881F0089C;
	Thu, 10 Sep 2026 04:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013009;
	bh=0LMfK+vJvFqvjmpgUK8C/JqVd+cTrrKRqz+a3Phr1zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EE9Pf+qIDe7mc+OWRcmkX3VYHDk4wReFNR32iCeACl4XIoOTU6prtmMiVwstXcv75
	 XHOV5aRK8P+1Wq+SzQfsMiTpQKwaSNPiNeizvT0J84KpF7cLAyaOPOGhmxZqvMMpNw
	 VQUhmHcKtt11GFH3eIUQM6O/Tukur1+s7dTftzt/Js31eM/MSkgZ1F9TLWozRhd4Fa
	 i4luehO5dD1mbEEUG3E+EH4puQuf5GKmBlwwGax29P/P8J1BSVtgTiFaXzBSXwsLHd
	 5Yc7a0oxZgZ4p14WnzERAF+OVFrgguuDNBAzkVFHsTFU+21JF9oc2MdhsfqLCe7T73
	 bR7Ur1atFl56g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
Date: Wed,  9 Sep 2026 21:03:16 -0700
Message-ID: <20260910040319.147037-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040319.147037-1-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to support probe_hits_wsum input.  Also
update sysfs input based scheme build logic to setup the min/max probe
hits weighted sum range as user provided.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 4d9147d2a269e..d9dd4ee0442c7 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -589,7 +589,10 @@ damos_sysfs_filter_type_names[] = {
 		.type = DAMOS_FILTER_TYPE_TARGET,
 		.name = "target",
 	},
-
+	{
+		.type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
+		.name = "probe_hits_wsum",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2844,6 +2847,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
+		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
+			if (sysfs_filter->range_min >
+					sysfs_filter->range_max) {
+				damos_destroy_filter(filter);
+				return -EINVAL;
+			}
+			filter->range_min = sysfs_filter->range_min;
+			filter->range_max = sysfs_filter->range_max;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
