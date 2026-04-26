Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C5EEC0;
	Sun, 26 Apr 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777224994; cv=none; b=nCH3/J58/shVEpbBiwl/8j5ju2AvuWw/F0tajw/l868Sb5eJbabWMPPagO9vsZcwohbH8efHvJ/3yVqhbDmIqiB1mUHTy08L5hnk1tXa2pZwxAQZHS1O/PJuhR9tfsWx223I5R3VoIWgfo1gShdJmXGcjaFiCwdLWEA+j94pzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777224994; c=relaxed/simple;
	bh=KvSnvOhyWjleirQU9z5e2xFONCdcqdSmhG+4jkdX/YU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uj6p3K98CbS3OeZ+3yUvhKZ/HzUVy6AHHggUnRYLiTdShHxwmfwein2wITd84GqeBhENZVvhHvcbh6xFD2grKQ7FUf5g+mEQ/W9bdaLWdTJtwWpaHLGbAjsVXbu69xyPgj1vq5km8tQOPmwS3XBEYbI+JziKODRKBOICfq2yZT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XU6vj17C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XU6vj17C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D409DC2BCAF;
	Sun, 26 Apr 2026 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777224994;
	bh=KvSnvOhyWjleirQU9z5e2xFONCdcqdSmhG+4jkdX/YU=;
	h=From:To:Cc:Subject:Date:From;
	b=XU6vj17CgcR2KLRsj+KMMZ6pRz/MMIqmQOMrQgFe3KscTBSoSVL9eYF0w+xg2g6sc
	 SvJQGqCEoYJuVGL3mrOf0AZZuRQ76jBixxLoqBmkndxxdSOgmdX5LHcGpHeqrufgc2
	 h7UitJfkqGzTYtQR147S9JSEhD26GtPfFWQ+XbxLl5sp5ir2E2hujgoWvkYIDxo0uZ
	 21/ni0TpcVRd7fk8xdbXG2+yG5wLSwDgRDY/TDHbYVibANzffV3nSJSGRCUFsN26Nl
	 NQdtLMghgf8O+Kb16POFvumzXVisB0RDQaO7skwAbHm0MDqUmVl4GOkbI84nfdXP4E
	 Z4gdQbCNFUXvA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()
Date: Sun, 26 Apr 2026 10:36:12 -0700
Message-ID: <20260426173625.86521-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_memcg_path_to_id() breaks mem_cgroup_iter() loop without
calling mem_cgroup_iter_break().  This leaks the cgroup reference.  Fix
the issue by calling mem_cgroup_iter_break() before the break.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260423004148.74722-1-sj@kernel.org

Fixes: 29cbb9a13f05 ("mm/damon/sysfs-schemes: implement scheme filters")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
- rfc: https://lore.kernel.org/20260425202446.108095-1-sj@kernel.org
- Rebase to latest mm-new.

 mm/damon/sysfs-schemes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 245d63808411a..04746cbb33272 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2594,6 +2594,7 @@ static int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
 		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
 			*id = mem_cgroup_id(memcg);
 			found = true;
+			mem_cgroup_iter_break(NULL, memcg);
 			break;
 		}
 	}

base-commit: 63037c6230622d20536f4327a162b82cd59fb483
-- 
2.47.3
