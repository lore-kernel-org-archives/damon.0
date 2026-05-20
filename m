Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59B2D9EFF;
	Wed, 20 May 2026 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240083; cv=none; b=ctOzZIrtU7nzkafjzA/KBxInlJ4JrYTVVN7LBTRB1aumWt6w/kZZBDZ2rwTer6kfwSxJhBZdyVXIbhL/S0fYCdxmQmIIXtsMlhIh/NInj4NWJmQWCheRPvvf86j29GYDeCbgMPnFTHBUISvKBv+5nz2JvGlv5Kya5MACLhONijM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240083; c=relaxed/simple;
	bh=IeU2rIkr3A7pk5FRRKcSwSz4g4NXXmbDTArq1sCHZ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoY82EOWHI84VfS3XR6LwW8opJsWaSJj6csMesst8hYvs5LvWvEFbbOMddW+IhHND7iUy/s1AyT9Y1mpJjvG/uSzYfXXrf3U6xy+38tvzzvKvCXP+FTqCaCHkSDyv2f8WkCVpvj2fguJX2d1Z+ekkqTllfULsP/jw8kH90mZ4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPdBqzaN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPdBqzaN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6674E1F000E9;
	Wed, 20 May 2026 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240082;
	bh=EaKGk24Z7ZdkbvdHfuSkBUwjfEj8QPAEB7faP87DITc=;
	h=From:To:Cc:Subject:Date;
	b=OPdBqzaNraSbHm9bHtnmYlCyua6gaP78FWQB/jYLt5UA5oEwoNjr4Ze0hoJ6FMAPg
	 F7CWhLtw+LVi2UyvJpB2eM/DaTLzxySQ4JQw0aOYMiI8qLYlfLQZR8A7yTi+J7UU3J
	 xEvF7Djp4M5j9atLHOjkIpZKfUmgqHiHFDNLr0SWhFkGbnOSYJx84AQ7+/9geK1xGh
	 rlJlvHnIUpK+awIuLGEHgoAIcRgDKh2iOIYTJnigCohyHR3JldYysi8BTeRatht1t3
	 1l79YWLcZZCb2rFJxgNGRJbVfs9Kg2HbJwFLFj94Ws8aH6e3wL2IPtL4xhBZ27LBon
	 T1BkOfzppwQeA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH RESEND 0/3] mm/damon: reposting three reviewed patches
Date: Tue, 19 May 2026 18:20:58 -0700
Message-ID: <20260520012104.93602-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reposts patches that were reviewed by the DAMON maintainer
but not yet added to mm-new, for more visibility.  From their last
posted versions, only minor changes including commit subject update,
Reviewed-by: and Acked-by: tags collection, and rebasing to latest
mm-new were made by the DAMON maintainer.

Sakurai Shun (1):
  Docs/mm/damon/design: fix three typos

Zenghui Yu (1):
  Docs/{ABI,admin-guide}/damon: fix various typoes

niecheng (1):
  mm/damon/core: clarify next_intervals_tune_sis update path

 .../ABI/testing/sysfs-kernel-mm-damon          |  2 +-
 Documentation/admin-guide/mm/damon/usage.rst   | 18 +++++++++---------
 Documentation/mm/damon/design.rst              |  6 +++---
 mm/damon/core.c                                |  3 +++
 4 files changed, 16 insertions(+), 13 deletions(-)


base-commit: f4f9ecd6383da01075a0be8f9c08b82152061fd0
-- 
2.47.3
