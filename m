Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDB51E44B;
	Mon,  7 Sep 2026 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801149; cv=none; b=JCCbQiz/oIIrHQKqrP9B2tAmASvUmq/GctLa875sIVFUGGED4wgJfNrtEwMnB9hdFxtsNlaJ9yPaLS+3MkxIJrcZ62cKUhAfFm/wyg1cbUCPJ8qI99FXnL3A9gHeN10tpgTIY4umeiZil/e6Dzm6g2XCCOC16fLmv61VGGm+mPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801149; c=relaxed/simple;
	bh=NxJNNkLIMwN7Y3HTJHZKVUGVJLfNN3bM8VvJRz993Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4TmDaEuAyj3mKik7ex6D5jKnhN3t6gC5InO0j5DwyG9vdzUBU+Dr/oIEZD45WZT6HMLPOmRONTH+YqkxJPz9+tV8PU7FeMNPCRrsPPVkmnvnT3d1WeOE3MZz/eVWtK45a+vw30gAiTCZqmGSaTBCQcekI7wmAKlurr14C2iwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA9dADgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA9dADgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063A91F00ACA;
	Mon,  7 Sep 2026 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801147;
	bh=0LMfK+vJvFqvjmpgUK8C/JqVd+cTrrKRqz+a3Phr1zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CA9dADgtK6IS30SWaNAkNxa55qZYJ4+mHnCLcym4xvMm/SrQ0hSfu5yvB0XQPcayH
	 yqMERbE98Vd5iJ0RRCudq+w2WC0al1HUlFrZ26A4YZHPFqN3A8qFRYyIeE3Die/SFV
	 K1RMICJPB+GHJKu22h8NhLdABZRVuaOwOuHEoYTe6w6Rsha/rFxXj/7P9uhyKhHaCS
	 fuGb/jxvgE+A1vO8R0jJ2VEUppklpJ01IgrrBjfkSw79R+FyKU/1WBItixY9EYH4ML
	 9VCtfgudJWNc2tydeFhQFjSyLC1mfFr+F8dzBa+/A665w1x19eUOJwMTAAsnsWTnVa
	 sxI89uKyqAVEw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
Date: Mon,  7 Sep 2026 10:12:14 -0700
Message-ID: <20260907171218.101430-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171218.101430-1-sj@kernel.org>
References: <20260907171218.101430-1-sj@kernel.org>
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
