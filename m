Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A61684BE;
	Sun, 18 Jan 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759392; cv=none; b=AnSPMF9JWIx8pJfKpolDD6ncpX+WJLR6r6lFCrK2/k3QldigEDZtHwceJzoq3/Za7WbD07vjOvZjXxvgzk2hly3qn5MYjdFXB2gAS6L0r33xfshulo0xDZ+EJIMjHTr1h1UIF229bi+UjvECaNDy/8ReIz/6iGW7S8uEoJCbUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759392; c=relaxed/simple;
	bh=QNYks7ttqO9vmoAFlbyr+Kp8wOzmYyCyw42vhGbKo9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CW7c9CzLIbk7XFbnSxq5dKpxWB2WrBTnzAHlQ+CfuchvVsQjkXU6uYjb1ofE5+VTkWnE7i/lsDF02bw4GV8g5nn5wa5o0f+Da6+4UDplqzdKMM15WofizqE8IyD7LhN26pw5wV3nuKiPoGZr+xBdrafHFeQXGvmuWQdnKHEU9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1ph9fId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1ph9fId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443C6C116D0;
	Sun, 18 Jan 2026 18:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768759391;
	bh=QNYks7ttqO9vmoAFlbyr+Kp8wOzmYyCyw42vhGbKo9M=;
	h=From:To:Cc:Subject:Date:From;
	b=u1ph9fIdAnZvv9dJCjjcTSv4bbYyqmA328oMhUxvu485T+x7uorCIBD/RYRusOVXA
	 a8JBOWQ6Ee3v9chlzb0necHDvjcvbtMgWfVB5EZ2Zq5SUXvGfD7IuFZ8nbG4j+BJwA
	 K/93Op3MB1fy6zig5Pu7X5hfPHmQzyzL2nNNgqSAVLibscXv9JiVqKaW/CQDufDQhx
	 Q3YKl17q1h6u5Nn9BCloV2Bdv/IwWGQntCP5GYGf3RVAO8dktfaMjkXLi4LElkkkMP
	 CAKMwmhwA2gAJbzhHne5R4IOUEyHVkcgZqu0dN8s/CKcBUhEpHKCExW8EKcwHFKYa6
	 LCe9LZdXfaUIQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] Docs/mm/damon: update intro, modules, maintainer profile, and misc
Date: Sun, 18 Jan 2026 10:02:51 -0800
Message-ID: <20260118180305.70023-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON documentations for wordsmithing, clarifications, and
miscellaneous outdated things with eight patches.  Patch 1 simplifies
the brief introduction of DAMON.  Patch 2 updates DAMON user-space tool
packaged distros information on design doc to include not only Fedora,
but refer to repology.  Three following patches update design and usage
documents for clarifying DAMON sample modules purposes (patch 3), and
outdated information about usages of DAMON modules (patches 4 and 5).
Final three patches update usage and maintainer-profile for sysfs
refresh_ms feature behavior (patch 6), synchronize DAMON MAINTAINERS
section name (patch 7), and broken damon-tests performance tests
(patch 8).

SeongJae Park (8):
  Docs/mm/damon/index: simplify the intro
  Docs/mm/damon/design: link repology instead of Fedora package
  Docs/mm/damon/design: document DAMON sample modules
  Docs/mm/damon/design: add reference to DAMON_STAT usage
  Docs/admin-guide/mm/damon/usage: introduce DAMON modules at the
    beginning
  Docs/admin-guide/mm/damon/usage: update stats update process for
    refresh_ms
  Docs/mm/damon/maintainer-profile: fix wrong MAITNAINERS section name
  Docs/mm/damon/maintainer-profile: remove damon-tests/perf suggestion

 Documentation/admin-guide/mm/damon/usage.rst  | 16 +++++++---
 Documentation/mm/damon/design.rst             | 21 +++++++++++--
 Documentation/mm/damon/index.rst              | 31 ++++++-------------
 Documentation/mm/damon/maintainer-profile.rst |  7 ++---
 4 files changed, 42 insertions(+), 33 deletions(-)


base-commit: 4bdd7e0e4afe2bb6bc27862130f1cd365f3cbbef
-- 
2.47.3
