Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178F51E3DEA;
	Mon,  6 Jan 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192067; cv=none; b=nHcjJiBeFFNMhTkYep/4oQAeeFEvGJMndYRPZNJM6ic5dd++hkq1ZoYRF6okgfKbqJ7Dt/+cDQninITiq0XQctAPHq+FhAC3mFDyZiURO0zLjTGOVC7FSSan6K6MEsYeGnhoom4slOmqv/mJLabtGYszcdwBp78t1OOewzjjgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192067; c=relaxed/simple;
	bh=vW6sgxrPCYe3gm7HEu67s2ECdsRdNIOjt9YthRV3gts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmlAOIswX8yOp8tDtxDDF71qZOIcW3cGMDGKnCRBHIZ8XKA6JlbWSmoewya82EMifIHfFZ9pB56p/VwBodJ7tsSqK5G6yOMjtxvWJpLRUCIvjgbw4KnR7bnS23t+sL0CPpJMw/bjfP6xkFpNfcY913d5AHxlmGwTbT1DJjQRKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSi/fpfL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSi/fpfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD06C4CED6;
	Mon,  6 Jan 2025 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192066;
	bh=vW6sgxrPCYe3gm7HEu67s2ECdsRdNIOjt9YthRV3gts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSi/fpfLF+PkFCUc0GISfaKpiQJLoKPWVjMxjwrUWCeRIbxILdekwhg/drq/J3Vz+
	 Q8+MAfNxnKhNuNu3maXG5njC1ga5wJDdFAHolfcH/8KkzHDxDMekYiRQ+MB0/hzPg1
	 hKVszz29Je2pD4msyS/4T8SNa+EvTGA0v7OLrwVvy8abtGAAK8ty0sEzUIaAA3WZ/0
	 hVqPsLsfB56EFK+xbrwD5UdC1M97bvq03j75y5R9ek/MMDH5Z26/RRteBVcoy1wzkj
	 gjw9YdliZQIsVvqu6GrYIxIepbs3h0S6jjZ/7HvT9o+kAZbG+MXkTcQH+WN+3eUtPV
	 pdVMCXhXBP00Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 14/16] Docs/mm/damon/design: document per-region sz_filter_passed stat
Date: Mon,  6 Jan 2025 11:33:59 -0800
Message-Id: <20250106193401.109161-15-sj@kernel.org>
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

Update 'Regions Walking' sectioin of design document for the newly added
per-region operations set handling DAMOS filters-passed bytes.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 68145972cb20..449eb33688c2 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -587,7 +587,8 @@ Regions Walking
 
 DAMOS feature allowing users access each region that a DAMOS action has just
 applied.  Using this feature, DAMON :ref:`API <damon_design_api>` allows users
-access full properties of the regions including the access monitoring results.
+access full properties of the regions including the access monitoring results
+and amount of the region's internal memory that passed the DAMOS filters.
 :ref:`DAMON sysfs interface <sysfs_interface>` also allows users read the data
 via special :ref:`files <sysfs_schemes_tried_regions>`.
 
-- 
2.39.5
