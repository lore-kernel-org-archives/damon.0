Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4A2DC320;
	Sun, 23 Nov 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923425; cv=none; b=KJmFdcqgLSNOpi7zobqJNlHl7tvQlTtztyB+omerU/R9ZekrBo6jKahxgPgVCyGwLgrZjPRkBi8fEVa902LCBr2spT0XQe85tTEks1DAYbVyLggi3Nn+h3mApuqbgKmHRuWlmwS+xM56Fgkq+E9CpabvhAFZZH29gfqMlgkq+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923425; c=relaxed/simple;
	bh=vPTC/eKfLkll500maYdRrQDlL8kK86gyaCZ9jL7BWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifXs8W3+wyGB1c9rFt/8dK/knMAFO2zHTUlQvfWNRLLUy/VlauxlMF/9tOMrsvPMsQaZWOJkXz1zdIgAzWY0Sji8DggXJ4Iey2XvkY482CuhjSNoQnF+sZW+cYPoJ703DbATIWWeeTdNbASdBst9ZnjqTtqff0jt2uboNHdT6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR3R4cUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR3R4cUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E96C19423;
	Sun, 23 Nov 2025 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923425;
	bh=vPTC/eKfLkll500maYdRrQDlL8kK86gyaCZ9jL7BWDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HR3R4cUbNLbqybOvOYXzWLHXNxghlfQSspgN2RSov7tFY3h3ydIypBfGfHpCLCDan
	 BwObokJtrIAbpDkOYRJFcS3647LBAJo251CSuQlPJ4vGxyOWNSdqetvDp29u1W8n21
	 2kzWyb5F0DjMPOz7ARkx+zG5taQlFN7qpD0SmAVIzJ1ptNJJKLGKYlt6FAkX0O3aq2
	 0sZEC0PsOqPXe5nSdplFJF/D03+uh7F+3BrcVvF/F6Zq+QBa43YqoG8QZyGoBaXySu
	 yifZRO9RXWvt9RlApJcwNya65xh6c85RyVnYEHI1XfSAyFnVLnN0rY8FWTjyNxVWCS
	 1UkyHpR/Z4vRg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
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
Subject: [RFC PATCH 03/12] Docs/mm/damon/design: update for nr_snapshots damos stat
Date: Sun, 23 Nov 2025 10:43:17 -0800
Message-ID: <20251123184329.85287-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added damos stat,
nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2d8d8ca1e0a3..5cc7b7d662be 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -718,6 +718,8 @@ scheme's execution.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
+- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
+  be applied.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
 the region is eligible to apply the scheme's :ref:`action
-- 
2.47.3
