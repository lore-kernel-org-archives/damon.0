Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC931A81C;
	Mon,  8 Dec 2025 06:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175431; cv=none; b=LuRQuDs/yt7HwL/pq6Z+Dj0fm6DOFKCARNtveIFZP+6wDZqUbKmPgm7PFUOGGepT7w/AWAkMZ6EkEoH6sXjFdB0ETeAKTUqnoHfAUNUhhzW3GG+GfZJTpPwwZTuxcOsth8PZqKG9ALPTTBn7HMOFj1/xM6DVhKwZY/qQSU3rFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175431; c=relaxed/simple;
	bh=r7GPIONjiVkaUh4sMuF9LOredJ7nNRhajhKCAfUCZiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=us68mNdJy/LADjyF5Jqv/V/6MKzed53+OugB/uJEMBbax20FHd4/841Y+AlEgMe6pmHXEgFwjcYMBsRWFnzaIEU2cWwfjFOpSsaTdTZrTUDDe4E/+AAjbtFJorkTxibXK55ej0dED7oDkWZzU08iodJRaCR6dLzYerCdj9WYWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRoORpL2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRoORpL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AF1C116B1;
	Mon,  8 Dec 2025 06:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175430;
	bh=r7GPIONjiVkaUh4sMuF9LOredJ7nNRhajhKCAfUCZiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRoORpL2ykkJNrHjZAbab6K5OR2TidIB5ylB9NIAUOm0kdPhMebK6wNPzQcvsUBzd
	 GvhpiQIf/Ott8rwvoHP2Rew4ueO5b2lhpAKmZAxxmfXefloTY5pKmNETdULJIan6zj
	 0WyjrmAbH+cMJESAjRevzCXUnkJAlsajrXMgJsrSIX7feapX9ddTkp8h8hmKvdMsrq
	 H3ztjraMeKsU6FZQNVtH0ZQLVRqjmpbXyWNVecz1565U2DMhBzzc+heIEkEnXwCO2J
	 yMXlAmjOpkmY8Yo1vo3JrmEGpg/xkw9tOFTSiR822DpAJvN5kX8EhRqpRml+FCdhvb
	 CPzbMFDn7trOg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 27/37] mm/damon/core: report access-generated thread id of the fault event
Date: Sun,  7 Dec 2025 22:29:31 -0800
Message-ID: <20251208062943.68824-28-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page fault event reporting function can know which thread is making the
access.  Add the information to the report.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b627fc84161c..4971647d4b5e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1712,6 +1712,7 @@ void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
 	struct damon_access_report access_report = {
 		.size = 1,	/* todo: set appripriately */
 		.cpu = smp_processor_id(),
+		.tid = task_pid_vnr(current),
 	};
 
 	if (huge_pmd)
-- 
2.47.3
