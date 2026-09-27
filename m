Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D93B7B7B;
	Sun, 27 Sep 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790514339; cv=none; b=fM9XuhZLDDlO3ZSvIAe2ln2r1CAsqEW6bjLWdJBgSVjRHmmIVORl3/8Dh/e0BG5MrDkX2vUWxve58PxmH23ZcqL3vaTCXgKoH9TyT0zH4XvBIPr53/4sW9rYk//tbWD+JDexsTMsLfOWM2CMeUww1PMIhu6UEYEhXFD/sacepj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790514339; c=relaxed/simple;
	bh=1SYAtlMRR5wl79nTZRwJY8oqRGgvDFEedUUwNB4Qva8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRqJo4CMvp0srKJGH5GdSnESzabJNqbi+vf/K1j5U8OBtq57QsY2xOBQKwn3SH8lB4r4Vesr21vI1lAFUHqjDNzAdEWimBKdWjWegT34DUJG5t0JU7gz00mVkpwP96gw13AUykDBCjHPGmc3wku3dC6TuWHia4920K2BRN1Z+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9DpxoZx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9DpxoZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403C81F000FF;
	Sun, 27 Sep 2026 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790514337;
	bh=oa25LE79ry5QOlFm4MMWdpvS+Odfoq8gGYf5zdJ0oxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W9DpxoZxG6fy+HMrPslnKMmNxQHYsrLXlE7idgjRblWdGxdIDr1Zs9hzZQoZP6F6D
	 WqvXcVHNqgmfa/avRAbsuCnOzeg/bTgW6qj1NepP1S0ciypdykD38DmYM1ukofpw/v
	 HfGO2ZVZ4DYF7WgSmp+mLUqu0mNpKeRUy4VmTEnR549uK7cS+F/u/wFtfn/fhIqciI
	 u48bj2kH20JLxYmnc9KIWy53IVmr7FpmK3aP2yFUwj7fIc66HU8ENnLNIkBY3dotIk
	 bD1DXjoD5dtdBPZNkcOj8c0UFajZmyjuoexicoNz4BzR9A32Yi4+qt0sWhDtn9SIZ9
	 x+Vn2AskUvQBw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v4 0/7] mm/damon: introduce damos quota goal target metric complement flag (was: "Re: [RFC PATCH v4 0/7] snapshot_set_swap_area() unpins the previously selected swap device and")
Date: Sun, 27 Sep 2026 06:05:29 -0700
Message-ID: <20260927130530.60524-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927120533.50484-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 27 Sep 2026 05:05:24 -0700 SJ Park <sj@kernel.org> wrote:

> Add repin_hibernation_swap_type(), which looks up the new device, clears
> the old SWP_HIBERNATION flag and sets the new one under a single swap_lock
> acquisition.  The same-device case is short- circuited so userspace can
> re-select the same swap area without tripping WARN_ON_ONCE and -EBUSY. 
> Switch snapshot_set_swap_area() to the new helper.
[...]

Oops, this cover letter is completely wrong...  Please ignore.  My tool was
using the commit message of unrelated commit due to my mistake.  I'm so sorry
for the noise.

Attaching the correct cover letter below.


Thanks,
SJ

=== >8 ===
mm/damon: introduce damos quota goal target metric complement flag

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

Changes from RFC v4
- RFC v4: https://lore.kernel.org/20260927120533.50484-1-sj@kernel.org
- Fix a typo in test code (s/complementfalse/complement/)
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
