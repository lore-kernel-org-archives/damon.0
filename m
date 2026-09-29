Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8003AE6FC;
	Tue, 29 Sep 2026 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668882; cv=none; b=hvxC+UnxPLYD4pfjAXDp5YTdjip+7doVgoPGqKJLcKb8v1sVDRYU70iZOloIdNBGESRUgsnq7nttisoKzWFSXcj7VWaazsYVYfNQuy9c5myeRVpqrrq+bx8PWoruvAl/M0jHQIvcDYsheQA+qWHP9OmIHybtJItEg/1UfnKOjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668882; c=relaxed/simple;
	bh=PmlbDtksbQyBLekA8pPOMkFDXd2oDQXvK0e+zqfxaxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGLnci7cnPAJvm6Rd2HMhnEt+6JuKeVuja6Pol9gWAVaBTv7lp6b2XMpdxvRWA1uQ7YKplf81vLbHM9IYnB/zNxVlVsY1Ta6xbZy6OEVboLkp9kt8un6UG0vAiK4bapNXK8EfGBXBYfTH4a51jMToV8BJDeUbXjGZudqnKwiZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjZv7jzf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjZv7jzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3825C1F000FF;
	Tue, 29 Sep 2026 08:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668880;
	bh=a6KTCI9sEhcxrT3X+lHb4vCE6F9AtSD5ReH23TAc3Jk=;
	h=From:To:Cc:Subject:Date;
	b=EjZv7jzfA7ZhfyPnj6C565KTMPF9Xp9dnV2T7/7V2B6zmLT4IOSRbMTM0iWRDwKxZ
	 Eior/5Cq15wHnuYwodm5mcQeGLg15ze8xOEbUJr1yd/GfD3ey41ChrmUoj2Tvon6Vc
	 X//5FAf87wv+cfIz2WF99Oras9LC7ZuXmoX7gcIHJ+b6nWEb9odN5PnBs+rv6aDNFH
	 QZsueVeWxTr0BPafzyAIr+/xrRTdGwf3kOAQ48IMbZ5HpE/ANprjg1l1UeucZ/93Na
	 iLizpBqTT3a6NxuuAsQybdeCJ0mckJ6dRGAEhD23gUDGfRwuN/3hL0HhDqEbcJMmp/
	 Xsy3H/2c4q2LQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: introduce damos quota goal target metric complement flag
Date: Tue, 29 Sep 2026 01:01:03 -0700
Message-ID: <20260929080113.41708-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aim-oriented DAMOS quota auto-tuning assumes the aggressiveness of the
scheme (quota) and the quota goal metric are directly proportional.
Depending on the scheme setup and usage, keeping the relationship can be
challenging.

For example, let's suppose a memory tiering approach for higher upper
tier utilization.  One common idea for that (TPP) is utilizing two
schemes, one for promotion and the other one for demotion.  The
promotion scheme migrates hot pages from lower tier to upper tier,
aiming for high utilization of the upper tier.  The demotion scheme
migrates cold pages from upper tier to lower tier, aiming for head room
free memory of the upper tier.  Both schemes and their goals are in
direct proportion.  However, for this kind of use case, we need to
implement two different goal metrics (per-node memory utilization and
free memory ratio) while essentially the free memory ratio is just a
complemented value of the utilization.

To avoid adding too many new metrics, we are adding metrics that turn
out to be really needed for each found use case.  For example,
some_mem_psi_us, node_eligible_mem_bp and hugepage_mem_bp don't have
their complemented value version.  But it is not really difficult to
expect use cases that their complemented version can be useful.  For
example, hugepage_mem_bp use case may need a way to reduce the hugepage
ratio.  That would require a complemented version of hugepage_mem_bp.
Adding a new metric for each of such use cases could make the number of
metrics unnecessarily high, and discourage flexible usages of DAMOS.

Add a new flag, quota goal complement, to allow flexible tuning goal
setup without unnecessarily increasing the number of metrics.  The flag
specifies whether to use the complemented value of the given goal metric
for the tuning.  For example, if the complement flag is set, the upper
tier memory utilization ratio metric works the same as the free memory
ratio metric for the tier.

Patches Sequence
================

Patch 1 introduces the quota goal complement flag API and implements its
behavior.  Patch 2 updates damos_new_quota_goal() to receive the flag.
Patch 3 update DAMON sysfs interface to support the complement flag.
Patches 4 and 5 extend existing kunit and kselftest to cover the new
flag.  Patches 6-8 update design, usage and ABI documents for the new
feature.

