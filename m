Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE052DF145;
	Mon,  8 Dec 2025 06:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175406; cv=none; b=C8tUTqcAAEb+2ZtuHgitbsMolLoWPEpW3q4iN5BHIPCIA6x7IuSIGRqQSnAAzNLkKflnuqbjvVXZeH38OLFFilXkiTf9HmaHfp1apIju+NC5FZnHoQHga5sfRYKwfBc23ejP3biTc5I/6a1D7Unq83EzJTMItWktVR4u03cN8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175406; c=relaxed/simple;
	bh=kYp0neqPpPeaEbB6UDhepmoNhZxaB6USicxvRIelMVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBJLY1XFAPgGtALrt0E/ik9fYrfrliF3SVYl1YRHX7tde9gJc+hxS5dNP1WNC4wi2NNT0w6ZYEawRjJbWQ4DsZT0BnbnHI7c2actAHJBdEYYKFbrePtyh+FvWvsAUPXxGWeRUQgKzU1YgJRR0GO7KCy6xBAWvSf5XZDOC5YyfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrQsyBz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrQsyBz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED04C19422;
	Mon,  8 Dec 2025 06:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175406;
	bh=kYp0neqPpPeaEbB6UDhepmoNhZxaB6USicxvRIelMVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrQsyBz8XneqoGt7kXomZMNDszLsyaBphQqI9vhbG/YI16Pk0iW7d03rE3DlFfjcH
	 /d2/T5SnePvleWqUN/ynQ6+MkGu1ux7qkdv56zSaWrorVThi7vccv2O7FOU2f30Pbj
	 vWEH2ISNFqZfr0P/g8KhnZLwCw0HuI9E88kyjWBRvlz31dszh+xI/+7zKsh13toUEx
	 Pxc/n6MUXc9E0Qfc5e/wPZiUcvMGqUqreRpJDsQXsBRAFWpf6f0Pb2XRLs4r/i9Pui
	 0Pp70UFcW8yzd9Qeq00aGp5n3F6E4a3Dz4PuEWlnM+QojTeDHRJ1ZaA8eZcXIvnIdR
	 hAMpBTcrwmBgQ==
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
Subject: [RFC PATCH v3 11/37] Docs/mm/damon/design: document page fault sampling primitive
Date: Sun,  7 Dec 2025 22:29:15 -0800
Message-ID: <20251208062943.68824-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for support of page fault events based
access check sampling primitives.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 7fd819b8bbf7..a21973b33bc3 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -117,6 +117,7 @@ to make a reasonable trade-off.  Below shows this in detail::
     <BIG UNMAPPED REGION 2>
     <stack>
 
+.. _damon_design_pte_accessed_bit_access_check:
 
 PTE Accessed-bit Based Access Check
 -----------------------------------
@@ -135,6 +136,23 @@ the interference is the responsibility of sysadmins.  However, it solves the
 conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
+.. _damon_design_page_fault_access_check:
+
+Monitoring-purpose Page Faults Based Access Check
+-------------------------------------------------
+
+The operation set implementation for the physical address space (``paddr``) can
+do the access check using monitoring-purpose page fault events in a way similar
+to NUMA balancing hinting faults.  When it is being used, ``paddr`` installs
+the page protection in a way similar to that of NUMA balancing hinting faults.
+Then the page fault handler reports the faults happend by the installed page
+protection to DAMON core layer.
+
+``paddr`` uses :ref:`accessed-bit based check
+<damon_design_pte_accessed_bit_access_check>` by default, and users can change
+it to use this page faults based one, using :ref:`access sampling primitives
+selection <damon_design_sampling_primitives_selection>`.
+
 .. _damon_design_addr_unit:
 
 Address Unit
@@ -244,6 +262,21 @@ maximum number of regions after the split.
 In this way, DAMON provides its best-effort quality and minimal overhead while
 keeping the bounds users set for their trade-off.
 
+.. _damon_design_sampling_primitives_selection:
+
+Access Sampling Primitives Selection
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Some operations set implementations could utilize multiple access sampling
+primitives.  For example, the operations set implementation for physical
+address space (``paddr``) support two promitives at the moment: 1) page tables'
+Accessed bits, and access monitoring-purpose page fault events.  In future, it
+could be extended for more hardware features such as AMD IBS or CXL HMU, and
+support from the operations set implementation for virtual address spaces
+(``vaddr``).  DAMON API callers or ABI users can select what primitives to use.
+
+At the moment, only exclusive use of the primitives is supported.
+
 
 .. _damon_design_age_tracking:
 
-- 
2.47.3
