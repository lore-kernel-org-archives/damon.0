Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC11F8AF4;
	Tue,  7 Jan 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281099; cv=none; b=lNip2TpCnc8A9cjApC3xHDpmPCdCTJ6MBttMLViNTtLg9NDAj65mCU4hy4qEwJbCY8qPeMmIqAaOm1Mk9OK6oxyfdPMy1XYEK3OlWLNz8ElIdOTkoocrrJzhFh/Z7YGlLisJ5xhRKQ7sgrY94g4izH8gzYdxIUJKbOLwETMpWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281099; c=relaxed/simple;
	bh=jufb0sHL1L5krYu5xZ9uPN7YQ+OC0Evk60XYWVCJy7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jjAiCuzw7VeYZJmIhA0/q46q+q2jQRYbNGq0WfL7DLJ8OYwOmZnb8tTgYpcqsFMiXVsy1M0BFxaoktkzYuipiw2R+zFbY8o33FFDRoBCsZiGtcQTFCKgyf6JX9nIeinuoRlgQDZLupbzBEQ4NdJBcPHJmzedq8oGINnQHAf0iQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRBPMc02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRBPMc02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD29C4CEDD;
	Tue,  7 Jan 2025 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281098;
	bh=jufb0sHL1L5krYu5xZ9uPN7YQ+OC0Evk60XYWVCJy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRBPMc02CwogiTNi5E146sB1ifHgBJA2nZgVoBsESH66eEv+lycI38Q0SlqUy/xOb
	 NMjHjZ2SEar/bVvmTWvwe3wt+Ux5Q844tzODLcdHJIrM4z5n4hz46NI0Io8laCjXPv
	 ihZwM/eHP4dY8rtp+QXrFDijR6eGOxOw/OfKBab9RajpdYr5N+dkpD1hdDn9DeY1BM
	 7sw5pC7TaW6wJY0E2yUVytvSrPLTWV0C3GQTVMQh54VcSxYJq/qQ/wgbqx81AtrBiW
	 jCYlXyACtoCqGDvcV2hLKxjDlfpI/SDXQ2UJ/ad0hTi6/yF0bHa6KpNFi83UWmk1wv
	 af20A1eVXJHSg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/10] Docs/admin-guide/mm/damon/usage: omit DAMOS filter details in favor of design doc
Date: Tue,  7 Jan 2025 12:17:38 -0800
Message-Id: <20250107201739.79484-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-1-sj@kernel.org>
References: <20250107201739.79484-1-sj@kernel.org>
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
index 71cf29ae8502..8df3357dcfa3 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -411,13 +411,17 @@ Each filter directory contains six files, namely ``type``, ``matcing``,
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
@@ -434,14 +438,9 @@ pages of all memory cgroups except ``/having_care_already``.::
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
