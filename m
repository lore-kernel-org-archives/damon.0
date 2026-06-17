Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E23B7B76;
	Wed, 17 Jun 2026 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707728; cv=none; b=U03FIp11YSttWCMro9AM14xJtaOsYjiZK3yBpHH88y0OaoFLBDL1MVtma4RyWnbRFvJmWUnqT/AaqdjZFF81SySZdHAthMnHhoSLocfGVLojYeYLkg6fu/53zHljjekZW5CDO5htfs/koX8EubBfMu38x+qhlbw5r31XmfKJbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707728; c=relaxed/simple;
	bh=p8P38+wx918AbRrzM3YM4z2vNJg8orkszaYFHl4mi1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dy1rv2GGEZwOKc8+VYr3AcltsyUoeLFVOlPZ9Cv1Sb0iFM6nX5h2xgPscOK3jXAKkLSpPK3hTVPJLh4Re5BtUwPhGqao2lCNUMjT2eacbuyU7Srp6EhUqdl9OTGLglPYn+s0+Gt2NpFwwn/db7TeBgK9EG8moHwzJGskjkibhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0RujzvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0RujzvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9E11F00A3A;
	Wed, 17 Jun 2026 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781707726;
	bh=apeCKq9Hxx5icDF/JvpCpTO4zm17bsS1r78YB3ZGzD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o0RujzvKdowxiou2k5I7rDAbBol8LTn/gsflatroNfF4spTvvLI9+Xq21bydJ6894
	 n0mhMH1+yEp8xOxBtcF+hbScJiJCl/8qfHvuRxXruFbT2nkVOhn6EqFmJFOxGLJI2q
	 61QEXsZM4TAEc3WIsoz1D3i+C/qOvmhcVYrHheaHqF8R45fDfkRcqefguLn+kQBGWi
	 KuBZaWuNL3GvDEoHbj6PelLI+4W/IOAKUKyUgQ1C9pUiXdBq8PqrWwzi1FiNVRKtor
	 2DZmvAh75VbIB8T4tNZqWaBpKu+z/DldRKjs9FdIUX0dYLP1fOFH8AYbCYv0PRht1Z
	 mI2fHcS6Lo3Ew==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 09/11] mm/damon/sysfs: kobject_del() probe filter dirs
Date: Wed, 17 Jun 2026 07:48:03 -0700
Message-ID: <20260617144807.91441-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617144807.91441-1-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts. Fix
those issues for data attribute probe filter directories by adding
kobject_del() calls.

Fixes: 82e66aef7714 ("mm/damon/sysfs: implement filter dir")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5ca45654cdd39..36a0e82601697 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -962,8 +962,10 @@ static void damon_sysfs_filters_rm_dirs(struct damon_sysfs_filters *filters)
 	struct damon_sysfs_filter **filters_arr = filters->filters_arr;
 	int i;
 
-	for (i = 0; i < filters->nr; i++)
+	for (i = 0; i < filters->nr; i++) {
+		kobject_del(&filters_arr[i]->kobj);
 		kobject_put(&filters_arr[i]->kobj);
+	}
 	filters->nr = 0;
 	kfree(filters_arr);
 	filters->filters_arr = NULL;
-- 
2.47.3
