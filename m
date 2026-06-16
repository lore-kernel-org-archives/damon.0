Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9D44BC97;
	Tue, 16 Jun 2026 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622548; cv=none; b=OJnrrEPn4KqCdqMg57jqFYL0FraYhe0rLbxXyUvXEjlaxnjka9+e3gCVq09lkf/0WVNVCf137DIfZZ5VM0QTiLZFua0hZl/QeEzNf0StiwmaAonBvws+PvW71F2nzSZv3e5tZtBAJha17s2dsG/viySoD+eeprNFSqzX864x1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622548; c=relaxed/simple;
	bh=0wFw/4FPmRrM1rMqtlHtiY6VrOz8emM+UWdIPJQC90o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oI5KkkBxGUgQw4j17P+8QkeAvqn8dZdidl0vMVJtk5zzb4u3ul2m8qp4eSZ3vwyDVxMLrLIqgQYWxHY0175Nlh8xopWmQMIkEwqg6g1+CtWIVu7JGgb3Ip/pqIvYtYCgfxO0EXSiMmZwypAN6OdKaleDIRlwtuXe88KYvVvuP1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5uc9FL4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5uc9FL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0571F000E9;
	Tue, 16 Jun 2026 15:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622547;
	bh=24pS8GK4dyL7EYkozGkjXsM9BN2kGeayQ2pQaapNgLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5uc9FL4t9jwZcTUjB44eiIrPXrxF7DLlSE37piZc5Xo1Liq5gPgSenhP8dxM+xrM
	 NvS+hGiFKZQME3IaDzU3axI7/SGczvnB3vbEDJfofTIFeIGnxkoJ5fxPkx+aueWKqu
	 eKYimBbSnXBZ3SAM9mRo4q+bYd8FZ4ZBlpXIbjylcR+gqhosnZD8KxDLwCxaatnJtV
	 ASmSbKGRdMl/0qhG/ixO8IRBR8oLr9V6h/Yu5gKwv6K3y7NB5bQwpICvoTDvl5PZnx
	 mm2qz8QwxPI2qFnHmRY00abxeEPDFL/Y2BfHEOO/RoKyJwiQHJe7DP3BJR6AUiccRZ
	 A0lQ/vwloSnCA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 8/9] mm/damon/sysfs: kobject_del() probe filter dirs
Date: Tue, 16 Jun 2026 08:08:42 -0700
Message-ID: <20260616150844.88305-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616150844.88305-1-sj@kernel.org>
References: <20260616150844.88305-1-sj@kernel.org>
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
index f72e1e37df9d8..04725ff3d9f3c 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -960,8 +960,10 @@ static void damon_sysfs_filters_rm_dirs(struct damon_sysfs_filters *filters)
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
