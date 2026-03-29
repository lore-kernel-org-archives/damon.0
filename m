Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2A23536B;
	Sun, 29 Mar 2026 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759145; cv=none; b=jdvWSHyjeQplxMIfMt7ZchkGPnB1voZ0o8F976M0KijGXRfwGWMum+h+gjqO4H33i8WW0lpjhs5hNreiAsF8A1v7l/RF6eJLTjFHmj+H/8yGFcu1OtW0b9IhGcVgqyWk74YzLsnBE+2N5Pa11tZqSkTV8OVrMmdcvt5XP4ohq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759145; c=relaxed/simple;
	bh=kObMod5TMzaMvBn9+D3aTOIeg1hrGWniApE2U38771M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldLcV+8+AE0iefLiDETFnC++Jd46LYZJeqzPV32q4F/h4DZ2aBg19Kxi4jgaT/htH8pwyioFOYqI3xP1hLuhkbj+QvlaTYnOqTXBrtalJ2N6M4sIulPIGKqxJcNXw4Bev880NZebl3k0u4yK/TNYdDzNho+0B8B7PC5KaXMlyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWioIKs2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWioIKs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A376C116C6;
	Sun, 29 Mar 2026 04:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774759145;
	bh=kObMod5TMzaMvBn9+D3aTOIeg1hrGWniApE2U38771M=;
	h=From:To:Cc:Subject:Date:From;
	b=aWioIKs22y5/mjG5KKkFStFFpJNa9vjoB0awkplXzZnZQ+qMnq+DHQ2einzBTGE64
	 TlNDNmpEM7xhLmGqU50eaNVZXljG6odEw4tshT/VuVjAQ46+2gr1xU93LJVkJEgPts
	 b/8y+p3vLNKAeEhWqFqEOrxCWcDcVwspHzbDEq+/NBFLT2PrBgmmvQnyC4OfJk1AC6
	 lcgppInOTlztPpc0EQVdEZYTePCAqS17O04KvKACukJnvgUFksEnFqGxoI5iwtY7CN
	 RUBRcD0nCqcwiD4QJUKzemmJ9+ck8qNMbGg4H6HxOGmGJsWniSaotfiM3bv3lTJNgk
	 zLCYk4dkNU37w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/core: validate damos_quota_goal->nid
Date: Sat, 28 Mar 2026 21:38:58 -0700
Message-ID: <20260329043902.46163-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

node_mem[cg]_{used,free}_bp DAMOS quota goals receive the node id.  The
node id is used for si_meminfo_node() and NODE_DATA() without proper
validation.  As a result, privileged users can trigger an out of bounds
memory access using DAMON_SYSFS.  Fix the issues.

The issue was originally reported [1] with a fix by another author.  The
original author announced [2] that they will stop working including the
fix that was still in the review stage.  Hence I'm restarting this.

[1] https://lore.kernel.org/20260325073034.140353-1-objecting@objecting.org
[2] https://lore.kernel.org/20260327040924.68553-1-sj@kernel.org

Changes from RFC
(https://lore.kernel.org/20260328005412.7606-1-sj@kernel.org)
- fix typo in patch 2: s/MEM/MEMCG/.
- rebase to latest mm-new.

SeongJae Park (2):
  mm/damon/core: validate damos_quota_goal->nid for
    node_mem_{used,free}_bp
  mm/damon/core: validate damos_quota_goal->nid for
    node_memcg_{used,free}_bp

 mm/damon/core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)


base-commit: 2f8cc7995d75c89079c55a85fc1d3092ffb7bd59
-- 
2.47.3
