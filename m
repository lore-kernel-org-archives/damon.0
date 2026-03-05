Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170E1F4174;
	Thu,  5 Mar 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689167; cv=none; b=JZT2lZuTn90GJxKbUxvLlbigHF880HxordDLi7jLpgqqxUDoEUjN5tXpzhP3SKmkS3tUKZJ1PxqOYWc5HYIuJ2aSTvZQddER4zn8/6USpim6/fiNZ7k2Sw9Q06y7lRY7nE7uSvW7gtsH7R1IHJoQopZQTRNrg491cWparQ/qw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689167; c=relaxed/simple;
	bh=tjN9QTx9dJZVMftCXorjoS7yD/zBWFucwNvkhLpPRLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1np7lgDvy34m+Vw0r+dx54eX479A1BhpIsMdyqGb3MMWo4TOe7+3y3jDZpC36nacUUKss8Io5rl/Ege8D7iIk6nHU5GvYxWMXt10gsqcBiX5vPs2+ELmtj33z7DsHgmJ+eKAKxdy6Ahjp+ua3HInZ7Lt46CDoOw3wchElWkOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Beu5N6qr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Beu5N6qr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85193C116C6;
	Thu,  5 Mar 2026 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772689166;
	bh=tjN9QTx9dJZVMftCXorjoS7yD/zBWFucwNvkhLpPRLc=;
	h=From:To:Cc:Subject:Date:From;
	b=Beu5N6qrZ/HlQz6IOULTQhSTu+OyQqv/v8WhrmTJ2DguF47FuJ1rA1KAUaYp9CCgK
	 Q0iTjzHlqUsmoheGCZrWXw6ogYdoigRa4/Pxt8poc5oXnlyfGiNiesvmcnTrrtuFF9
	 BDOdJcbVvnB9VSpn1esAmMdXB6Zl3veP+F0Rye0K3KZUBKdRHE4qenjSjjtv++Ec19
	 lINYHFkCspg7N4u+0l1cyAXO+SPjiEYcaKa56RO1b2QSST6csSL6gKw3mLPdi7A/fM
	 DdI4Yl5TWw7IIK9b5XUaGhNJ6x+ZwHRW1+/mZa7Gd7BviMSlYmdu3F/c9rBkQ5p+Lq
	 Z+io7O1YINVhw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/5] mm/damon: support addr_unit on default monitoring targets for modules
Date: Wed,  4 Mar 2026 21:39:12 -0800
Message-ID: <20260305053918.83786-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM and DAMON_LRU_SORT support 'addr_unit' parameters only
when the monitoring target address range is explicitly set.  This was
intentional for making the initial 'addr_unit' support change small.
Now 'addr_unit' support is being quite stabilized.  Having the corner
case of the support is only making the code inconsistent with implicit
rules, that makes it easy to confuse [1] readers.  After all, there is
no real reason to keep 'addr_unit' support incomplete.  Add the support
for the case to improve the readability and more completely support
'addr_unit'.

This series is constructed with five patches.  The first one (patch 1)
fixes a small bug that mistakenly assigns inclusive end address to open
end address, which was found from this work.  The second and third ones
(patches 2 and 3) extend the modules default monitoring target setting
functions in the core layer one by one, to support the 'addr_unit' while
making no visible changes.  The final two patches (patches 4 and 5)
update DAMON_RECLAIM and DAMON_LRU_SORT to support 'addr_unit' for the
default monitoring target address ranges, by passing the user input to
the core functions.

[1] https://lore.kernel.org/20260131015643.79158-1-sj@kernel.org

SeongJae Park (5):
  mm/damon/core: fix wrong end address assignment on walk_system_ram()
  mm/damon/core: support addr_unit on damon_find_biggest_system_ram()
  mm/damon/core: receive addr_unit on
    damon_set_region_biggest_system_ram_default()
  mm/damon/reclaim: respect addr_unit on default monitoring region setup
  mm/damon/lru_sort: respect addr_unit on default monitoring region
    setup

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 36 +++++++++++++++++++++++++-----------
 mm/damon/lru_sort.c   |  7 +------
 mm/damon/reclaim.c    |  7 +------
 mm/damon/stat.c       |  2 +-
 5 files changed, 29 insertions(+), 24 deletions(-)


base-commit: c33b07ff858e4125f60a2b9e2a49f276b0d7e75a
-- 
2.47.3
