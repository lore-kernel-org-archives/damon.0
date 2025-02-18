Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7554E1DD0DC;
	Tue, 18 Feb 2025 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918238; cv=none; b=oopNR9cuoG/lLi2WHS0AaVBxqrsy8MB5OCPJKdG5a7/gzEVShbNjEQFWcqB2M4FUiaZ5mUrQoRlawLzuyCvAKFc5qthlKceYhbZ+sd9exBiqzzdFufKgOFuftcuV/SJ+OSG2NgDKEnzXlT2BJ5fkFFsgSQmx68IR/0975CDOUfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918238; c=relaxed/simple;
	bh=yF1LvomTuLrF1Mrz41dAsbpRkpACzGsaDPNlm98lWpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q0Q88E89vzobQVQ0szAs6HCwwZZm1Ae2ct2ilFJbNucgIstJgtEG/J0FaM/E/d0QdMvF6U4FUeexKLUoHizOwlNFVDAFc9wPPOHVuXpbNoTqRXN+YC3AldyVj5jR5cWcJu55fpx7ExeWwbQ6bQB00n5mns8UIWzwg+r90fTnnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mytcYbpB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mytcYbpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC197C4CEE6;
	Tue, 18 Feb 2025 22:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918236;
	bh=yF1LvomTuLrF1Mrz41dAsbpRkpACzGsaDPNlm98lWpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mytcYbpBPC7VI/ZarhrxpedSk5sHvFNBVYyrEcfA9Rsaal8g4HwuPOAWKWF22iO6Y
	 zczpBzIhL5Lrq+hI1hi2PiCKeaIYuraCFa0xJv2lDoRy9Gu+V2uc4i+MC0vvHDq6Yt
	 fx7rd0qVHoAGrvhf+BjGKzd/CNgr14hmevFeDNog/U1j3s6ZbXTfGlX66Su6vMua32
	 fvXTxnM+Qb4Kwl5vN3NJqZ/o1FrfUYjiUvQDqUewmqpoYFjg6M8Nr9qWcZ8B04as/K
	 0iYVVbIWY92VMFcU+1rOH/NMaSTtnpTv1yq0H8KJZnRRnkPv+2ib7NRRIzyQs7H6bi
	 AeBqGfJgAeqOA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/5] Docs/mm/damon/design: document hugepage_size filter
Date: Tue, 18 Feb 2025 14:37:05 -0800
Message-Id: <20250218223708.53437-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218223708.53437-1-sj@kernel.org>
References: <20250218223708.53437-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'hugepage_size' DAMOS filter type is not documented on the design doc.
Add a description of the type.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 12ae7e1209c8..a959c081bc59 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -610,6 +610,9 @@ Below ``type`` of filters are currently supported.
     - Applied to pages that are accessed after the last access check from the
       scheme.
     - Handled by operations set layer.  Supported by only ``paddr`` set.
+- pages that managed in a given size range
+    - Applied to pages that managed in a given size range.
+    - Handled by operations set layer.  Supported by only ``paddr`` set.
 - address range
     - Applied to pages that belonging to a given address range.
     - Handled by the core logic.
-- 
2.39.5
