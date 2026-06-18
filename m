Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BF3FCB10;
	Thu, 18 Jun 2026 15:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795740; cv=none; b=WKeB0DUL4/gcAA52ZkTACx2RS7lfzSqnuGHE9DDQU0TsI6YWSejOIR9tmeDpRu3yjVnbmSfMFRsvIEsu4Mk+W0pbbhX+pGxjaVrbY0bNvmeUk3efUEKI6yy4luRse2vkti0v2jU/gDepTKz1GI5ebBeSwd0r8dKNnumunszyvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795740; c=relaxed/simple;
	bh=p8P38+wx918AbRrzM3YM4z2vNJg8orkszaYFHl4mi1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqNGUk3jcxERW3gA/RQmujMS6pQa1Z3N+9hETQbo0Uw2E6y8My3fvWtqdjA1h3eXAkjNI5e9aKOvD0opnBolCl0W350ODgERj4hGOVglXbqL/uGGO6ar6Du5ZYSbqjiMW8Zc0ziZHdDIBd+XDj0ael4xP/VDH2QgCJAPoNQG+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERjpiAqy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERjpiAqy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDF51F000E9;
	Thu, 18 Jun 2026 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795739;
	bh=apeCKq9Hxx5icDF/JvpCpTO4zm17bsS1r78YB3ZGzD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERjpiAqyeUT3jWBP+j8FtqDS7DMvTidfk4+DZF/xWda3eO7c2KJWWV8fVRn5kkCkC
	 pUlSPrCkVD7yazw9UfiTYgaatFzlYJVE3S+Z08eL3Xs2KlM8TOP01DHt38xT5bsPnd
	 cDRyvxXkOnzIopuS68IPLWxJq+RGE+SPRdXD1YfFXPZLP9PDwrgJBXsywWwdWppDqo
	 hjRDO4JwEUhoPk18Kaww5EU2OdUnBtiQHe17qD7dEOkkkYtNeE6XVoa302r3ARLXuk
	 kLiPK69jR9lFiaxSHlQIThGh4xaK7Crvow96fdndKkAcA1WInKTqhRvRQCXbHTfTpl
	 ibCPG2m6bwbSw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 09/11] mm/damon/sysfs: kobject_del() probe filter dirs
Date: Thu, 18 Jun 2026 08:15:13 -0700
Message-ID: <20260618151517.5366-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618151517.5366-1-sj@kernel.org>
References: <20260618151517.5366-1-sj@kernel.org>
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
