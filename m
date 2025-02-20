Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F31B423B;
	Thu, 20 Feb 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080811; cv=none; b=fcfAGoGLsICQvV4pMTjHf50+AMwUFkRIJtmMMg775v6wB9YxNRrnKFsdqO2a06uYzqTfUPzLuQaSJK3pMGYR3TDRsA5+WB6aOuk2lc0YH/cNZZCOrRRkHBzJLyaYaIlbmkpwY/5C1AUDlcsTzjnmpy+FC7B4HVyZ/QB1Tud/HGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080811; c=relaxed/simple;
	bh=nMIxHAwHfKNVZ1CT7y7b5ieN44JjiPdFxVVlky/SD/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5XFN0OXIAfxhex+K2otM3MHXKkOuQQUZexPt4ugY7nfbMaa5q2l5T+bdvebYP3keRMZ98f0exe98F7A+Pyv0GTGoJcH3tsN6A3/J2A7zNHmjWMtWLSGiYtYieKmq4GXzqPwInYrx5gIc/S8eIybCxINESH+72Rr7e835xfGJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8Vl2U7L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8Vl2U7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70A4C4CED1;
	Thu, 20 Feb 2025 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080811;
	bh=nMIxHAwHfKNVZ1CT7y7b5ieN44JjiPdFxVVlky/SD/w=;
	h=From:To:Cc:Subject:Date:From;
	b=f8Vl2U7LF7aVgqIkJbwu1aLs9d6CTex8GFKAQKdHAXf7MPG/baCCtzJdD7+unpdYB
	 +im8G6RNDlEXAlmQOjH3/iOah02WF/r21bom+MFBe9/rSv+XL6lEY3DCkBQCQ7zfFb
	 S7/zsWuq5bP1gTkETtBNEL3b2UGJmym9bvXr2Cpr+2yAfdWD6WBVj3DuQShevuxgK3
	 wiLzkPXjRbIzlb2s2GHNDBdPjOVHCnLgirKacitFBKJO/FV1pv/OgiuhY35VMhAbEy
	 ft8Ro3jw5w6XT7M6s0uSFKf/KStRxtt9Bu2uegQTUvxmC6Z0osNNgRlv923grILvp9
	 CFSPjARIIBeuA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: add sysfs dirs for managing DAMOS filters based on handling layers
Date: Thu, 20 Feb 2025 11:46:38 -0800
Message-Id: <20250220194646.37726-1-sj@kernel.org>
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

Add two sysfs directories for managing filters by handling layer, namely
'core_filters' and 'ops_filters' for filters that handled by core and
operations layer, respectively.  Those are avoided to be used for
installing filters that not handled by the assumed layer.

For backward compatibility, keep 'filters' directory with its curernt
behavior.  Filters installed in the directory will be added to DAMON
after those of 'core_filters' and 'ops_filters' directories, with the
automatic categorizations.  Also recommend users to use the new
directories, and noticee 'filters' directory could be deprecated in
future.

Note that new directories provide all features that were provided with
'filters', but just in a more clear way.  Deprecating 'filters' is not
expected to make an irreversal breakge.

Also note that this patch series depend on filters default
behavior change patch series[1].

[1] https://lore.kernel.org/20250220193509.36379-1-sj@kernel.org

SeongJae Park (8):
  mm/damon/sysfs-schemes: let damon_sysfs_scheme_set_filters() be used
    for different named directories
  mm/damon/sysfs-schemes: implement core_filters and ops_filters
    directories
  mm/damon/sysfs-schemes: commit filters in {core,ops}_filters
    directories
  mm/damon/core: expose damos_filter_for_ops() to DAMON kernel API
    callers
  mm/damon/sysfs-schemes: set filters handling layer of directories
  mm/damon/sysfs-schemes: return error for wrong filter type on given
    directory
  Docs/ABI/damon: document {core,ops}_filters directories
  Docs/admin-guide/mm/damon/usage: update for {core,ops}_filters
    directories

 .../ABI/testing/sysfs-kernel-mm-damon         |  16 +++
 Documentation/admin-guide/mm/damon/usage.rst  |  31 +++--
 include/linux/damon.h                         |   1 +
 mm/damon/core.c                               |   9 +-
 mm/damon/sysfs-schemes.c                      | 119 ++++++++++++++++--
 5 files changed, 153 insertions(+), 23 deletions(-)


base-commit: c6ff92c642d665270c718aece87bc33d264d2c00
-- 
2.39.5
