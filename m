Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E9B37EFE5;
	Sun, 13 Sep 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319506; cv=none; b=u0RzBINYG1nzzU+X57SzYryiBBOinNZ2+aFlP3ROeqDuCzs+5GlhCtdUZIbbu34kTy5rzEeWTnqm0uIr4CKvAGc1GDbPb/B6B8W8TUANxeWB2F2l7kJju/wn0uJHeyQHnyXMJy2OseicK7RO0tfcTJF0iKcFxCEKmp8UTCGkhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319506; c=relaxed/simple;
	bh=5Ih8qSxrx+1FoiQrZrDyi0m7BSRP8d4efVZQoDuXGTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZPrx5/6pp+KUnhL/IAWsNjNU5snTLX1sFjFxVZtYSbvGSDswWthQFlXGhZmqx9RRTs5hC9s9NiY57rrbwMk3k7wixiMSAxGsJQ7x//QWfX0ZXGaIJ8oJjBmDMCKmlY6JVyPB/qwii+1sl3TExE0mzO41Crie5+GdxCXt7vYgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyXD0N+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyXD0N+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4031F0089F;
	Sun, 13 Sep 2026 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319505;
	bh=9PbkWTjWrdG2mF2OjLqwQA4JbmDDau4Exk+WU0SHNwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eyXD0N+nDjWX6B6by7NPh5tYhxW4OybmmpxYZ/OlK0iuABcaP0AaYqhjBb6sX1zwL
	 YPPPHERZaWrDknS0ebG29avVbQndRd1wicddhQQYzIkz1xeq7EEL37H4rnHVrygHqs
	 loh6mS31S5CPMG2C32+RYyhrsl9OEguPyX76tuDVZtRVwLuT6ppyFIetb/A6lScmZ2
	 N6NfWY9wcLCQMtiN8KIr3B/gxWdShiqTYN9S5/JfJMAmAyMJaBBTVDVSrCHmMUVPuU
	 pyZCg6Gx+5GRsllDp+tCOxWaqxvFmxwHqFrgu6C4tdWbeQKHDfqn99lS6CHiW7V9Zc
	 fngHZponMfbcA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for hugepage_size
Date: Sun, 13 Sep 2026 10:11:29 -0700
Message-ID: <20260913171133.102366-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added hugepage_size data
attribute filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d3e37400367bd..6b80bce5d678d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -78,7 +78,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/prep_action
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ filters/nr_filters
-    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
+    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path,min,max
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -308,6 +308,8 @@ Writing a number (``N``) to the file creates the number of child directories
 named ``0`` to ``N-1``.  Each directory represents each filter and works in a
 way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
 ``type`` is ``memcg``, ``path`` file acts as ``memcg_path`` for :ref:`DAMOS
+filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
+``min`` and ``max`` files acts as files of the same names for :ref:`DAMOS
 filter <sysfs_filters>`.
 
 .. _sysfs_targets:
-- 
2.47.3
