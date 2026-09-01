Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794B474267;
	Tue,  1 Sep 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269117; cv=none; b=EElUkbD9srp6e5hKlBiqsKXtg3RZOi1vwO+l9E4R51K5d6lkwWz8cLIkUi3BZH5yzn2/9WnsPM8QSxmHNilHXogWoKs8xotpLnKo1Gi3A2s4cveu39l9tcHkosGv+zA0e3IcEqeqCivQaDct9zV3uyDjTg56Dc/idUJzUzwwAio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269117; c=relaxed/simple;
	bh=ur9aM9M3M3StIkcfs2dlkFt4MZLQoyzztUq2x+Y/rss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHL6JdYM71ifr8nhQyIqmpepgHfGPfl/sRlRXJ0yir0oQtkCuJqUVX1xwjvntTeDppk/GLkqsRpUQIoZj00cbr1QggZUqHb61kARgxdnCf8d5+fXSg6tepy6NUvDgUgcuGWEB5c6tEe9+pQk72o3dFISZ/dvkHs4cekESqnLSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsoMRHtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsoMRHtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955561F00A3F;
	Tue,  1 Sep 2026 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269115;
	bh=fRLux0o/6DOEf/DKOzdhtuDNwLGjkWNCPtBCJqp5Lu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsoMRHtJ6t9A5IK7X8n7y8bRicYtUpaAfju2k5dDHWny+UuVVanreQ0++btTvla6C
	 cqu2gjNNZBYacDd9K6P1LbQ3k1skJ1EOgwcEW80L4xfpe1rJ9TjH0opCWY1n45eXiR
	 or6vXKSD3i4E7FTOs3nj0etWCPE6gzvC2rqhB+PhiSDdjTEw1laiThI4onSByspKku
	 95iapPoIQWsGxy2BlmnhO/MVBAhjyoUhYQznvtEnRjDbHqVXpTRCYXU+qprvO8UWUm
	 Kwb172VudYGgGcuLHHkdgLoufMhTgtvjO/SsK0HRew3a/RHVcJRLGKa11DrKOXztUm
	 G8zqtJ664NqZQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 03/17] mm/damon/sysfs: support pgidle_unset probe filter type
Date: Tue,  1 Sep 2026 06:24:50 -0700
Message-ID: <20260901132506.99243-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to allow users to set
DAMON_FILTER_TYPE_PGIDLE_UNSET by writing 'pgidle_unset' to the probe
filter type file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index dcb739ce0a729..3593bf9c7b7aa 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -781,6 +781,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_MEMCG,
 		.name = "memcg",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
+		.name = "pgidle_unset",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
