Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D52309AA;
	Thu, 25 Jun 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782364086; cv=none; b=jdcVLTRPApO5cwEq6shsubUN2WtQIXaM9644Rsz03Mksfois/DGcPCRiqbE2RZVSC4hxKw+pbthB3+v9isPpAa2IX02GfZfr7fT1QVMRmEMbVVF9wVFhr+/FEVCdn6IYgx0vJHacSMF1NRK2I2/wsXsll5uDthz9YdTC0JAP1a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782364086; c=relaxed/simple;
	bh=IC2F2cMimek156nolJU8+lZbaKXwjmHP3WDWu2+nvbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elLVsvC/0/ni2ZvMov/Da2bDwRoomgJquOengMh+1H6NFYHkZiTw9xGbsal3wzd7MtQX+KLOgnYd1G0B4AXSLFZrI8h2ZoPM5fv4jpRW76dB6yvOiM7hbg09BWc+wklfJHcQTa77epEUYEMbW62HZcUMm3ZuK9+lc1okh8Nx0l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h97HS0bX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h97HS0bX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CF21F000E9;
	Thu, 25 Jun 2026 05:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782364084;
	bh=BmpagdOaIAQomBWNFhud4TOCk8WnRyUMTV0ERkN5fWI=;
	h=From:To:Cc:Subject:Date;
	b=h97HS0bX2lgKH7mBsHMi5Ge2jdMoiskR/xFX6HOnHrvZj0Fdl2bY/FsHYpyhGu+du
	 nw278SEcuJZgtp0qM9ES6PIsgbDl81jg9qXwwFbaEUbcAZPkXw/Xr6CncxwWpmRxm4
	 gszK//V7J2ilwJDxsY04ADvw+yAdGcltWnX55zb4+NnEyMJDJGLjCoSABqiz6WzSW0
	 +MciHIobFcZU9rqTBmpVKOXhsTYhY1asV0BzjV7030F1RFj3Evl1RsT6zDmur0rMvo
	 CBUqNKJPwK9mugZPTwvoKgSrgTLJ2LaEjE/kJrEvgVMvuK6txkIdW3xpV3Aml36Qvs
	 kdkeNQ/pxrIiA==
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
Subject: [RFC PATCH v1.1 00/11] mm/damon: update, optimize, and clean up doc, tests, and code
Date: Wed, 24 Jun 2026 22:07:43 -0700
Message-ID: <20260625050756.91115-1-sj@kernel.org>
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

Changes from RFC
- RFC: https://lore.kernel.org/20260624142008.87180-1-sj@kernel.org
- Rebase directly to latest mm-new.

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


base-commit: 09ff70563340c38d31012044b9c6c18f225f4fbf
-- 
2.47.3
