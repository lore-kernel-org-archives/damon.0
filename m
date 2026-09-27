Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D63E4C94;
	Sun, 27 Sep 2026 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510746; cv=none; b=uk4IjODY/JJe1Ga+CR6LQ0TT2JwBVyLOFGSX+fwuKVgx+yf/IG0juEymxUyVm3DmwmyMTWm0mJZYENb0RSawvzxmSve75SohCsfLw9t2DothW+ktaU8byyHPJgEZ8d6HyM0yAN2Rg6+yKY4DqzxUPgu7bhZYYgaf3pasDdpZ/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510746; c=relaxed/simple;
	bh=t2Ayh/V3yOhaCco/Ksb2VKM78F5vRUyfVCyVZgO+tDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZ/rTLS/E+tpGYEaPSCa974zFiQhlrSrp+bN97p6xejHmETEM4X31T5UjwQQ9RxSQTyFx7msVpB2OGEc5uzT6sxaJrN9NrvKZeeZ4rAxMnYXmIPs3M74mlQju308stjq/fSgPnxhqzt0DFJH/S3Mehhv4jIqkoKdA0njuMiEdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2qtEcqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2qtEcqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2FE1F000FF;
	Sun, 27 Sep 2026 12:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790510744;
	bh=DtftUOhUj36KHzHH8SjyqQEupBI7pETe4V3hNrol9A4=;
	h=From:To:Cc:Subject:Date;
	b=e2qtEcqkmjVz8dCb2K5NGSGGje+z1wYZys269NNmJz+GX8OOSLHIb/gBF786OB+ou
	 uB4Ay9iv28YlY/f/vngo3LVs4D6ZDDX7Jc5E7FaKlwMmBKMd1WyyhMIZ4GnpGvGcx1
	 3Gxsp8fwjQYTs1GLfjs79kDdjcLSGrumVshL7ru3CS3i8KWOl1+DjpuoQr7R/WBNy+
	 VLnh7HuMWmeh5D8otkf/iXa3esRr7CXIfK4Epa2Tx2YrkjSeyi4qI9nlKX+hRigzw8
	 P7hnRcogkia6O0rfZB6TmRfr60HLdk+6iRckpaDyzyQgZ2XxsBE6psKs5dvvfpaISd
	 bnTLXf+R94ORA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [RFC PATCH v4 0/7] snapshot_set_swap_area() unpins the previously selected swap device and
Date: Sun, 27 Sep 2026 05:05:24 -0700
Message-ID: <20260927120533.50484-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add repin_hibernation_swap_type(), which looks up the new device, clears
the old SWP_HIBERNATION flag and sets the new one under a single swap_lock
acquisition.  The same-device case is short- circuited so userspace can
re-select the same swap area without tripping WARN_ON_ONCE and -EBUSY. 
Switch snapshot_set_swap_area() to the new helper.

A failed lookup now preserves the previous pin instead of dropping it, so
a bad SNAPSHOT_SET_SWAP_AREA leaves the prior selection intact.  The open
and release paths keep using pin_hibernation_swap_type() and
unpin_hibernation_swap_type().

The race was identified during AI-assisted review of the SWP_HIBERNATION
pinning series.

SJ Park (7):
  mm/damon/core: introduce damos_quota_goal->complement
  mm/damon/core: add complement argument to damos_new_quota_goal()
  mm/damon/sysfs-schemes: support quota goal complement flag
  mm/damon/tests/core-kunit: test quota_goal->complement commit
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
 mm/damon/tests/core-kunit.h                   |  3 ++
 samples/damon/mtier.c                         |  2 +-
 10 files changed, 97 insertions(+), 21 deletions(-)


base-commit: 1c2b8d2725f84b43fabe3b3e9628c91db8ca6c65
-- 
2.47.3
