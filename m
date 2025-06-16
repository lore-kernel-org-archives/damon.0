Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854C288518;
	Mon, 16 Jun 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094630; cv=none; b=WbNazW09ONFgc2jYE9f7f65eaqq6KuQyNdmp1kSenrQ1hQjRFzCSvhGLGUBoEnI48Rq2C7ySUg2JDyi7ZUaZguWOMJFQslmxxxxFRyd6aRydFssz2ir6VZFQR/OnL4VLJUhyUKEaRMXF8Z8Jgv7fudU1dnU06dpMLgZkCuJlJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094630; c=relaxed/simple;
	bh=cFTYLzRVovBgv1/UqtXnIM5Df8l6NGl02hyuDQ2d9m8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q1aSa6bqisYKAYfOREgaCOea0ZOh8J2BM9/v4dzrhHCyO9GD9iZWMTBnj/m+3zkdqBM1K5bwzisqWJYIPiyCQtHJFie73CMSNeHOWb6sCZJJG7kmZ5wgZhh8AbG6V9ZWV/pR4QrIW4amrOSLSzorRsBnuN0d8AALC9shacXF+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anbKykwC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anbKykwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A3BC4CEEA;
	Mon, 16 Jun 2025 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750094630;
	bh=cFTYLzRVovBgv1/UqtXnIM5Df8l6NGl02hyuDQ2d9m8=;
	h=From:To:Cc:Subject:Date:From;
	b=anbKykwCl4RiKvRK5qZnOUvhj8yrO78vP7yUeRVhNFgjOVZN9IzxiwQuf8+WHZbbo
	 cwJ57i6V2gakEQr1MEbSkgTxcrlH8CWdLUerko2/TGXLxxTt0ggDyniuh6Riz8leD0
	 gfxYY7xn8LniYpUDGvpzSDRL7ZCl17yswLKBySlQZ5ces/0G0iFPzYi7oP2dWesUlO
	 n2t5sfIptEW0wj3ZCwr7vrGp8xyRYsWl5QykABU5Pz1p/WGfQq6dm40wlLzerXxqGI
	 J8jcXwXgsa4IAVZl5EMu9jbBqrItJl1NBlvrFTmO03Juxx82JgdLC0VbJR5u4RMOn7
	 vRSNO0iziwONA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] mm/damon: use alloc_migrate_target() for DAMOS_MIGRATE_{HOT,COLD}
Date: Mon, 16 Jun 2025 10:23:43 -0700
Message-Id: <20250616172346.67659-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS_MIGRATE_{HOT,COLD} implementation resembles that for demotion, and
hence the behavior is also similar to that.  But, since those are not
only for demotion but general migrations, it would be better to match
with that for move_pages() system call.  Make the implementation and the
behavior more similar to move_pages() by not setting migration fallback
nodes, and using alloc_migration_target() instead of
alloc_migrate_folio().

alloc_migrate_folio() was renamed from alloc_demote_folio() and been
non-static function, to let DAMOS_MIGRATE_{HOT,COLD} call it.  As
alloc_migration_target() is called instead, the renaming and de-static
changes are no more required but could only make future code readers be
confused.  Revert the changes, too.

Changes from RFC
(https://lore.kernel.org/20250609200048.50914-1-sj@kernel.org)
- Rebase to latest mm-new
- Slightly wordsmith cv and commit messages

SeongJae Park (3):
  mm/damon/paddr: use alloc_migartion_target() with no migration
    fallback nodemask
  Revert "mm: rename alloc_demote_folio to alloc_migrate_folio"
  Revert "mm: make alloc_demote_folio externally invokable for
    migration"

 mm/damon/paddr.c | 4 +---
 mm/internal.h    | 1 -
 mm/vmscan.c      | 5 +++--
 3 files changed, 4 insertions(+), 6 deletions(-)


base-commit: b29ac9653c1fae75d3444b6a03521c74adb6d4cc
-- 
2.39.5
