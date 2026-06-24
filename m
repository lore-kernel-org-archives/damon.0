Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11503BED75;
	Wed, 24 Jun 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310820; cv=none; b=mSJC5BG4z/waA+HKzId4LtvD3gmzK4IGAo0xb4QmyhoWXTce2oQ/NUvmZOsSk5ouGOb1Jh9SsboH9sa8XpQQ46JouKn9O5/ir03krW0JEIUWhn9SWjWfz2BNTQRTcfTPYJD1Iualhg1I8I624g6+ZXgB+z5tg0LsXo561aQsFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310820; c=relaxed/simple;
	bh=ySbn1fs47Qi9tC2NgHzlmMjeN8mCYPWSYniQgOYZNhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxaj2bIsf8Oibv6yVk56okpUhrJXmabUNXgCktqYV7zGdn3i0yXN4eP6ZUA6GTXgzVa2P35ksBHsc8szWYWvcCjSFFXfROpvFIGS0ddLGE4stQC/1oBxCmZXYD/+aGG2AiGEbDbOuTghohkf66MRnWj4ColbQSqWwAKBWYbU1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAgkz+O/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAgkz+O/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951341F000E9;
	Wed, 24 Jun 2026 14:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782310819;
	bh=DJajJ6C8GLY+N9uEH7jpwp8hPpWryUvttF8AzRaLQYw=;
	h=From:To:Cc:Subject:Date;
	b=PAgkz+O/7OxDk2fOT0fUDrXFwnePUhWrU3gVf2PYiU7jxZI3dX88PVVKb+XuGGhdS
	 4jIKiEulixFT3gs4wizds4JiGYKtYGw7IYmh6O8oO+oQRaCvL6oa/dcpK3l2m+sas4
	 ABL/ND6fZvexkg+/mX4bK9Ja29jYPc0/g0OjJsWfKouVEEbM9aiLnPt3FOnpIIdspK
	 WXW3MwJR5faCndTkPeU5PfGvW0P0vQkP+CVO9yaS/2mP87T0K8fy0P/7AX6OeNcnPE
	 IpTJq8R3nvL3BDEpsnOh3SPqDnhKUmNDoU4pG3mH0AlJqjGMcY8fRqmAtNRUp3gwmN
	 ReGKHg8zw+8JA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
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
Subject: [RFC PATCH 00/11] mm/damon: update, optimize, and clean up doc, tests, and code
Date: Wed, 24 Jun 2026 07:19:56 -0700
Message-ID: <20260624142008.87180-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 2 update the design and ABI documents for recently added
DAMON features.  Patches 3-7 add or update more unit and self tests for
DAMON to cover recently changed or added functions and sysfs files.
Patch 8 optimizes damon_commit_target_regions() to skip unnecessary
adjacent ranges setup.  Patches 9-11 clean and fix up recently added
DAMON sysfs interface code for readability.

SeongJae Park (11):
  Docs/mm/damon/design: update for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
  Docs/ABI/damon: document probe files
  mm/damon/tests/core-kunit: test damon_rand()
  selftests/damon/sysfs.sh: test multiple probe dirs creation
  selftests/damon/sysfs.sh: test {core,ops}_filters/ directories
  selftests/damon/sysfs.sh: test dests dir
  selftests/damon/sysfs.sh: test all files in quota goal dir
  mm/damon/core: reduce range setup in damon_commit_target_regions()
  mm/damon/sysfs: split probe setup function out
  mm/damon/sysfs: split out filters setup function
  mm/damon/sysfs: fix typos in probe_{add,rm}_dirs: s/attr/probe/

 .../ABI/testing/sysfs-kernel-mm-damon         |  40 +++++++
 Documentation/mm/damon/design.rst             |   2 +
 mm/damon/core.c                               |  22 +++-
 mm/damon/sysfs.c                              | 102 ++++++++++--------
 mm/damon/tests/core-kunit.h                   |  21 ++++
 tools/testing/selftests/damon/sysfs.sh        |  70 +++++++++++-
 6 files changed, 206 insertions(+), 51 deletions(-)


base-commit: 197a7eb91f786e5deeb1dfea35076c01ebd37ce0
-- 
2.47.3
