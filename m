Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F15490C0D;
	Thu, 10 Sep 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789049943; cv=none; b=WWvGE9svj9zAj9vCbkSk+tMb8XoBYed5NX4Mod0b1jAvIBtSs0DrwfE8S43kJZJMdvBV2f/x0b5rC2D6i7bFhMihUGhOIQN648wLmH6iuYy2GG615Z/Q6igTgEzsugns21zz+bOmsDAXh3FKgkE+L8ozV48nKZkvwvFBknx1IE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789049943; c=relaxed/simple;
	bh=NxJNNkLIMwN7Y3HTJHZKVUGVJLfNN3bM8VvJRz993Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oq0ARLD1XpxvvpxMAgRwbZjE/8mgT+eyWdRFIKrSLJQTtyNLOomZIYf0PEtXc9zOC9JgAWwHonJWHZju1zdqScQPj0eIsYT4xFj3NjRaNEgkHXF9eucssU7uQl+KdMwCboD7unRqOgxWwc4/+VsuN3ggtJIbr87a2vSdp0ZXq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm3EsfxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm3EsfxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95461F0089B;
	Thu, 10 Sep 2026 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789049941;
	bh=0LMfK+vJvFqvjmpgUK8C/JqVd+cTrrKRqz+a3Phr1zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qm3EsfxRZoU0lrrLqxjyApoQiSRatL1idYHPbQGIEl8uNjhrLF/RP27YMUMr8j8/G
	 4RO1iEujHLWj7a8HIAiVurO0Dy32FJSaaaQ4H3L6dVep+eATQaYWJnJeLz0rgmCTLn
	 uBIhCBcm8yT0mEDInANzKqhUbLg5RbKHbOp/3HGkDTksIDufWrKeO51y5P7uf5ECgU
	 NX43/YyiqFPhc/qPNmCKjk28yg5zynFSbRaZMAD051+67dDwezVGCPN9yZybnkR/bw
	 bBEwqaiUP4yJbznelQs3id1dXhIH/9HTxujLeQO+H8lv0eum/VUd6I9BQYrF66H61M
	 oVNWN0iW4xROg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
Date: Thu, 10 Sep 2026 07:18:45 -0700
Message-ID: <20260910141849.170896-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910141849.170896-1-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
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
