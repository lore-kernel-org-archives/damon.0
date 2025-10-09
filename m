Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965E2877D8;
	Thu,  9 Oct 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044860; cv=none; b=e4KMI8rWGusgbCD9kWvAeBka5sENUsWSuW5wouMgjK2u6tLEExExkXJsrFrQFr0kwM374HT0h4kluES7Vd0PirZ7fAdQQ4PxcBXLjvvCmM2t+LA6HJhAET3ARjRveMagWji/ZLYwQVwti9cc7wsVyAQvW7ioILLwgFDpg1VC2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044860; c=relaxed/simple;
	bh=LT7SzPWNmkjozXj4ZRhtWHCKmd+a1TEy/eHu+98PlFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pia90lKtMB+wLNhgZU4EGO57ye926Bu7vlMcKj7JrE3Nq4yLXIWFwLtjkftip6RasLOYWYGSbTB8bq5I0lIdGZNuH5wYS16/wrkBPC5qgjvBxNBvHf0p7j2ZvenfHPN8hyYxIedYqKNmuRR1OOGtSRMrwQvY9VugP3SQgFdwY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBbSm2sg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBbSm2sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AF7C4CEFE;
	Thu,  9 Oct 2025 21:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044860;
	bh=LT7SzPWNmkjozXj4ZRhtWHCKmd+a1TEy/eHu+98PlFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBbSm2sgSupxR4duimHSUEtMTKGebV5ysf2bamIpK2SDE/2Ok5vmMThgdHNAs4MN2
	 u/eUHUFGnSZWVTHQ6ezelpQr6nlV4CEyQIaLmwc88n0vXcwnTHct2Jh54jrFDkbc94
	 AOEDhWcbQstqmAfyVceckgjTRPiGZW7Tba6nWNwbbWOTC2fq733OwlHzB1GQhyPZ2J
	 rGoxq7OgmtZ/J5wMlpzPtvox+8BZuJQXkO2MEniKGb5oyfs9BKUJESeb/Sw++Zkpyt
	 hV656KabYwa45eOorPmUvwqrwg/Wl7j5EQvCio/Itqd4BIdv4aemIzvyPhTA0BRUwL
	 yP3gqKxI5HeqA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 10/10] Docs/ABI/damon: document DAMOS quota goal path file
Date: Thu,  9 Oct 2025 14:20:42 -0700
Message-Id: <20251009212042.60084-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A DAMON sysfs interface file for DAMOS quota goal's optional path
argument has been added.  Document it on the ABI doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index b6b71db36ca7..dce6c2cda4e8 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -303,6 +303,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the nid
 		parameter of the goal.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/path
+Date:		Oct 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the path
+		parameter of the goal.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5
