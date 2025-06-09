Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65F1EB39;
	Mon,  9 Jun 2025 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749499252; cv=none; b=HUtLNfH5wjQmKB83oc7QGq+xha/lggNU6EAKwkYo4OoYp2/7SAVMcZP2VjovpWDNQSY5Mkwjx5gYkrCoiBmWgffVtOE20VVZiG4KEsdvhcah9NHS6qoJnqK0Z43c5gITlaeJl0JkRBTQP1d2w68MhPV2iu/a2Of72jRsvZJW1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749499252; c=relaxed/simple;
	bh=r4BeCbCBmwsdjJy94zH3aYa1PIhBvKP6oYwDdkiOZRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ATs8W3FTpcrW3EFKGPqbuWo9h+KEG0zBq8kBapfAo0/uuxvCU6XhLvuuwCdxnyL7bP6R/jdk3Vi5Q/4FURLc2UZ6mENCk+8BmwVa7NwW8W9GWGJebNkY4rr1VDnd5jeHCjAIIWRtRLOVh9AooNxelQD+VluznVsZpnnaFoWlStE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQ6440dn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQ6440dn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD9CC4CEEB;
	Mon,  9 Jun 2025 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749499252;
	bh=r4BeCbCBmwsdjJy94zH3aYa1PIhBvKP6oYwDdkiOZRM=;
	h=From:To:Cc:Subject:Date:From;
	b=DQ6440dnj+WKbyq/3yrXtm14ct9/aoFWNhhHLEjMhOgw3LFgqFfhrspdiXnz3Bww1
	 luBd7hjicCIfzYIbxArVCO2kj0bt+1ETZBm/vu0KxNSNmZLzT/IjAnblukt/cWuMh3
	 ma1QZGBW0DyB/mc787RiEfNGVXxOUEMYBALLfgXbMBfHF4djNBbFAElfwvix2uDGQS
	 OAT+zeYUWKNo2VNS9B0bJHZWb8Y5radgt8iKDzk4NTloe44qj3dMDMsatLS4mV/ooD
	 WNCaqtxX9HN1nqLQtV8eZ+SAbj/UuHjNTY/scxielBTAjts14OhWWOE3V62/mfwKrN
	 ZvpS5ZAvARh8Q==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Wang <wangchuanguo@inspur.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/3] mm/damon: use alloc_migration_target() for DAMOS_MIGRATE_{HOT,COLD}
Date: Mon,  9 Jun 2025 13:00:45 -0700
Message-Id: <20250609200048.50914-1-sj@kernel.org>
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
alloc_migration_target() is called instead, the renaming and non-static
changes are no more required but could only make future code readers
be confused.  Revert the changes, too.

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


base-commit: 7af1516cc219fe5ecc2e2ba01e578a75e955d0b4
-- 
2.39.5
