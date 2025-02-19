Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EEA1B87D3;
	Wed, 19 Feb 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002513; cv=none; b=MZKIEWGRFe6Sf80vHeobwtWwHdNE5aEdbqHo3RK4e7OwtFWKHdNj6AjDleodCv61qBhlk/Jjmj30wqBo4GpBQGQa4M16NylUNei11cR9p4mB+yflaUxX+c0IvpFCOQ+6VOc7ZOUNFarc8YV4gbKHUdpnFg97Y8qQoQ4d69MLSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002513; c=relaxed/simple;
	bh=7aXG288GKsmJEUMHvSCsXouWGoPLqAhvFvvNlLGMzxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPuqIZnSjia8T4mpY70RsFysLIX5SAifuGB6o+zA4R1yj55qNOiGehj2oq8O14l1p0DWjLYpocLufRmNwhYvC/FnQx78PfvYgB6d63DYHVthrILwiuoj0XuXcKD9cEIY59rhm3X7F5EgnLFT8adx2aPbc38eE4cO87Qby/zIUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqlKe+Ze; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqlKe+Ze"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4916C4CED1;
	Wed, 19 Feb 2025 22:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740002513;
	bh=7aXG288GKsmJEUMHvSCsXouWGoPLqAhvFvvNlLGMzxY=;
	h=From:To:Cc:Subject:Date:From;
	b=OqlKe+ZeB1HsTgFA1Q4l1j9hLMGOGpuO8ofEB/f16NRA2SlZDnv5TNQZwhTGf3XPz
	 LXGTnd84UDd5msxH7Fm7TjOIt+lPksqIujXZRTV8HzNs4Dq/LHksWYNIr4RhcghOrh
	 i/TakMuUf5S1BxFlFsekKByXja2t0jTKC9FtIB5tug+m0UedbUZKalDSQysC8FJ2/n
	 WfGqq+eNasvG0HhieheKM9cZ1NIy3FObq+KYVpvK7Nt8+uu7JgiNGOlLrIutijj1Zr
	 qGB9wCX8He3mKTNK+a5QchDSgfxNK6RVWh6Sb1aIEe336rvOTl/VhAQQhgBIf0eo6c
	 tkKO8BmgB5Hew==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/2] mm/damon: introduce DAMOS filter type for unmapped pages
Date: Wed, 19 Feb 2025 14:01:44 -0800
Message-Id: <20250219220146.133650-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User decides whether their memory will be mapped or unmapped.  It
implies that the two types of memory can have different characteristics
and management requirements.  Provide the DAMON-observaibility
DAMOS-operation capability for the different types by introducing a new
DAMOS filter type for unmapped pages.

Changes from RFC
(https://lore.kernel.org/20241127205624.86986-1-sj@kernel.org)
- Rebase on latest mm-unstable
- Wordsmith commit message
- Add documentation

SeongJae Park (2):
  mm/damon: implement a new DAMOS filter type for unmapped pages
  Docs/mm/damon/design: document unmapped DAMOS filter type

 Documentation/mm/damon/design.rst | 2 ++
 include/linux/damon.h             | 2 ++
 mm/damon/paddr.c                  | 3 +++
 mm/damon/sysfs-schemes.c          | 1 +
 4 files changed, 8 insertions(+)


base-commit: a2130e89cbd08ddb6f023b0b10eb87ebbc67add1
-- 
2.39.5
