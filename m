Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504E44CAC2;
	Tue, 16 Jun 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622549; cv=none; b=H7gEEk3J+omH1HQ6Fu3GM0+eWb0DT28oTC+TYWk+gkpYcK4TK4ZSarWHlXU9kRQq8mb1NGnrpjE806HzclFKujq7UVI2Xw3xPU98bJbFEqPMz2OG1T80PTbFFhU15sd8++s0tlQAbgRRiq0Yvqn4/2fNUAe6+GMbXMBB5JwTJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622549; c=relaxed/simple;
	bh=bsS/3ro9H8Hj/8L7Tfs8DJ+mHbpUdEUCmTILyFGoDmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJCdbGJWRHfiTL6uCHaiwJnzrAaiw0pJ5U/PS9BpgGNW7GbOm01dmKdmW+xIKGpg+JLqMBdd9JbzYETPkpdVmRYLi5THIhrFiy8Lnnv7LFHSjOGeJEi11LSiH5X5Xg89Oxroi23zH92Uq2FvZuWJ6w5Hv2jgl95lUaaALrr8XZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8qFnTPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8qFnTPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726251F00A3E;
	Tue, 16 Jun 2026 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622548;
	bh=7AQfxYHOzLeqiua4ZzY6THHZwKua0+qCtLmY2SG4IcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8qFnTPQ0UjZhyH8ZqOwp+E8+pzyc75j4zvRxPXzpo9zAkIdmMbN17EUQ4Y3REjxY
	 SDtstjPx0b93kqW2PZo1UFYDw2CFLEV1w3v7zZ8wEJL+j5jXMVtspJtXjyAR6EPVtY
	 bpeI6X15JbXGQ22BCNSTzY3FemkH9O4lneLKi970oJXPNTNkYVPVeQF9MrBp9Jb35l
	 INZuAlznieU1xmF5Xwx4AHOzcq5QCUY8gpHnwnwv/5kK16RPxmyEBnzuuvEz7S6Ccb
	 OgUFKFIeFlsfc6d00y24fg4S1iCLjmkGxbSy4/1CoxKxlq9mSjdOyuzkzit7M1erBs
	 G7REw5bPAPHVA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 9/9] mm/damon/sysfs: kobject_del() probe dirs
Date: Tue, 16 Jun 2026 08:08:43 -0700
Message-ID: <20260616150844.88305-10-sj@kernel.org>
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
those issues for data attribute probe directories by adding
kobject_del() calls.

Fixes: bf3ea3d30880 ("mm/damon/sysfs: implement probe dir")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 04725ff3d9f3c..04ca0a34e1206 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1139,6 +1139,7 @@ static void damon_sysfs_probes_rm_dirs(
 
 	for (i = 0; i < probes->nr; i++) {
 		damon_sysfs_probe_rm_dirs(probes_arr[i]);
+		kobject_del(&probes_arr[i]->kobj);
 		kobject_put(&probes_arr[i]->kobj);
 	}
 	probes->nr = 0;
-- 
2.47.3
