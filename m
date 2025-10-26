Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A60129E6E;
	Sun, 26 Oct 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502944; cv=none; b=MqW6ak5bA9Ga16kwtEvw0kewGg0A/sCU3/t8aKNR5kEjvnGar6udgCdX5rsYjQVpH1eiYo/IZQvAHx/0TD/piDh772EpmGaFZ/33LeZjvewC3pTYIeTeVkZ0Kw+D3E4/wrxCqMPJbyoDWnpKMrjT6FsKQ8joU92HLasn/lVvLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502944; c=relaxed/simple;
	bh=GiKZojVeog5YOllrsDes1GwbWKFkabuDbGBFBP0siC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmBYs2DKj6SiOM/Lcm9ITAfmFJZyNOKIPCA2vNOy3EDyauGdZP9eIcth0ypfuPwBdyl5W7S/gvDPfJ5lLoXTju5O0Jvv7ofhR+EmBThLELozbWUK8/bfsDz7OEbJduvxokQuNGJIVM0whFOFAsLqPom+Wp+Nh3O0+ffE47EWejI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6JS8Tx9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6JS8Tx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3600C4CEE7;
	Sun, 26 Oct 2025 18:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502943;
	bh=GiKZojVeog5YOllrsDes1GwbWKFkabuDbGBFBP0siC0=;
	h=From:To:Cc:Subject:Date:From;
	b=l6JS8Tx9QJHnZ/QS+03PmXD+ZLF0mnbSH9X7NFXeo+oY9KW77lstrx8MfPsbmFkfi
	 izQVOMQn/kc9Irh8pG0rCN237YpZHkobm5WXB8DEMkYXZ3oQFihP6tLF5fYMjEZ75j
	 AQ7qfckSBBVjTWpsz0PLmthmt4pPhHGb9vhdazIN+lZJMX8SjoqgcMLDlXynSrzreD
	 /puxr1dv+DraGT738SAjH5KNDJ4cdt4ZVplqPX/onibP7TgGRvO+aaJLZjZwL9y0v6
	 6TdnGn1AnA898sj4g4MVSPCcQzdP+WcD0kvyE11USzfSfZBVhpxGQDJfNKOjcS6EWp
	 LPrzxg0FoWYig==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: misc documentation fixups
Date: Sun, 26 Oct 2025 11:22:05 -0700
Message-ID: <20251026182216.118200-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the subject says.

First three patches fix up issues in the documents, including wrong
explanation of a behavior, wrong link, and a contextual typo.  Following
five patches update documents for not yet documented features and
behaviors.

SeongJae Park (8):
  mm/damon/core: fix wrong comment of damon_call() return timing
  Docs/mm/damon/design: fix wrong link to intervals goal section
  Docs/admin-guide/mm/damon/stat: fix a typo: s/sampling events/sampling
    interval/
  Docs/admin-guide/mm/damon/usage: document empty target regions commit
    behavior
  Docs/admin-guide/mm/damon/reclaim: document addr_unit parameter
  Docs/admin-guide/mm/damon/lru_sort: document addr_unit parameter
  Docs/admin-guide/mm/damon/stat: document aggr_interval_us parameter
  Docs/admin-guide/mm/damon/stat: document negative idle time

 .../admin-guide/mm/damon/lru_sort.rst         | 22 ++++++++++++
 .../admin-guide/mm/damon/reclaim.rst          | 22 ++++++++++++
 Documentation/admin-guide/mm/damon/stat.rst   | 35 ++++++++++++++-----
 Documentation/admin-guide/mm/damon/usage.rst  |  8 ++++-
 Documentation/mm/damon/design.rst             |  4 +--
 mm/damon/core.c                               |  2 +-
 6 files changed, 80 insertions(+), 13 deletions(-)


base-commit: 1148e04980a5471922064ff4b19cd154643da743
-- 
2.47.3
