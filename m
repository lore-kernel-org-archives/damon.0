Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBD1DFE3F;
	Mon,  6 Jan 2025 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192051; cv=none; b=VBrESXnVoaRvGUdd7kcYrIT9Lr1ij9HGpoIELoOiMSCYRUZVAuMckUcphVn8AeIfxFjGvI2iTljQUU4ZeoD1Wj2E2B+/9Kk9aF4aheeMKP8BCVRrjKND5ZvyFjrlpsDpgMlc6QShaY1vseeHzBSRrxGoZ1yLwWq9T7q82RoJ2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192051; c=relaxed/simple;
	bh=Xy/cUyoqUpo6pu4RY3ebUwHZ83NPf59O+4AQ8ljJSu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTyCI1vxVLw+fJ4X2AruyIGKPEjI89GwDyiygv9ydHfHweXAkllPatrl4knESG3zYEv5EfHXwd3fv15z/jU8HDFk+f57PROgRXk1hd6slmI7FVRSFzos4hO0JyZNzLYXBJPXjZdafw+LK8kego6Lexpg2NlcqqBYMl6ZU3wcjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzX2HhDR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzX2HhDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA771C4CED6;
	Mon,  6 Jan 2025 19:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192051;
	bh=Xy/cUyoqUpo6pu4RY3ebUwHZ83NPf59O+4AQ8ljJSu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzX2HhDRRLJIqeA8n/fcBJWT8mLbmy7WeW8j7w+YR7dziXB43hzn8Tl5T9vie6eqD
	 ApH3/H6fSmd0uMkiDSsZ9expdHg1DnXnEH0P09jE39nvIfEu/6Nku7XWF8dyHPgTRb
	 7XwwUV5kHNzmOA870z437dW8Rz3/NkosK5IPzMFYHB9A57gFkcia8z6aqVe6J7QT1D
	 sRwQfVHdS+j6Ov9Da5PLbtO3IE73FzG87dy90bWrP1IwIu6AVlzfJD6feaZ3G01YrP
	 0Y8gorNksOqrG65TW4XhVftjjYOSOW5q4WptJ1ldr4ki/soXf4O6+G/EdFq+Enrsbg
	 4kXBHSgT1usZQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 03/16] Docs/admin-guide/mm/damon/usage: link damos stat design doc
Date: Mon,  6 Jan 2025 11:33:48 -0800
Message-Id: <20250106193401.109161-4-sj@kernel.org>
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

DAMON sysfs usage document focuses on usage, rather than the detail of
the stat metric itself.  Add a link to the design document on DAMOS stat
usage section.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 3 ++-
 Documentation/mm/damon/design.rst            | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index c685d87ea078..2e835c9bcfdf 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -451,7 +451,8 @@ schemes/<N>/stats/
 DAMON counts the total number and bytes of regions that each scheme is tried to
 be applied, the two numbers for the regions that each scheme is successfully
 applied, and the total number of the quota limit exceeds.  This statistics can
-be used for online analysis or tuning of the schemes.
+be used for online analysis or tuning of the schemes.  Refer to :ref:`design
+doc <damon_design_damos_stat>` for more details about the stats.
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``, and
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aa2e4694ee14..158d0a4e1d7f 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -539,6 +539,8 @@ To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`filters <sysfs_filters>` part of the
 documentation.
 
+.. _damon_design_damos_stat:
+
 Statistics
 ~~~~~~~~~~
 
-- 
2.39.5
