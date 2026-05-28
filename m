Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0C314D16;
	Thu, 28 May 2026 06:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948676; cv=none; b=AbU5t1cIPG9QjYiPiWnhsI0sunyNgKa0+um06Rsa8y5q5whbc7nfXS0qXcUfQk9Pcb2qaQHwyA/9l3BHOlfwjl9vE0m6SLwatWJzIL5c2fJMT+r3Zk5bJJOafI0Go+Cly1T1FTLcucz/Rp9XRtG7RkcHs9svjDZjWqYrUrfHYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948676; c=relaxed/simple;
	bh=cnn1UsWuBUe6jsXDVoFy0owDkMb9xwrzX/LrGEh9ZLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ny1XefTb2pLWLOnr57wdJSUqmU8wsJhp/iD62SJqiWITh9LZsNsMHtCBr0Gvlpq68dZZXhh/imzJmvupX4vCiv4fbcv3B+fXavJbHZRFrIO3LfuHDnvS+Bvhy/bSOwj3utViIPVCb3aewPfGySyV//42ix9Jl3HFsaOlJxfaRXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7YGmvms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7YGmvms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01831F000E9;
	Thu, 28 May 2026 06:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779948675;
	bh=uGuuTi3QEXHp4Ch0W1P8wvpFXg0lxffEiocLYQhFz+g=;
	h=From:To:Cc:Subject:Date;
	b=c7YGmvmsEqxOZKvXhcQeMe4CjW1iX6UE5jFAApLcOFOiTQnmFgSUyRi7fY9R82ipr
	 hDZavK8E3ZJE3cbHrNupUy8ZtHTKKhPE8zJM3KkGmVVNj+srGMENb57MEuIY6NmOaa
	 qNxQSC1HEanFz13tDhMHmcNNu+PX3/hdpSlaz27B9+XqeVB3z8pabCrV4bHqOAzx5k
	 GYBb2m6yNpjsZX1dUoVOcY9h5HTtXvrWbua+z3syZAM4LUQXbVDI+0jfvGTx3w6Z3x
	 jTntY1iWPSdO169TGCE0Ic6S3Z/EIwiarfHXcVa16KrUZsJLDotfhPrZOpp3vBpqPD
	 PvQoU51GprsmA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/2] mm/damon/{reclaim,lru_sort}: handle ctx allocation failures
Date: Wed, 27 May 2026 23:11:07 -0700
Message-ID: <20260528061110.2172-1-sj@kernel.org>
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

SeongJae Park (2):
  mm/damon/reclaim: handle ctx allocation failure
  mm/damonn/lru_sort: handle ctx allocation failure

 mm/damon/lru_sort.c | 4 ++++
 mm/damon/reclaim.c  | 4 ++++
 2 files changed, 8 insertions(+)


base-commit: 3c18aac8c775b020a2c50e91051f106dc621ad3e
-- 
2.47.3
