Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906163603C2;
	Tue,  1 Sep 2026 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237267; cv=none; b=kbAFf7Ejdgv608uIYBACn04tzhRm64smkMuDTNVIRGSYHhVxOG4rWLk5aWz6BYWNgfLUkDw9xaR/3rE6z1WpwqV0BmPrFzuXeoIFxFm1VfZiSU4voCfNPQzlspEJjI1CKf6E0HC3MDpSGJ5dSdVL+SBuMwXaWih2DY5qDRigBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237267; c=relaxed/simple;
	bh=ur9aM9M3M3StIkcfs2dlkFt4MZLQoyzztUq2x+Y/rss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtXa07fU4GNPSF44R7fUN/JTlf+5NME2iu8wENQSs7uRnJCCYLE5VvHvu7BzEQT+PhMiM0B7mZ3xMwevn8iFpvT2YiT7pnw9gTo3McVX4uqBsw+7rIp7vTqs6w/oacqROe9XrxVgHVnFTWUAzco09m8FpshMsfaGe7Qd0YGlY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AooYVBmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AooYVBmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396091F00ACA;
	Tue,  1 Sep 2026 04:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237266;
	bh=fRLux0o/6DOEf/DKOzdhtuDNwLGjkWNCPtBCJqp5Lu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AooYVBmduwo3wuWJa2eFShjfV9QGIH4sLwqx9KJLkgi3eq1EIBDQ0FD3hVY5Vh+A2
	 J4K9GkBAMrQqckcC63FjlFACmwrHpy8+04DoJlFM59j7hCqrY15ZVBs4VXgN4bUpZ4
	 UrfdtQTItJe43mhZjbKIjmZBzWYs/9J+noss6QwNL+/hQwQ097sT/gliISw2ctb+n1
	 deoD41DeLdr55qhJ2Lkv0fM5RBtjCvkWyLNJnjOyQtWbdNK0x9sesgMnZ2E4JFopS0
	 G7WSKHcM0xdEtOkAsUI7nNE/OOdFFCSvYVBpbDewI2YYENz+35ZVvRdWUdRz4O3mWa
	 BDNh/dnCD85aA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/17] mm/damon/sysfs: support pgidle_unset probe filter type
Date: Mon, 31 Aug 2026 21:33:59 -0700
Message-ID: <20260901043417.2165-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
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
