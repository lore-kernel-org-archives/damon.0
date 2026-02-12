Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C091EB9FA;
	Thu, 12 Feb 2026 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877408; cv=none; b=howYRBklWrdGjfb7K7yhsHL0pJ1PYWljH+xJLKDgSujAHXDfeb853m6/jnTevLh+RodWVnlXfIPFbHO+WomSeVblMS33R1C9OmKcEBuL1VxK0rd7dKUuVOKC5Fi2WtK3dk87VUYmMWSJZqUUbZX6QCaDotcLyQD5fbFUNrzBZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877408; c=relaxed/simple;
	bh=Fndn/P+WltNHntvZCHkOzGWVSalmqo/mkzDW9TH8/Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beEcPqDmmMXGPvaq+vK+Ab3g88WLh3sirej7GtN8RaFuqoBzHAs4a/sUtN1RlRA5TuFcLtVz4I0XiWkyez49uyV++lYam6WDigVYOQ8TZPxFLipwKwZRY8UG71IvilHn2nAeX0QAzeidzhWi6ZaSxKo+XC2riLXpMIpJEwzJ2sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7KEiN4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7KEiN4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566EFC4CEF7;
	Thu, 12 Feb 2026 06:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770877407;
	bh=Fndn/P+WltNHntvZCHkOzGWVSalmqo/mkzDW9TH8/Fk=;
	h=From:To:Cc:Subject:Date:From;
	b=c7KEiN4Fwf2qDSAj8/fkkzO/duD7GFGT7ShRVJ6wQ5222tTS12HWIOo4J4P64g8KQ
	 X5ZIv0uTO7iA9m0wJWTdUJQt8ZapzWLPJJT5QYymjJCKzUVTjhgLNCCBMAzDZgddCt
	 LtdLKAHRo4Xr7yoGuQ5m74YS2gE47oi2xVVKiqJJW0FkGWE+2wJ0M8hLehFDJBmBtm
	 UmrNanLPZhAXKfhiPI6FM5T93y+ci6HVziDm+dbUgE35yoC/SWdxClFlgtdGe0bvkm
	 TTUSk9lKjJGQlocyV0GSQ0UMRQK+zJMZZMHGkCfZnqCNIieWPBevALZ2HajdhrgidH
	 0NeWnQ4+EZUOg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH 0/5] mm/damon: support multiple goal-based quota tuning algorithms
Date: Wed, 11 Feb 2026 22:23:07 -0800
Message-ID: <20260212062314.69961-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aim-oriented DAMOS quota atuo-tuning uses a single tuning algorithm.
The algorithm is designed to find a non-zero quota that should be
consistently kept for achieving the aimed goal for long term.  In other
words, the algorithm assumes the goal will be under-achieved once the
DAMOS scheme is completely deactivated.  Memory pressure level is one
good example of such an assumed goal metric.

It is particularly useful for long term automated kernel-only operations
on dynamic environments.  As always, however, no single algorithm fits
all.  When the environment has static characteristics and the goal
metric has no factor to move without additional intervention, the
algorithm is difficult to control and accurately achieve the goal.
Systems running by not only the kernel but with some user space controls
can be examples.  Actually there were reports [1,2] of such cases.

Extend DAMOS quotas goal core API and sysfs ABI to support multiple
quota tuning algorithms that the API callers and/or ABI users can
select.  Keep the current algorithm as the default one, to keep the
default behavior unchanged.  Also give it a name, "consist", as it is
designed to "consistently" apply the DAMOS action.  And introduce a new
tuning algorithm, namely "temporal".  It is designed to apply the DAMOS
action only temporally until the goal is achieved, in a deterministic
way.  In more detail, as long as the goal is under-achieved, it uses the
maximum quota available.  Once the goal is over-achieved, it sets the
quota zero.

[1] https://lore.kernel.org/CALa+Y17__d=ZsM1yX+MXx0ozVdsXnFqF4p0g+kATEitrWyZFfg@mail.gmail.com
[2] https://lore.kernel.org/20260204022537.814-1-yunjeong.mun@sk.com

SeongJae Park (5):
  mm/damon/core: introduce damos_quota_goal_tuner
  mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL
  mm/damon/sysfs-schemes: implement quotas->goal_tuner file
  Docs/mm/damon/design: document the goal-based quota tuner selections
  Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file

 Documentation/admin-guide/mm/damon/usage.rst | 16 ++++--
 Documentation/mm/damon/design.rst            | 12 ++++
 include/linux/damon.h                        | 11 ++++
 mm/damon/core.c                              | 33 +++++++++--
 mm/damon/sysfs-schemes.c                     | 58 ++++++++++++++++++++
 5 files changed, 120 insertions(+), 10 deletions(-)


base-commit: 3c44a1294328e58fcf8708f8d1c2ddcb03178966
-- 
2.47.3
