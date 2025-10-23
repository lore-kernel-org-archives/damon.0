Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E820468D;
	Thu, 23 Oct 2025 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182743; cv=none; b=Q335jNEfkxjbcPLD373KKUIT9zghIxumfXz7TzGeWPDpM0gmivk/SblyErU7dyjsZg399xn3xQK2KMewK7YlOU8AangoJd5RedVoFzK2+TMmDfmHjA/R4yDkS30F/VrKr9VQs3PpZjlGbmGcqYvHz8sak7xJJw//9sgrZLrljGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182743; c=relaxed/simple;
	bh=65cmnk/bFjxYU2YnQodxix5UeST3Nn+DSFfFevM1UkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKDimG70jZG1Fvazc2ZzkG1990jlz8ypVx5BGb/S1HSl2CMtEC+XizHloapTDN0HuJ5a7OTtYRwoWgEVRaxYPDK/G3luvDPUvq9jGZy+lWBA2hzx/j6hse7TkFFhmvVzt7/pYFlkgHPogGo+Z2Euie3JPT+z41pYStF0425mQhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seqwKdRe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seqwKdRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1143FC113D0;
	Thu, 23 Oct 2025 01:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761182743;
	bh=65cmnk/bFjxYU2YnQodxix5UeST3Nn+DSFfFevM1UkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seqwKdReZCx9ewGiYXyBY16OiRVxGlN2qhItsNVN4JGIPSx1mSoELriFDcSPxD3MU
	 YJY2WnBCX7OKgsHEMtLs0tvjcteOHiNHrQAq9U3lEwN1Mou5+mU49PsBpejBzl0LhX
	 Zo4gZHOUgWs3fqOsPEmm+gopm5CPAkb4RQFklQenHIM/9B9LY75GOXxG9MzT7ZmYq+
	 g0AgIZOD1TYgBA2FKncrLq/5TUmGg+sRDsJjiISybVWdO0i4Qq8yFXD3W9/zMXOJFb
	 /KevEqQqle25SCJNQt5iDRo8kXVa3kTwLkHvEu3O5Hyqf0UUMh7cecWR8kpWUmgyy4
	 nQgPTEbp0olWw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Bijan Tabatabai <bijan311@gmail.com>,
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
Subject: [PATCH 4/9] Docs/admin-guide/mm/damon/usage: document obsolete_target file
Date: Wed, 22 Oct 2025 18:25:28 -0700
Message-ID: <20251023012535.69625-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023012535.69625-1-sj@kernel.org>
References: <20251023012535.69625-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the newly added obsolete_target DAMON sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 98958975604d..d8a3d6e740b3 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -67,7 +67,7 @@ comma (",").
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
-    │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target
+    │ │ │ │ │ │ :ref:`0 <sysfs_target>`/pid_target,obsolete_target
     │ │ │ │ │ │ │ :ref:`regions <sysfs_regions>`/nr_regions
     │ │ │ │ │ │ │ │ :ref:`0 <sysfs_region>`/start,end
     │ │ │ │ │ │ │ │ ...
@@ -264,13 +264,20 @@ to ``N-1``.  Each directory represents each monitoring target.
 targets/<N>/
 ------------
 
-In each target directory, one file (``pid_target``) and one directory
-(``regions``) exist.
+In each target directory, two files (``pid_target`` and ``obsolete_target``)
+and one directory (``regions``) exist.
 
 If you wrote ``vaddr`` to the ``contexts/<N>/operations``, each target should
 be a process.  You can specify the process to DAMON by writing the pid of the
 process to the ``pid_target`` file.
 
+Users can selectively remove targets in the middle of the targets array by
+writing non-zero value to ``obsolete_target`` file and committing it (writing
+``commit`` to ``state`` file).  DAMON will remove the matching targets from its
+internal targets array.  Users are responsible to construct target directories
+again, so that those correctly represent the changed internal targets array.
+
+
 .. _sysfs_regions:
 
 targets/<N>/regions
-- 
2.47.3