Note: Below is additional information that is not intended to be added
to the final commit message.

Test
====

I tested this feature using the latest version of DAMON user-space tool,
damo [1], as below.

On an idle system having 10 GiB single node memory (node id 0), fill up
80% of memory with page cache.

    $ dd if=/dev/zero of=foo bs=1M count=$((1024*8))

Run DAMOS with pageout action for 80% of free memory, but using
node_mem_used_bp metric like below.

    $ sudo ./damo start --damos_action pageout \
            --damos_quota_space 100M --damos_quota_interval 1s \
            --damos_quota_fail_charge_ratio 1 4096 \
            --damos_quota_goal_tuner temporal \
            --damos_quota_goal node_mem_used_bp 20% 0

Because the system has more than 20% node 0 memory utilization, DAMOS
does nothing, as expected.

Run DAMOS with pageout action for 80% of free memory, using
node_mem_used_bp metrics with complement flag like below.

    $ sudo ./damo start --damos_action pageout \
            --damos_quota_space 100M --damos_quota_interval 1s \
            --damos_quota_fail_charge_ratio 1 4096 \
            --damos_quota_goal_tuner temporal \
            --damos_quota_goal node_mem_used_bp 80% complement 0

Because the complement flag is given, it is effectively the same as
node_mem_freepbp metrics with a target of 80%.  DAMOS reclaims the page
cache ~100 MiB per second, until the free memory ratio (complemented
memory utilization ratio) reaches the goal, 80%.

Changes from RFC v5
- RFC v5: https://lore.kernel.org/20260928093342.16584-1-sj@kernel.org
- Rebase to latest mm-new.
- Drop RFC tag.
Changes from RFC v4
- RFC v4: https://lore.kernel.org/20260927120533.50484-1-sj@kernel.org
- Fix a typo in test code (s/complementfalse/complement/).
- Extend sysfs.sh DAMON selftest for complement flag sysfs file.
Changes from RFC v3
- RFC v3: https://lore.kernel.org/20260923101454.5748-1-sj@kernel.org
- Rebase to the latest mm-new.
- Add tests done to the cover letter.
Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260919011359.88921-1-sj@kernel.org
- Avoid quota goal value underflow for some_mem_psi.
- Handle complement flag for psi goal with unset last_psi_total.
- Pass complement argument to damos_new_quota_goal() from core and
  core-kunit.
- Explicitly document no-op complement behavior for user_input.
Changes from RFC
- RFC: https://lore.kernel.org/20260918142827.85303-1-sj@kernel.org
- Avoid quota goal value underflow.
- Fix usage doc for number of files in each goal directory.
- Rebase to the latest mm-new.

[1] https://github.com/damonitor/damo

SJ Park (8):
  mm/damon/core: introduce damos_quota_goal->complement
  mm/damon/core: add complement argument to damos_new_quota_goal()
  mm/damon/sysfs-schemes: support quota goal complement flag
  mm/damon/tests/core-kunit: test quota_goal->complement commit
  selftests/damon/sysfs.sh: test quota goal complement flag file
  Docs/mm/damon/design: document damos quota goal complement flag
  Docs/admin-guide/mm/damon/usage: update for quota goal complement file
  Docs/ABI/damon: update for quota goal metric complement sysfs file

 .../ABI/testing/sysfs-kernel-mm-damon         |  6 ++++
 Documentation/admin-guide/mm/damon/usage.rst  | 15 +++++----
 Documentation/mm/damon/design.rst             | 15 ++++++---
 include/linux/damon.h                         |  4 ++-
 mm/damon/core.c                               | 33 ++++++++++++++++---
 mm/damon/lru_sort.c                           |  5 +--
 mm/damon/reclaim.c                            |  5 +--
 mm/damon/sysfs-schemes.c                      | 30 +++++++++++++++++
 mm/damon/tests/core-kunit.h                   |  5 ++-
 samples/damon/mtier.c                         |  2 +-
 tools/testing/selftests/damon/sysfs.sh        |  3 ++
 11 files changed, 101 insertions(+), 22 deletions(-)


base-commit: af86bf5500fcc53d591e1000e6e08dec1227fb06
-- 
2.47.3
