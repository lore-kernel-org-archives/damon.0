Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131C1DD9AC;
	Sun, 20 Apr 2025 19:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745178044; cv=none; b=SzrQkWYSSxVr3ogsyRdDJQ7tgwINsSUoAS7AWJ1kIrjlaY1dbqqmZVr7jFZ30nQM5msTSB71tXKhu6y0axwyglzDU0G471LNSVJV27mpCg38ntLZDc5zhmBzPk7FNx0TKMU4NJt3RILcx/GWU7Qf2nGwhj/rgBWz2ELJJ+PpGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745178044; c=relaxed/simple;
	bh=4toUflKBJ0stxy41rSp4MADpFGvyQOLZX1iQYpsRRqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJby1A0kEeXddgi28NTKYJp6ZhhBd+SeOU7B7m/pDAYGEbxCfkxWrjAxjozz4SkBqvi05IR9D8dRfcft+oCrNKrWRPmAeu+0m2RSpEsiEy0dSpcgHtNKrl7QdqKwMr3veamAXHjEUoQpZ3cjX7M4yuqYEsDWGYPn0Yfxd07MgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3V6vmE7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3V6vmE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7414C4CEF2;
	Sun, 20 Apr 2025 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745178043;
	bh=4toUflKBJ0stxy41rSp4MADpFGvyQOLZX1iQYpsRRqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3V6vmE7Fl4j3+dGHjCNr6Tzv41/jZU73BjEebno2mhQfo4bqtRUQfxDxy3OvFusJ
	 V2SLhBsAvlm62aju1TUyeZ2k8l/KWK2ALf4Qao6juLmZE1nnyZWG6dRvp4Xg3KCnDy
	 y6sUV+vdmVeN40jGjWo3Je2m/4mFpqM4lrW0T/cfwVSy3EQY7JFbcGidXuNGhTm61N
	 cve6rNy+HCY1qio0OtESKvrupAcVVmg/btMUaCI3dfmWz4G7H/vyN2++SjV01xIyza
	 +6I6WtSGHUvy5aIty3VAPGtEk7vCtLtao5n6cpSeMQug7tQ6xQDT0Vq8wcwPq+KUYt
	 g7yKj2c32LEWA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] Docs/ABI/damon: document nid file
Date: Sun, 20 Apr 2025 12:40:29 -0700
Message-Id: <20250420194030.75838-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250420194030.75838-1-sj@kernel.org>
References: <20250420194030.75838-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a description of 'nid' file, which is optionally used for specific
DAMOS quota goal metrics such as node_mem_{used,free}_bp on the DAMON
sysfs ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 293197f180ad..5697ab154c1f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -283,6 +283,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the current
 		value of the goal metric.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/nid
+Date:		Apr 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the nid
+		parameter of the goal.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5
