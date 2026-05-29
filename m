Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD381CD2C;
	Fri, 29 May 2026 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012876; cv=none; b=mZx2BqSfE0iLVe62K4u+mGGI8fAvHHQTGeJnrUQcc/9pkvjbrwEsGJT9/Lrlpa2Km8Ev8d3JKzGFYFBzxKxO7H8k4PPIIJ7c1XZbusUKA2Hp6+k0mdWSRklFgqSl/QpCNosrGGxhtGuNvc1SCfHet/B3It/mSQry7VgI2de628M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012876; c=relaxed/simple;
	bh=g0crpiLc1oeMxatGVm2EjKDxST70qrj3tkYsodGY1Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfB35wxsayhvfD6gwAWJKYApXQcJTKI9mMuEEAlhroPQaqY/7nVSmi6U7j848lX8r8uaGvZ5zLLDEznWApvzWIpDN103SBwJGntWoPWbP6lXNu/ddCbx2/tA7p8Rgo43hVdcogt0sxLTK7wSV5aJ/dFChOlonZijdO9p4Bta2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2ylaYJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2ylaYJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACB51F00A3C;
	Fri, 29 May 2026 00:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780012875;
	bh=vx8oJBN/wcV5EZq/agtzr1qbPBazCkEMU+Yp1WK1pgI=;
	h=From:To:Cc:Subject:Date;
	b=Z2ylaYJ7M09cBU0Fuam7Bwi8DzsJOsHupO82ITB1zUpZFyTFLKslIxe92qEd+hhqs
	 IEBptpel1r45Ve0Xtiz2CK5c2GluXxHt9iWMmUeztnz1p7XU6mZndg497nExcuvl2o
	 0dJzHEDqPLPtN8Uan62+Es3pilQ2uw+I1PTCeuxegBQkXJIin0+XjcWz/3lGQIiXP0
	 elo5A+5/NmvD8Q7apgKuCtq53LcS4qsB6KWRtr08fYMOQvM3l4cSIGItO1dQbEinMk
	 CHyVJVttZGrBPxoYxFjSI2OGYjdWVS/sYBLrMYDGR0QtdRPu2kwodXtWQIaOVlcuwv
	 nwTxeBkiCI9yQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon/{reclaim,lru_sort}: handle ctx allocation failures
Date: Thu, 28 May 2026 17:01:01 -0700
Message-ID: <20260529000104.7006-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM and DAMON_LRU_SORT could dereference NULL pointers if
their damon_ctx object allocations fail.  The bug is expected to happen
not frequently,, because the allocation is arguably too small to fail on
common setup.  But theoretically it is possible and the consequence is
bad.  Fix those.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260419014800.877-1-sj@kernel.org

Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260528061110.2172-1-sj@kernel.org
- Drop RFC tag.

SeongJae Park (2):
  mm/damon/reclaim: handle ctx allocation failure
  mm/damonn/lru_sort: handle ctx allocation failure

 mm/damon/lru_sort.c | 4 ++++
 mm/damon/reclaim.c  | 4 ++++
 2 files changed, 8 insertions(+)


base-commit: 62a58b8764d8e485eee4c12d24ee107ef11c98f5
-- 
2.47.3
