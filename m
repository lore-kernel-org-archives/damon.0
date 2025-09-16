Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEDE571;
	Tue, 16 Sep 2025 03:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993026; cv=none; b=XqQdN2ae70E4lHupCetLZ9oh0Fx0JmdWIBQoH53L01YB1rx5WFh2f5YAwIW/rGhbci59ZXy1LJB0i40ZBk6TsRtIL5fIBI+SKf7F8sOYdljuGtAfXgD/H1uYBpQgnRZBDbGd3HJjleOp3G2S19OJmw+h1AJHCxJBHIeFA0R1HPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993026; c=relaxed/simple;
	bh=4jBYgC3B4Dhd303wNeVwtug9xXIozvpiLACdj/mfJYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/Mbruted249aofeK7M1IyIjNTLxVovPJi/W6XrSOb/C8KmH6V0IfBJS2WTBx2r4nhQjMkIEDuka6Gkrsi7dHzbbVI46yTMBudGqwbl1oEICWOcXn7sdnzQEgOcQeh3Om99NwX+RJBklbb9yPZRK+npND3wVZdrjPGdUgKEGk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULJFTSLE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULJFTSLE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03CAC4CEEB;
	Tue, 16 Sep 2025 03:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993026;
	bh=4jBYgC3B4Dhd303wNeVwtug9xXIozvpiLACdj/mfJYQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ULJFTSLEjhLTnYaJ8VomtdHFO0MK/5GOkZ22GgT+1bTFxtoBt8+GSa5nq8l+JSY1f
	 2Y0nDf2wb4/7+ttj3lRbssKPjo1MyXHGF6inHxMejvMLrP3n68iBYHREs7X8G7V1lm
	 giNsIqwwFwaan3hOhWzCB4mcR7KcQcrr1gbTrrXRImM3lBqj8zTPva1CSisUxEvZcs
	 OuaEHZ0w6ex5GE50uPoNp7Jc4lHxS7dtNYdI+H14S62t31ACopua7aXA0HeOCFxyoM
	 CjYlfVciNMpRRP7LEVbC461b4yb1YyeKbGHkZAUuKIB3+tkJglb3ilx64ZhE/QwyPp
	 o8S6g+oqUbS6g==
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
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 0/5] mm/damon: misc fixups and improvements for 6.18
Date: Mon, 15 Sep 2025 20:23:34 -0700
Message-Id: <20250916032339.115817-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misc fixes and improvements for DAMON that are not critical and
therefore aims to be merged into Linux 6.18-rc1.

The first patch improves DAMON's age counting for nr_accesses zero
to/from non-zero changes.

The second patch fixes an initial DAMOS apply interval delay issue that
is not realistic but still could happen on an odd setup.

The third and the fourth patches update DAMON community meetup
description and DAMON user-space tool example command for DAMOS usage,
respectively.

Finally, the fifth patch updates MAINTAINERS section name for DAMON to
just DAMON.

Changes from v1
(https://lore.kernel.org/20250915015807.101505-1-sj@kernel.org)
- Separate [1] damon_attrs param_ctx usage as a hotfix patch
- Make nr_accesses reset condition easy to read
- Collect Joshua's Reviewed-by tags

Changes from RFC
(https://lore.kernel.org/20250909034353.7064-1-sj@kernel.org)
- The RFC was only for the first patch
- Rebase and wordsmith the first patch
- Add a few misc fixes and improvements for 6.18 to the series

[1] https://lore.kernel.org/20250916031549.115326-1-sj@kernel.org

SeongJae Park (5):
  mm/damon/core: reset age if nr_accesses changes between non-zero and
    zero
  mm/damon/core: set effective quota on first charge window
  Docs/mm/damon/maintainer-profile: update community meetup for
    reservation requirements
  Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example
    command
  MAINTAINERS: rename DAMON section

 Documentation/admin-guide/mm/damon/start.rst  |  2 +-
 Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
 MAINTAINERS                                   |  2 +-
 mm/damon/core.c                               |  6 +++++-
 4 files changed, 13 insertions(+), 14 deletions(-)


base-commit: 4178fb3b4a5145053746caab556b1c5f5538bf3f
-- 
2.39.5
