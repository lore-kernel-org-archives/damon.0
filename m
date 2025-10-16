Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AB2E3B11;
	Thu, 16 Oct 2025 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651263; cv=none; b=XAXqdrUNGcSW1BN9XvC2V8ZThUmufsz49dHq1eo8xVSfIYwkSfH6c0CLrbjgTmTM2Ts9JoJrczIi2qac7xeOr4EnhH9SV0qjNNj/8SNBi0YDSFZo8wAyLN6EJVRYUbvDTztne+VhLtb0OVNP2XeeDBQ7NJfK7zo9YlsAywohnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651263; c=relaxed/simple;
	bh=g99OCDg+O4NaDOs/ndbyxSF/STWXFkeOPJ9vC+7TBxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxwJbHS3FpdAoK6Z523Bi5bWIXgjbhmDwf/sODQgzyvq8dbpVc6DKCn3ZG7zROQAHBaq+ipuMrKeoWnA391xnQzBOUegUQNg1jJduXDucU7zD4Tu/jtN1kLXZ92wWkQUkKV3CMSrpICyeoWtO/XvznLDrXodC2PxREIMILzRS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwtCxPKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwtCxPKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02161C4CEF1;
	Thu, 16 Oct 2025 21:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651263;
	bh=g99OCDg+O4NaDOs/ndbyxSF/STWXFkeOPJ9vC+7TBxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwtCxPKDqmHCnbO7A67EvI3Zlstl4VXZX1AamrcGOZrkXAEICzZIAsxq78wBX+nv/
	 PtSt9V3NfdD4xtGOEd/+vx5CyX6YzOnuQaq/WFOqa6EM1eTfwgKbtqE+qo/DTG+3T0
	 aJgJ2LwxviUNGfqViVRkKk7fkDxFTO4fHzlc/TUdTsi6e1Jcn15UP/94A0dlqAq8bd
	 jApCbDSu/1Fsj5PQNERwnOR7L7R7yngVSpG0P0v3mEeQBgUxDRPFawnQUGjUjppTAS
	 GGi1+rz0T5Z6SCqNigNXpGO2XHzilnI1XroYo285su7QIek5BYiLioImbmCdhNbpLf
	 fIJSKRFX1UU5w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	bijan311@gmail.com,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] Docs/admin-guide/mm/damon/usage: document obsolete_target file
Date: Thu, 16 Oct 2025 14:47:31 -0700
Message-ID: <20251016214736.84286-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016214736.84286-1-sj@kernel.org>
References: <20251016214736.84286-1-sj@kernel.org>
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
