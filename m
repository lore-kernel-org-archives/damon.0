Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F93CAA47;
	Sun,  6 Sep 2026 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728724; cv=none; b=Py+n6nqbLz7EnfmzGAZiTsHe1H2is90j28rJs3VsQvqLb5n5T1diK5IvbCIeTiFGOw48jwCgILnFv7buSPDZ8HCtuxuIj1uOjtb1F696P5G6qp0gjXcpSXMvdYH088Wc6wEacTrKMAgnkfOejensSh3nDG7G3TqrLaOEOH+Q5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728724; c=relaxed/simple;
	bh=5MPlXzTMzu+dtxnKFeJkCBo3NIMp4n5dweksJaeBp/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKTUHs7/hqDhU3QFFt1hKJQ0aZdaFsSg4wML1iHuTvQTXBE6UuTqDhR7z0jxVZcFeYXRK5znJV/XinNsb6ISt2G6CjYZjtLIhYg040UQRKXRn10ltmHUhVl2eH2e+Cao2JNtOt+4FCyBiMyZQrTlJVGIqoRMj7rL/D9ZzrBxZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azX6Hu6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azX6Hu6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFDF1F00A3F;
	Sun,  6 Sep 2026 21:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788728723;
	bh=KfRQdDvn8Y4M2LTyexgG1B+ohuNKkP22FbeL73FEnAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=azX6Hu6+AM7WikMiNEgis2NfbDfVi+nNwMk8uq1WQ5j59Gx41P6zAzVDFJmKB2R9b
	 VITdlxluRE7NjpziLnevoqTrfM9aglvtrXBemBnJoRsAh6zTDoANecthhYuhoHx07t
	 TJDMYtAU/02VVKhbbAQrd0kv2q1Y7rT32uUVKIhFBKJQbKF3y7vSB9W71ppE3osmCQ
	 ZyWuQq+EzTBOtwlc/9Vt0w+vKarkgxwDGHo/tSV1OnOGpm9tGDXZkgK6K7u58qPVuc
	 6OIG1Nr2x/tfZMCDgG5Dc8PZCc58D2dnF4EFMMVPjXzVVe20AGnkRlb+b6CGnWkTux
	 4hpkr2JL3e64A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/6] mm/damon/sysfs-schemes: setup range_{min,max} for probe_hits_wsum filter
Date: Sun,  6 Sep 2026 14:05:10 -0700
Message-ID: <20260906210513.106895-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906210513.106895-1-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
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
index 4d9147d2a269e..e297a20c0af03 100644
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
+			filter->sz_range.min = sysfs_filter->range_min;
+			filter->sz_range.max = sysfs_filter->range_max;
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
