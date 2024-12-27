Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D901F9F53;
	Fri, 27 Dec 2024 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735333716; cv=none; b=DCUP678+OA+m1yVlMhN+cO4eeS7KXfNdKxDscdfkAzeTJ/3YjI7JVSCMaov4+iRUlH3cT9dODq4EuchHvJc/B/R24DgfTT1XJ7BCAqbLTQ/nteffjvErnAjAwY/K5MncEORdlogq6GTEt7KWVdgERpxg4+cRUiwGr8pQA6/g+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735333716; c=relaxed/simple;
	bh=0f0Lpal72vM2StRK6no1fT4yLv96CM7EUNHKZOxnDlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQVWaYlldXByoEKzbWgA2s5Dt5Wrsjc/e0x1u++lGcp7y6XliSHzpGSAPcwX94yhAaJ1beQXH/fEcgN58jmxyh3budjzezZ5w/rHdG8RabS1ag20eX7d7mCHFFe/6h5Kl5pGAbxxbjJ+9uEl4UZVdiObnsNZWcT7iTPJsQopTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzYuJeoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzYuJeoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658FFC4CED0;
	Fri, 27 Dec 2024 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735333716;
	bh=0f0Lpal72vM2StRK6no1fT4yLv96CM7EUNHKZOxnDlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzYuJeojgz6j6mJfTpQyOG4GrL1j41APF9tsSPSYFQMX0DRnSeBmavDD/7J/0/A69
	 AlAbH/E30qYO/C4wnJEZQjluLnWJUNF2/Ouoc/IbtS/FvYMYWvJXCVRpZAbK49Z9f7
	 bMWp+d+KqNhLT5aABhtLng25SkuvJL/ozeazzuc/oSNMBTfC9PdRZExmDViMp+0Lob
	 n3toGZI8sjyyZpS7epAyEkSebAciE67v+CJt7vPdFnqtKadshGuq5tgg55c8Bktikh
	 pBhUrrf2YHV8j1e19xhg0/dQF20QW8l3J/JKoXo1ujbba8Li9ykDVaNmIm7ulStnjs
	 CRcSYClGGGNdw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 09/10] Docs/admin-guide/mm/damon/usage: omit DAMOS filter details in favor of design doc
Date: Fri, 27 Dec 2024 13:08:18 -0800
Message-Id: <20241227210819.63776-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241227210819.63776-1-sj@kernel.org>
References: <20241227210819.63776-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON usage document is describing some details about DAMOS filters,
which are also documented on the design doc.  Deduplicate the details in
favor of the design doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 29 ++++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index a891e830c2a1..fa8a5e4199b1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -417,13 +417,17 @@ Each filter directory contains six files, namely ``type``, ``matcing``,
 file, you can write one of five special keywords: ``anon`` for anonymous pages,
 ``memcg`` for specific memory cgroup, ``young`` for young pages, ``addr`` for
 specific address range (an open-ended interval), or ``target`` for specific
-DAMON monitoring target filtering.  In case of the memory cgroup filtering, you
-can specify the memory cgroup of the interest by writing the path of the memory
-cgroup from the cgroups mount point to ``memcg_path`` file.  In case of the
-address range filtering, you can specify the start and end address of the range
-to ``addr_start`` and ``addr_end`` files, respectively.  For the DAMON
-monitoring target filtering, you can specify the index of the target between
-the list of the DAMON context's monitoring targets list to ``target_idx`` file.
+DAMON monitoring target filtering.  Meaning of the types are same to the
+description on the :ref:`design doc <damon_design_damos_filters>`.
+
+In case of the memory cgroup filtering, you can specify the memory cgroup of
+the interest by writing the path of the memory cgroup from the cgroups mount
+point to ``memcg_path`` file.  In case of the address range filtering, you can
+specify the start and end address of the range to ``addr_start`` and
+``addr_end`` files, respectively.  For the DAMON monitoring target filtering,
+you can specify the index of the target between the list of the DAMON context's
+monitoring targets list to ``target_idx`` file.
+
 You can write ``Y`` or ``N`` to ``matching`` file to filter out pages that does
 or does not match to the type, respectively.  Then, the scheme's action will
 not be applied to the pages that specified to be filtered out.
@@ -440,14 +444,9 @@ pages of all memory cgroups except ``/having_care_already``.::
     echo /having_care_already > 1/memcg_path
     echo Y > 1/matching
 
-Note that ``anon`` and ``memcg`` filters are currently supported only when
-``paddr`` :ref:`implementation <sysfs_context>` is being used.
-
-Also, memory regions that are filtered out by ``addr`` or ``target`` filters
-are not counted as the scheme has tried to those, while regions that filtered
-out by other type filters are counted as the scheme has tried to.  The
-difference is applied to :ref:`stats <damos_stats>` and
-:ref:`tried regions <sysfs_schemes_tried_regions>`.
+Refer to the :ref:`DAMOS filters design documentation
+<damon_design_damos_filters>` for more details including when each of the
+filters are supported and differences on stats.
 
 .. _sysfs_schemes_stats:
 
-- 
2.39.5
