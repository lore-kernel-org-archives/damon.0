Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720932DECC2;
	Sun, 23 Nov 2025 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923427; cv=none; b=dTni3FAEfG09Y+SLJWPE4XD8+hG0xmCePnbrJNFdl3rRahMaIwRSwsKHP6v79+0WIlf1SEWjQ8h5Vp5eQoDIjlrXx+C06ZwixvvEOZqOwkKHipf5qGuWEKFVGlpAEQOZLYtjOJl4gGnzygYJomxXHA3djvd/6dy4oAi7Ecyd+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923427; c=relaxed/simple;
	bh=iXEcDN8E6cxYy3isQfAsdFaACSzfCgupWIVQKmv8ny4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTWXQx0c1z+SfksDhtjV8vqWSyrgBBARQ8/H6GUdKCp6g7LJlMw5s5Y52l3Y6sbm+7/nwsBaVu6hTi8IBHeimbrGHeQNF1ZeFAvks7N+x+W1uSACD447Bood/SflvnRdyjGp8R275EpwLQMeUW9L/Zi847fCUOAoKO1a6Fo9Qok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDRk/cn/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDRk/cn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61D8C19421;
	Sun, 23 Nov 2025 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923427;
	bh=iXEcDN8E6cxYy3isQfAsdFaACSzfCgupWIVQKmv8ny4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDRk/cn/AEJQHJM38Tao7V9q2kGxm1ykxzMdjMBo54eYpg72gExF2HFdDNUPwdHgN
	 wI02Rr2O7iYuV8vOhM1K4McnURJ9R89ykquKUPEO1JWyiqqsqjt6YLiS6g/3J/pP9Y
	 noY4ltkqc5TWabMoj9UQPRKkzjyBGw7E7qcioIccd0m+fEMymoonFze+t/Kn2HuCGK
	 M6lVuwXRhmteHw8B1K+ueIjL5wgFBEQIXlcy9afA5pw+zefV+qYquw6bBovJ7ZN2LS
	 9NpJhnmd8SXc+mtaQEXW95AHxGqcrXYzQque2fZJXXbKrKEybK0rDGJ+pPKLHQUq3X
	 VjFIbbEFgRUyg==
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
Subject: [RFC PATCH 09/12] Docs/mm/damon/design: update for max_nr_snapshots
Date: Sun, 23 Nov 2025 10:43:23 -0800
Message-ID: <20251123184329.85287-10-sj@kernel.org>
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

Update DAMON design document for the newly added snapshot level DAMOS
deactivation feature, max_nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5cc7b7d662be..7fd819b8bbf7 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -720,6 +720,7 @@ scheme's execution.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
 - ``nr_snapshots``: Total number of DAMON snapshots that the scheme is tried to
   be applied.
+- ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.
 
 "A scheme is tried to be applied to a region" means DAMOS core logic determined
 the region is eligible to apply the scheme's :ref:`action
@@ -741,6 +742,10 @@ to exclude anonymous pages and the region has only anonymous pages, or if the
 action is ``pageout`` while all pages of the region are unreclaimable, applying
 the action to the region will fail.
 
+Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
+non-zero and ``nr_snapshots`` be same to or greater than ``nr_snapshots``, the
+scheme is deactivated.
+
 To know how user-space can read the stats via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:s`stats <sysfs_stats>` part of the
 documentation.
-- 
2.47.3
