Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D5489862;
	Fri, 11 Sep 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134921; cv=none; b=gbIrhNhE0OhYm6yriOcJxDGfYGhLBXUp/ExGWnYgBZMN4/UeR8C0L4sS7+JQNiW3CqVeyDbF+5uOKYhJ97E5HVwI+HExAymssZjYhqEmoJO3I0o55+Ut6VG9kNBxo6vevR4vOEqrUZVIgMzac6tIyjodMZoh5SfZaqEwH5tmlRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134921; c=relaxed/simple;
	bh=TxCcrhH+EcWCqlcOItsNzCvegydeKP2OAcmuPJWEIBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJvlgjEI0IgVndpx8Jy3ZARembyK5GHaOPw94LssqVj94cwIjOGMnMZQZKg4X8Y5azE5OgmNONoVVGNBkq/ys3U+eJ+aw5q/KR1pYnFkiIPF5P4D/24Gv8yeGVLf5o0pG/drdqcZRrOYqwU3shxLhCbTXOypeOpV0wZKWwb2w/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NU0P7Axr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU0P7Axr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261761F0089B;
	Fri, 11 Sep 2026 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134920;
	bh=6W4HqJKZTtS8lrUgM9flAHj2CUZu3m4em5eZnB2Nzv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NU0P7AxrYc+voy7CArjQOzT031tyquUxRxUaXq91eK1BFeMsptWJjuHqwA1J2bp+V
	 SR1IP55BmRk4qQG/4RuFK6592fScGB2LpUDAF5IS+D1jbftjeI7cwvLDVJMCl/RgNi
	 DEewYwtF57tb80a71l5MQH7WS9uQT1x0bLcOsQIUmC/MC2vIMcRK6xsZl5sTc416ic
	 sgNrTe8w26wFHyjDa+g+nzPl+z2SjbncXkfk4cgVfxcPkRkKA8oSD051s00MePEXwL
	 5gsoD492CpL41HcDSBBexUCV7vjf4W+1UojqMH+ahI2ksmVF+YTYcA1zU/Z0i3pGDd
	 ASeu+Pgx0PqIw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter
Date: Fri, 11 Sep 2026 06:55:07 -0700
Message-ID: <20260911135510.96914-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911135510.96914-1-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
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
 mm/damon/sysfs-schemes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 4d9147d2a269e..3de4d804e049f 100644
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
@@ -2844,6 +2847,13 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			}
 			filter->sz_range.min = sysfs_filter->range_min;
 			filter->sz_range.max = sysfs_filter->range_max;
+		} else if (filter->type == DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
+			filter->range_min = sysfs_filter->range_min;
+			filter->range_max = sysfs_filter->range_max;
+			if (filter->range_min > filter->range_max) {
+				damos_destroy_filter(filter);
+				return -EINVAL;
+			}
 		}
 
 		damos_add_filter(scheme, filter);
-- 
2.47.3
