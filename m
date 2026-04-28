Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995C2F5474;
	Tue, 28 Apr 2026 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340073; cv=none; b=eAAKiEltfdqnxu0QZvSyBdniel1w4P6ld4oOHwY2k06kWaCRZE8+oMnegYsdVa+Dv3uWC4ieEwEOeAvYYuCRtIT4R9EPboQGBGL1FFuXJ2HpWWR5MYVdlmqIXRRix4r65ajVUWatDTRfcEJccV/KTELTJXJ7GTvz5n47eTIBDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340073; c=relaxed/simple;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryxvVUBkoO4rWLjN08uvhVALCnQ4vqFdZ2SIBlSxVii2oQ/vtcnGrBPZ2X/j99F1NtK1+7sSnUIgEGsyJBkCNo7Q6pSu2hz0urm5qXD7Wak9YFFdyuJ9NUU1JdEsqyOpfUiMiMSF9/3bZ7assMs7JOEjLsp3mQCWjXlRuo0Y87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMYK+IiU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMYK+IiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCD1C2BCC6;
	Tue, 28 Apr 2026 01:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340073;
	bh=WgiRHi50zFvHwjFSQiNfyV/FQHY8WOkdhFM9Jv3jqj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMYK+IiUNblpb/DS7qK8c0PyqQD0wR6G2o3EsZVQRVZUJmrtesZ02gBM/MBsMoiyg
	 sKRH3pY9Yxe4tOsO0XtkzxoaiNaXMTkwsfNedGmsOkQfQkWTd6y6aalRlhHBF5ihwE
	 RSGJuA2HbeqrqXF3KdgcvvaeXAXXqhQdZU+gj+jvzJud6iEYWBQA+xt8ab2FXxYb6e
	 CidzCwsvtZPTUh4ERLj00ORoK2rxzZHaSohjDglTG6nqdi4d6I++NoH3hzJoZ7wyZ/
	 KDC1hifafdow9/8DnkApYaMdcrUCduOnSpwcJSe3HQ/O65ad/nc51+RG37qcFTqNMr
	 hmS0LHv6/pfgA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/11] Docs/ABI/damon: document fail_charge_{num,denom}
Date: Mon, 27 Apr 2026 18:33:56 -0700
Message-ID: <20260428013402.115171-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the DAMOS action failed regions quota
charge ratio control sysfs files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 7059f540940f0..971c22e34e722 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -329,6 +329,18 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the
 		goal-based effective quota auto-tuning algorithm to use.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_num
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio numerator.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/fail_charge_denom
+Date:		Mar 2026
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the
+		action-failed memory quota charging ratio denominator.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/weights/sz_permil
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
