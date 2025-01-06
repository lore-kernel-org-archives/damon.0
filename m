Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6E1E22E6;
	Mon,  6 Jan 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192058; cv=none; b=dxnn0Yxf3V4FTkuuQkrtYtk7e+34hqcfmrQG8/Gc8gzpfBBP1/FE9zeadhhXlSh9VbDhUJGoq9106G0+G04vfpeFJDBX6vl5axqUp0u5ruK8YnbwmesYg1WBEedg67f3fpH4SKeLbFP+tHJwPmtDXKk9nFWSffQMhtQnWgSkPOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192058; c=relaxed/simple;
	bh=oFPXEWb9JL0M/GNEujeFNfcJBtpZBlejNr2S5S6yqXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQtzUJ4kojlppb2l50mfLlBmIWLj45uoyUXgx2vWGV0VLst1GbhkgtLtOnXyw5NC9LLh+tNV+lTqcZy2Eg10GXrKHihZ77hHXjZ6yMluYBtyZ/YC6/49klQ2SB4QDXZeHmVSwMOSyKGTNMQfhMSuFLZ2liR8NxVSI78ezJA6SCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhE5uq9D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhE5uq9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9A3C4CEE3;
	Mon,  6 Jan 2025 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192057;
	bh=oFPXEWb9JL0M/GNEujeFNfcJBtpZBlejNr2S5S6yqXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VhE5uq9DamFxNfZYqsSpq0lvAYvPr3uAJ4ockYbe/7+0yn95MTpHYGsUOvea3ZvWO
	 s4klGcX5zL0QGDkzE22qLtLc0qpOvD87gq+4P5bZ/Lfr6+VuziqYK7WnrbYWZ8g+zv
	 VXE6QFZMXs/bK30osi73P64aXhhMCzKlQ4Q0oCLh9A013zBnjUkss/Y5RrAIUmxEEk
	 brgb2rgFk0nWbuD9sXaCuK7bF4dO4Z1VWCHWCaExeBDoF/AvYu9JPRexo2oZ30gXia
	 8sfWPJ5F68beNYGku2YU37vrQLL6O4NS3wbQSD2ifIq0aVyX+Cd7y9cQ10Xxg5Lvvm
	 jrmDK//yvN8IA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/16] Docs/mm/damon/design: document sz_ops_filter_passed
Date: Mon,  6 Jan 2025 11:33:54 -0800
Message-Id: <20250106193401.109161-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new per-scheme accumulated stat for total bytes that passed
the operations set layer-handled DAMOS filters on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 158d0a4e1d7f..68145972cb20 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -552,6 +552,8 @@ scheme's execution.
 
 - ``nr_tried``: Total number of regions that the scheme is tried to be applied.
 - ``sz_trtied``: Total size of regions that the scheme is tried to be applied.
+- ``sz_ops_filter_passed``: Total bytes that passed operations set
+  layer-handled DAMOS filters.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
-- 
2.39.5
