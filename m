Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6B13635E;
	Wed, 18 Mar 2026 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773806042; cv=none; b=uHOVlMCupaSjrRnAkgfGbFUt2bqTzy7nvyuvF+8P5aBBa8mKfXSrqPBOD0OMuxcwmkPsXUglHhhhPb+Xy39/ZY6KFAbML1FzXSu2kcZKZDboh1pj/w7nyjNTykb8AIx68HHgEtLdxQy+zZU/9yIrbjc8m31LcW4NG+ya1mNTRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773806042; c=relaxed/simple;
	bh=6CatznSLTNYV80vtabVt4rhKS2msE5JzlPGM+/AcAPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AMTF3b0H+IChkZZwsSNg3HmN1z+obMU7xuYxs+MQAaZ375VTgQ2DJVCJn5p8pHfuGkgrLfIsAKENAXXB9fkpSzwR/JUlN/avra2FFSmvxRJ2VBF6+9Feo6v2+xoVmK/5Ylxum4KU+tluorBzUPq01z0oSo5cobyMxWFBBeVQeo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCFRJ0rv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCFRJ0rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DDCC19421;
	Wed, 18 Mar 2026 03:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773806042;
	bh=6CatznSLTNYV80vtabVt4rhKS2msE5JzlPGM+/AcAPM=;
	h=From:To:Cc:Subject:Date:From;
	b=gCFRJ0rvMNhZZOKla+65Id6mo9bEnsay0KZtgmg2nEc6VVIzC5cFtHevqyv52Rksi
	 r9ADgxA+jitpnSqdWc3Eli8zBEWQMZwPpp0gbyUi7+01NwJP71eBwMHEpTStmkvGtB
	 cJego1Qs71MlgERmEFO6zXeJVvHVOHVaXA/EzT8ll6sJuhFyyRknQzWK/knQ2caqGw
	 V4V05yPZfzLbnHGPi4ShQPpqOCmnZ8TP/NbeLDxnbGfxrUEVu4Ie9CpXaXL595Q3YK
	 LF3iajum8gCSHtU3del9g4xuaOhFOcumXDIxP3OoqpY9HBS1PzvxUDJSb9ngCVglSe
	 /enH9MZq/cLrw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] Docs/mm/damon/design: document DAMON actions when TRANSPARENT_HUGEPAGE is off
Date: Tue, 17 Mar 2026 20:53:47 -0700
Message-ID: <20260318035349.88715-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

MADV_HUGEPAGE and MADV_NOHUGEPAGE are guarded and they are not available
when compiling the kernel without TRANSPARENT_HUGEPAGE option. The DAMON
behaviour is to silently fail [1] in when DAMOS_HUGEPAGE or
DAMOS_NOHUGEPAGE are used, but TRANSPARENT_HUGEPAGE is disabled. Update
the DAMON documentation to reflect this behaviour.

[1]: https://lore.kernel.org/66131775-180b-4b9f-b7ce-61a3e077b6e6@huawei-partners.com/

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/20260316140822.2033181-1-gutierrez.asier@huawei-partners.com)
- Wordsmith description.
- Rebase to latest mm-new.

 Documentation/mm/damon/design.rst | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index dc37402c0fee9..838b14d225193 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -460,9 +460,13 @@ that supports each action are as below.
  - ``pageout``: Reclaim the region.
    Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
+   Supported by ``vaddr`` and ``fvaddr`` operations set. When
+   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
+   fail.
  - ``nohugepage``: Call ``madvise()`` for the region with ``MADV_NOHUGEPAGE``.
-   Supported by ``vaddr`` and ``fvaddr`` operations set.
+   Supported by ``vaddr`` and ``fvaddr`` operations set. When
+   TRANSPARENT_HUGEPAGE is disabled, the application of the action will just
+   fail.
  - ``lru_prio``: Prioritize the region on its LRU lists.
    Supported by ``paddr`` operations set.
  - ``lru_deprio``: Deprioritize the region on its LRU lists.

base-commit: 809b8b9fc1374abb1b1b50fbd0260085b0832b2e
-- 
2.47.3
