Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE0329367;
	Sat,  7 Mar 2026 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772913247; cv=none; b=J0GvRiJ2VMD2/4J3l4sqoUU+HgqLzkj2aSG05E7eBbUHDzO51K9BxKfSeItqVO04fNV//qzf8BsFa/YAu9TX0IU2h/OBrhIkC9f5Pt4RHWfl1zwYl898vBmzd81q1f5eYiH56gSnmhqVLcOm+wRCLkmT26mslPA14D7f/zn5Wy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772913247; c=relaxed/simple;
	bh=7ODZDQJM/Fjl22DmH1XWyzvb3MSVSALXM4f2MjB/9Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1hzhEtylq4iZNhtsgOf2DYifrde05BrUpyH/qowfLaZXnxfOo1aSR9HuLHc2hPUaoIcEiHtbMaB2GRoBHXkexHxqXc1JLRbJQThAJKhezpt9DS3eCuyBeylvptGaGvo/UC6NU3MN6Hf7JjFkz7B3ABJlAJrd0ISj0IFAnrorjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wq2xWmi4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wq2xWmi4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A1FC19422;
	Sat,  7 Mar 2026 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772913247;
	bh=7ODZDQJM/Fjl22DmH1XWyzvb3MSVSALXM4f2MjB/9Bw=;
	h=From:To:Cc:Subject:Date:From;
	b=Wq2xWmi4yYSpo/lcxJhDT7T/lmEBVCzdUEzZ2yMEyV3qoLcloM1VKkdIj7rsIXgVR
	 FYtUGLSd9bra3Wexb8R0tSfamwTQreuDrEcbOSm1wW6I0lhEhhirxA41zJfXd6+qxi
	 DCXY4vwLz3zObm8iS8eQASFKWKJRcJH07joiDvCBU/Zf0KIKR4DrFu8oWq/wpdjko3
	 EhQ0nP2bpfc8BGngw24mek2z0jtmguzblsnmosh3AdMS0CTWU/rmCqpJDbJcBB5eoT
	 vN0XbGWsW1arlYmE5rlmZ97LKGwjLN5FvnoPxNhNN0vmgyhBezB1dp7SqiOjA4uDaW
	 5y4/i99PboWoQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	wang lian <lianux.mm@gmail.com>
Subject: [PATCH 0/7] mm/damon: improve/fixup/update ratio calculation, test and documentation
Date: Sat,  7 Mar 2026 11:53:48 -0800
Message-ID: <20260307195356.203753-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yet another batch of misc/minor improvements and fixups.  Use
mult_frac() instead of the worse open-coding for rate calculations
(patch 1).  Add a test for a previously found and fixed bug (patch 2).
Improve and update comments and documentations for easier code review
and up-to-date information (patches 3-6).  Finally, fix an obvious typo
(patch 7).

SeongJae Park (7):
  mm/damon/core: use mult_frac()
  mm/damon/tests/core-kunit: add a test for damon_is_last_region()
  mm/damon/core: clarify damon_set_attrs() usages
  mm/damon: document non-zero length damon_region assumption
  Docs/admin-guide/mm/damn/lru_sort: fix intervals autotune parameter
    name
  Docs/mm/damon/maintainer-profile: use flexible review cadence
  Docs/mm/damon/index: fix typo: autoamted -> automated

 .../admin-guide/mm/damon/lru_sort.rst         |  4 +--
 Documentation/mm/damon/index.rst              |  2 +-
 Documentation/mm/damon/maintainer-profile.rst |  8 ++---
 include/linux/damon.h                         |  2 ++
 mm/damon/core.c                               | 32 ++++++++++++-------
 mm/damon/tests/core-kunit.h                   | 23 +++++++++++++
 6 files changed, 52 insertions(+), 19 deletions(-)


base-commit: fa1e30b2dede645519bf6743439d3925922651bc
-- 
2.47.3
