Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D222D4ED;
	Wed, 16 Apr 2025 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777565; cv=none; b=rK3kAYFuJJxYCqVg2u6YTGdnm4nmESMhbbYJ9aXqZExE1mb70RB1DQnLEW/m2gfriLBTc2YVfY2gXwyN8x5iPZulZ7ywO5qJB9RItDPaDlheIP9f9UzQEmIS+NVTQgSUwqzVJnUWe+xggGDB+DE6sM6dwFbjqPXyxmwBja9fJBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777565; c=relaxed/simple;
	bh=C+T3wfxfhPRxkNioz56rR7c+eSN/gWhnmvnMwAnCIno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iObmZlzqjTalg/tm2HSiL309tGWaj2Wwk90e3Vz+03uIf7jIzOCi/AKd+jeKoXx0P1bMcSiN+VK8oRjEsXaNQETBJ5D9FLuuvYHUyH2LhwpspcX0ufsxK+7j7+HYO26/LeMJjeDQiHa/Gy+I8pNf78/aXdcbOyOZ/kJSomPcchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSsJWtUD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSsJWtUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D89C4CEEA;
	Wed, 16 Apr 2025 04:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777565;
	bh=C+T3wfxfhPRxkNioz56rR7c+eSN/gWhnmvnMwAnCIno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSsJWtUDU8hRRLhlhNl/VtJJcqzet4cq04mR3B4LCNcLGuXA5T/uhQq1d9V6d8fcn
	 6LPz3S9lTGld1i8HCiWnVxNdvJ2w/KqX0TFtBkzHH50tzm4AycnWrOxxRSRErvW2IM
	 qAdMjO4q3g2bbHJvBIlXesRh/ldykDY7DXAtk/UB6Me5lZK4tGKxssNZOU/+34JzCS
	 EKAhnq5Z7JHXguSjOz0C/83vvh2yh3x0PhrFd4beIF9ryD892ufu5HgEowX0iDSyZZ
	 LBqmK1jsSkSmJ69pu+V/5Bh0CGT8wpUzDBafJnq7A/0haRIqOo9gJIEqcWfLxte+u0
	 7T5uvuyhKJTjQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/10] Docs/mm/damon/design: document 'address unit' parameter
Date: Tue, 15 Apr 2025 21:25:49 -0700
Message-Id: <20250416042551.158131-9-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416042551.158131-1-sj@kernel.org>
References: <20250416042551.158131-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'addr_unit' parameter description on DAMON design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aa01d0232adc..696a4d738cb3 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -69,7 +69,7 @@ processes, NUMA nodes, files, and backing memory devices would be supportable.
 Also, if some architectures or devices support special optimized access check
 features, those will be easily configurable.
 
-DAMON currently provides below three operation sets.  Below two subsections
+DAMON currently provides below three operation sets.  Below three subsections
 describe how those work.
 
  - vaddr: Monitor virtual address spaces of specific processes
@@ -137,6 +137,18 @@ the interference is the responsibility of sysadmins.  However, it solves the
 conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
+Address Unit
+------------
+
+DAMON core layer uses ``unsinged long`` type for monitoring target address
+ranges.  In some cases, the address space for a given operations set could be
+too large to be handled with the type.  ARM (32-bit) with large physical
+address extension is an example.  For such cases, a per-operations set
+parameter called ``address unit`` is provided.  It represents the scale factor
+that need to be multiplied to the core layer's address for calculating real
+address on the given address space.  Support of ``address unit`` parameter is
+up to each operations set implementation.  ``paddr`` is the only operations set
+implementation that supports the parameter.
 
 .. _damon_core_logic:
 
-- 
2.39.5
