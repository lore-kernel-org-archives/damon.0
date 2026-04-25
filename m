Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51AD22D4D3;
	Sat, 25 Apr 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777148691; cv=none; b=aF+Ty4sNim0CKkYojpevuJwX1EXc3WBU8XG0UjvLSPZ6KVD0t3vKv5XY+2tiSCtALckHvUbdyYyiYgFONQWYqwgguZUVGg7VT4MYv3LsaJwtbGRe4ZXs+SZL90n7K7qTF240Wxw2ZSiIQBeoFFJuTaqpcoa50f1wLv/FnzDv6vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777148691; c=relaxed/simple;
	bh=ZxomxQePr7AKqbVr8jYWuTL2wbyw82jIcBeFpsB83ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dL8VQUcRp62HFlVjrtD9kqLH0Pzz0cKWB74LPeH9cKmVi4ATF+5ML39xNwq8gq5iWbDstkwwWBNwuEkyuthVADYrYxwfR1rMrXb3COoe01Ms7Qh+x2iVR+mdGS9YfCdP7aP+77xipPrYwwfk6ECXLVV9yoKy750lyO+Lg/YWSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr4kLGcz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr4kLGcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE4AC2BCB3;
	Sat, 25 Apr 2026 20:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777148690;
	bh=ZxomxQePr7AKqbVr8jYWuTL2wbyw82jIcBeFpsB83ZM=;
	h=From:To:Cc:Subject:Date:From;
	b=Kr4kLGcznmVP0L1rZP2VjW4Zfh/wHYrk6Kl855ccaB1ty73vkAwZnvIOPUQ3waZit
	 Xc34bRh9XdKhKW2NYToGQPbzwyzPpAjH5V1+1kTiGREllW85+aVcLtgO2niN0MVprV
	 3H3+XmSj2DFSG4TmQBbIrLTdpMOmwcnceaPsMoHASMU5kAc9nPxOaWbSue2xHAkqnV
	 naUmtvLsl/8J+yPCCxM8SFSRdd9IXX2SBiCR4oO2jx3MhlPU2nrHRNVN/gfUA9E7oK
	 y5qEcb9msNlDhG8rXjQf5/unVAsDXmanlKu/At9e1Lpg9vvfiY3/Ueel2f09KkioNN
	 gAm7SLYzhPEnQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()
Date: Sat, 25 Apr 2026 13:24:44 -0700
Message-ID: <20260425202446.108095-1-sj@kernel.org>
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

base-commit: 8aa462c5a7540f9f8882cf8fa6add712fdf38c91
-- 
2.47.3
