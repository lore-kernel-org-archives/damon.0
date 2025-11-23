Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB662DF134;
	Sun, 23 Nov 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923428; cv=none; b=MGorp7mGHsvYav9EUTaA6IPh2GJrMeJd1wVMMBK6sPJnHbdd5sheSpOc+e3Hc76RTBGC0olGOiY9amp5R9fnSMwFyELAKX6uDAGobGA47xQkvNNQyf1CoatLTMwlVTS+QPhwrdHRfSVy0rdiUoaUSl5EZtwQyL3fUEF4xy5ss7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923428; c=relaxed/simple;
	bh=ihzFy5TOJPnYv7zeqZ3FA4BsW8yTIpVlYGwomLZgsUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPqTjDPZ6Vd6XJx5whlUizTzy/f0IVMsjRq+rmZiVLCGFnBNLXZ6dmghieBIIIXaTRsqsMyQMvA/7sOowVxBjhlUrtYMhj0fwoYSz48zZyRjQAAuRDV734mJL6aHV/Z4UnAX5P3J69vjn/RsdB8l1WwZWBSv32oHH+YYKa90pcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iiM7b3dV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iiM7b3dV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571F6C113D0;
	Sun, 23 Nov 2025 18:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923427;
	bh=ihzFy5TOJPnYv7zeqZ3FA4BsW8yTIpVlYGwomLZgsUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iiM7b3dVNQ4X2OiyrZkf0LKuyuwDddtr10cyC02fxUSnJKk6aEKb0yrRfFh9PQHQ9
	 J165637B4tbSLIC4BlPYbwqLkm62A1Q2vuhmoKXxqi0favHEjmQyv5oiypoK1AsLC5
	 lq4hZZdFZUC9t6hTVHEC3fQPhak49Zylx2V05NvGw4Q28SGOTR/4wKjKshgWq5rLJR
	 6mx2lINXEmsh0AVIH/ulu6muPvzJRlSxS+N0PkvSNvXXxvkzAms0948oeBgls0AdSh
	 unjZM2AGydYVFcS1GQCKFYDk1NDwOAm9B6IhSz/8dAWNWg0nOO8MjU7SQ7r7FhmoVJ
	 g1LvJ8B+S016A==
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
Subject: [RFC PATCH 10/12] Docs/admin-guide/mm/damon/usage: update for max_nr_snapshots
Date: Sun, 23 Nov 2025 10:43:24 -0800
Message-ID: <20251123184329.85287-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added DAMON sysfs interface
file, max_nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d0944bd78964..7da4c002cb39 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -87,7 +87,7 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
@@ -543,10 +543,11 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
-``sz_ops_filter_passed``, ``qt_exceeds`` and ``nr_snapshots``), respectively.
-The files are not updated in real time, so you should ask DAMON sysfs interface
-to update the content of the files for the stats by writing a special keyword,
-``update_schemes_stats`` to the relevant ``kdamonds/<N>/state`` file.
+``sz_ops_filter_passed``, ``qt_exceeds``, ``nr_snapshots`` and
+``max_nr_snapshots``), respectively.  The files are not updated in real time,
+so you should ask DAMON sysfs interface to update the content of the files for
+the stats by writing a special keyword, ``update_schemes_stats`` to the
+relevant ``kdamonds/<N>/state`` file.
 
 .. _sysfs_schemes_tried_regions:
 
-- 
2.47.3
