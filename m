Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48EE1DA53;
	Wed,  5 Mar 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213658; cv=none; b=OXa10P+TwaD2JOnf6SKycusjWrA8zu1WvxvTI5x+qwcrx5i+KHC0AC1or6vDVf/JkaYRzqsENfNJIcM2+ajNCrBTQ3IrnkQryEKNR3QpHdqpZlfMRjqMbr2tXA7gS+3ki4tfmyRV9TAF2Cjr+yzfhYVQWwoYvDgaMqefAef8Gcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213658; c=relaxed/simple;
	bh=OCW6zeu41eNyvtNz1UUuqO+JafK0NgyekccSUEYRBr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/YkgJ3VWQM5Vq8hDrYp4Lr/F/ggjR5PhEEu5DtbiWxMmaMG27RCZtlJq/zHt8MeGeLJHmDuPA3Q/uYXUfI8rXqT9Wb1iZVbG4X9+GYbFLTGwStn/OMQILyaou43xZkzPFohppydTSIdssakijlU4jNjKmmCtiNABmrr5opwphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXk7GY8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXk7GY8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AECEC4CED1;
	Wed,  5 Mar 2025 22:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213658;
	bh=OCW6zeu41eNyvtNz1UUuqO+JafK0NgyekccSUEYRBr8=;
	h=From:To:Cc:Subject:Date:From;
	b=dXk7GY8f35AQFsdUOOncj/EtIa0cMnodbiNkrOBAM9O0zf31DmDo6J5ycrrvjkwC4
	 VtsKu851qkrDfrRzeRVic69d8rEEfXlhoaxm36OtJ+zkSWod4fzT4CgHmXDGfYpI9L
	 /mHf8NVSm9PlL+z/krOZXDqwXpTJzqsTS6BPtd5j83NuVI4urViYod1WU0FWE5YNk+
	 IuTcLhaZoKhywILdU1Opa2yCCMQT63rk9kP8TIpHs3vpWKdh71TbdDLcTYUxhCzH3M
	 D1HRCxpFd3wUnK0dv1hmUkfzOHV9C8x+ePjzbiqF5X7RRtGq7ZCrIE/p/3xlsZ5BLc
	 lPR/wpI27GQ4Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: add sysfs dirs for managing DAMOS filters based on handling layers
Date: Wed,  5 Mar 2025 14:27:25 -0800
Message-Id: <20250305222733.59089-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filters are categorized into two groups based on their handling
layers, namely core and operations layers.  The categorization affects
when each filter is evaluated.  Core layer handled filters are evaluated
first.  The order meant nothing before, but introduction of allow
filters changed that.

DAMOS sysfs interface provides single directory for filters, namely
'filters'.  Users can install any filters in any order there.  DAMON
will internally categorize those into core and operations layer handled
ones, and apply the evaluation order rule.  The ordering rule is clearly
documented.  But the interface could still confuse users since it is
allowed to install filters on the directory in mixed ways.

Add two sysfs directories for managing filters by handling layers,
namely 'core_filters' and 'ops_filters' for filters that handled by core
and operations layer, respectively.  Those are avoided to be used for
installing filters that not handled by the assumed layers.

For backward compatibility, keep 'filters' directory with its curernt
behavior.  Filters installed in the directory will be added to DAMON
after those of 'core_filters' and 'ops_filters' directories, with the
automatic categorizations.  Also recommend users to use the new
directories while noticing 'filters' directory could be deprecated in
future on the usage documents.

Note that new directories provide all features that were provided with
'filters', but just in a more clear way.  Deprecating 'filters' in
future will hence not make an irreversal feature loss.

Changes from RFC
(https://lore.kernel.org/20250220194646.37726-1-sj@kernel.org)
- Fix sphinx error on usage doc change
- Wrodsmith commit messages
- Rebase on latest mm-unstable

SeongJae Park (8):
  mm/damon/sysfs-schemes: let damon_sysfs_scheme_set_filters() be used
    for different named directories
  mm/damon/sysfs-schemes: implement core_filters and ops_filters
    directories
  mm/damon/sysfs-schemes: commit filters in {core,ops}_filters
    directories
  mm/damon/core: expose damos_filter_for_ops() to DAMON kernel API
    callers
  mm/damon/sysfs-schemes: record filters of which layer should be added
    to the given filters directory
  mm/damon/sysfs-schemes: return error when for attempts to install
    filters on wrong sysfs directory
  Docs/ABI/damon: document {core,ops}_filters directories
  Docs/admin-guide/mm/damon/usage: update for {core,ops}_filters
    directories

 .../ABI/testing/sysfs-kernel-mm-damon         |  16 +++
 Documentation/admin-guide/mm/damon/usage.rst  |  31 +++--
 include/linux/damon.h                         |   1 +
 mm/damon/core.c                               |   9 +-
 mm/damon/sysfs-schemes.c                      | 119 ++++++++++++++++--
 5 files changed, 153 insertions(+), 23 deletions(-)


base-commit: d5ce0f2fd108557fb138adccb203441d0d70f1c4
-- 
2.39.5
