Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BF2417D1;
	Thu, 30 Apr 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558824; cv=none; b=CM/CFraJ01ZA3dhjIKRYNuu5+ywuUEGwQ1uK1JwuUNILGb23lVVQv4YVk3CbEvxWYtmgh4qq2QVR4iPdXOZnQ54fe3yn73RZynDZPOHyIth8f01ObPDti3ovp6t/dHpdEjQQtRcTMhVNJ6MexIcCviAgamT+gb0DUb9VjR9UzyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558824; c=relaxed/simple;
	bh=E5B83sxytNbrJA03BcZbM7JWpgeC4uEKhNZhIPTXLRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A72s2RqKd/dr0fXuLXoejQ7RUxdjN8Nkx2bft9qSy9XZagY6bHs98RVkgD1JbfCigheLN7bgIgsKDL3WlNHnFjCDXNYElPR1pMWfmtO8zWfFCVthyB1QoqninK3Jw64J6n4BCVuc0a3Ls06JQjG3TM9EaFMwC1iscavQn30LCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRbEIf6a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRbEIf6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BA0C2BCB3;
	Thu, 30 Apr 2026 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777558823;
	bh=E5B83sxytNbrJA03BcZbM7JWpgeC4uEKhNZhIPTXLRo=;
	h=From:To:Cc:Subject:Date:From;
	b=LRbEIf6awF9GrzQHSCeFiaYvy903gtqCV+HgwbkqOFZFGvxD5x08gJMRWOXLpDYRn
	 +Yz4K8zuyUyChAVgciqoQcZMzmelqRfTaY1f5ihkMCZ25HWjbbnRQ9gzUBiWUJ/pfY
	 r5ssQwLNjYyDDGtGXPLJyNetUgtKKtBmP5MXb9WFCU6ciJgHJFnlBlz4LkZDPhfiHL
	 y5hyqeXIGEVl/UKhsca8NuW5PRaJrtPg7AKtlXcxM+7/mrWImKt7+/jjaiRsR0ZW9M
	 K1w8vIoiNdjvvYqJWF/lnEgbwCQ5Gp4cEP2QdwZR1NCdGlu/LeK+ljBfP0f0DspW1N
	 jSBEZeNZE4m7w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 0/2] mm/damon/stat: add kdamond_pid parameter
Date: Thu, 30 Apr 2026 07:20:08 -0700
Message-ID: <20260430142013.80993-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_STAT doesn't provide the pid of its kdamond, unlike DAMON_RECLAIM
and DAMON_LRU_SORT.  This makes user-space management of DAMON_STAT
unnecessarily complicated.  Provide the information via a new parameter,
namely kdamond_pid, and document it.

Changes from RFC v2
- v2: https://lore.kernel.org/20260425203309.108879-1-sj@kernel.org
- Rebase to latest mm-new.
Changes from RFC v1.2
- rfc v1.2: https://lore.kernel.org/20260416002149.87090-1-sj@kernel.org
- Detect and use fresh kdamond pid.
Changes from RFC v1.1
- rfc v1.1: https://lore.kernel.org/20260414235912.98174-1-sj@kernel.org
- Close the parentheses of error handling block.
Changes from RFC
- rfc: https://lore.kernel.org/20260414053742.90296-1-sj@kernel.org
- Fix damon_kdamond_pid() failure handling.

SeongJae Park (2):
  mm/damon/stat: add a parameter for reading kdamond pid
  Docs/admin-guide/mm/damon/stat: document kdamond_pid parameter

 Documentation/admin-guide/mm/damon/stat.rst |  7 ++++
 mm/damon/stat.c                             | 38 +++++++++++++++++++++
 2 files changed, 45 insertions(+)


base-commit: b8e00b62c650b2aa471195f663301118fde889c2
-- 
2.47.3
