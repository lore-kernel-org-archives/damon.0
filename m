Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61421A707D;
	Thu, 19 Dec 2024 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581033; cv=none; b=DmVz42W3WtmTkNz4oD1YI+yZtxjfkW3DsF3LIBmR6GFxxK9pLUg3YSdSXiGH6uyAD5UdBTc9cPo8pmtsVF3v4Pj09iBZIRtPSQ/gxEDIAAotGwbfwTJlglc53o5Gnudnfv+OrgUQ7H9QmrhuGBXegvDjJ2TSLqUD9YyoNZoGtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581033; c=relaxed/simple;
	bh=SpnwWXRTfkYMqczlFfBjIRSLjyD9BiybsCKabnuSowk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msg2X69WnHHmTFFNYFJhecEkmX+kSrUbrm1TbR075PnT9ORxOgXoTbmoQKGR3FdB55cR0/IJfVSM7U/vvrllDrUaF++PjbyAD4fSLBlCM7wJFN5VipVtqhnkhYHo8/tgrMAp1uqFlb6Lr2kCo8eRjeScu9QkYt2SldRbSgcV93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Okgt+R3n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Okgt+R3n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C24C4CED6;
	Thu, 19 Dec 2024 04:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581032;
	bh=SpnwWXRTfkYMqczlFfBjIRSLjyD9BiybsCKabnuSowk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Okgt+R3nL+tMQulyJrSFoz4uD0MSWUhjapO1ixK/kNHeGI2yuwlPCkNTLEo0J6xzr
	 YxT/RrmMFkYzuBSFDLBolZyT4c1UO+XymRSnqfL9EVyS2ugao/7bGvyOvrbCk8NSEK
	 yRI1fYsCNQEFoCFSgUgTd2G00TAzdormCy0hthYnK6m6j50ZuTSVA8D8hYvNOgb8wA
	 jtj/FzeYaetD5WMO9L31/PGO+TMG92PQwMiOYO/xsfSV/v/rktLO8brrKv2ENbj/Ar
	 tIfN7M/TT8HxKjVHNXue3OMu/D5t318yDDFTQI+lWJFou1a+Hcz1/Qc4TSwbPkKQWm
	 RCw+aFdXqkmPQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/18] Docs/ABI/damon: document per-scheme filter-passed bytes stat file
Date: Wed, 18 Dec 2024 20:03:21 -0800
Message-Id: <20241219040327.61902-13-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new ABI for per-scheme operations set layer-handled DAMOS
filters passed bytes statistic on the ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f1b90cf1249b..19cde386fd15 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -384,6 +384,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the total size of regions that the
 		action of the scheme has successfully applied in bytes.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_ops_filter_passed
+Date:		Dec 2024
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total size of memory that passed
+		DAMON operations layer-handled filters of the scheme in bytes.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/qt_exceeds
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5

