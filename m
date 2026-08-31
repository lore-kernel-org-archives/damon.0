Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355551354E;
	Mon, 31 Aug 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188556; cv=none; b=jEpeCD2RvdMW9Lxqn+fSODivAU+Z+R5He9/DVZXdigfqccNCuBTS0tDR4C2jCrPS3JZWTbe23gg1hHBbeTAn9k5fWj6nT2o3ORaaZ/KMCQDA4X1Y2i7kXtEIj5yaoOqAf1Nj56UU04st72hqJpwik5InPQc+qFrkKQETx3u2eos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188556; c=relaxed/simple;
	bh=ROZEUFnahx8YJ0dCH9RcIfnDNsXYnwZUHDkvm8/fyUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/whS7nT/ZzCUyiNc+Z3lYYl4YfBbgIJvxxV1uAnG4e6BqgtvofbdX1+19s3A8rd5zqRVY6gQt5lZ8vF/vUz8CDTcfIIYXxTvENPVYZ+ICOQq0i+ON2vaBVwPGRp5ZYS25qCQ9XUq3FRN+AOOKZrG8f/m3enZQyAo3zKfhpb3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0YuHnBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0YuHnBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C238D1F000E9;
	Mon, 31 Aug 2026 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188555;
	bh=AyvY9IIUeA8/wq0mVdMqWHFeuah1T8v5iyraiZ5SRJY=;
	h=From:To:Cc:Subject:Date;
	b=I0YuHnBq3ryHN4v6fO+Gay2QtKjKVxpWUP7fTVztDe/L7zR3X954DMjI+NPL0Z63V
	 nQbIhcCq3F27F2I/CIsDx2J0FNY4DYDmvyelT448mQzsD8h9MpBBk7YH2v84wqqTqF
	 evzvsz+Y6BCVTw5QQ1q2nOXsraVfPVyZh6GVXJYcS+UOCD7X22wBoWP2xr18YaiE/U
	 GANl2xaF77HLZ+MBdSLFU7DxzRKa6AU5AxtatB876Jr1lw3sTa+ZNHA30Gun7WgrhV
	 gkgxPsOULwSJfaiCsZ61psHwbWyNC2e1+w4WJqfTEuHb/bWPYYeC35WjnmJZEOLbow
	 GHSK0g7FZH80g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Mon, 31 Aug 2026 08:02:23 -0700
Message-ID: <20260831150227.83416-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explanation of nr_snapshots to avoid misunderstandings.

Changes from v2
- v2: https://lore.kernel.org/20260812104002.15225-1-aethernet65535@gmail.com
- Collect R-b: from SJ.
- Rebase to latest mm-new.
Changes from v1:
- v1: https://lore.kernel.org/damon/20260811101841.804596-1-aethernet65535@gmail.com
- Patch 1 word order adjustment: Repositioned "completely" ("tried to be
  completely applied" -> "completely tried to be applied").
- Patch 2: Use two spaces between sentences.
- Patch 3: Add the "Reviewed-by:" of SJ, because he added this in v1.
- Patch 3: Make some minor modifications, Patch 3 can be applied after
  Patch 2.

Liew Rui Yan (3):
  docs/mm/damon/design: accurate semantics of nr_snapshots
  docs/mm/damon/design: difference between watermarks and nr_snapshots
  docs/mm/damon/design: fix typo of max_nr_snapshots

 Documentation/mm/damon/design.rst | 9 +++++----
 include/linux/damon.h             | 5 +++--
 2 files changed, 8 insertions(+), 6 deletions(-)


base-commit: 5c4fade039dbd572ba5ad9cf993fbb56e6a5613f
-- 
2.47.3
