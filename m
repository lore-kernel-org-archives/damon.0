Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03632580EA;
	Wed, 19 Feb 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002514; cv=none; b=RDDwwu0trDZ/DgG2lDd96nRva17DfSj10nCC8g+1kiOT7Gro76D+VIx210ODqZzJDppYfHUF68mQcabez2i6PSKkGIv8tnMR8R7OuGmCPWfCdokwGlY+k0Y9nQtI2bZIuQ+uQmXAw7JP8wE0kkFxaZD/sdlgcOUuzBWDTeo/VDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002514; c=relaxed/simple;
	bh=yMdFRplbN3e7zt1C4QSJ0uWc/4w7Mm2TY2bv1ScBKLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ma28ZicvZ+C9g34ERTRpJVVgGek+/bJEZGubLJ8Rzdtwev6oNbREEqH/vEOP3QtRIdnmv00r0fAvxDskIVs/AQtUt816MO4ElWa9vTK+UGvU2VJMSqnBt0i6KPhMXTo4ST7SYUYdFggfUorzKf5gr46/FRMK1M6b5qYrj8uFLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjnFLO6P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjnFLO6P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB34C4CED1;
	Wed, 19 Feb 2025 22:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740002514;
	bh=yMdFRplbN3e7zt1C4QSJ0uWc/4w7Mm2TY2bv1ScBKLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UjnFLO6PzKtpIqStuUi3sTF/qOREnKbMASfMlDoKGV6HLYRkrmpCjOh6W/+3XF1q2
	 yUeH79QOTG+fpArLda747XaOI00vYqs18csmUopLJuoshKtO9XUg8TfLWpoOlknpbt
	 0WSNptEJuEXahe2ntx+p03Z1fdFhwnW6zCbqpxWujrJVjY5U5UBZW8rJFf7bGFjAdl
	 7lXsP6HxnkWRndDiK46tLgg26TYFM6prP9hoqqJkkAxXGlD3B2+bvJeCyfNoxrWDQZ
	 /GVvY1SE2xb3Xs1vlOfaO75mbdKiEr6cKvHrLBYJOX+vUPkFKTb+im6mKPAwLJusBj
	 WQ8RQkbpo+QpA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon: implement a new DAMOS filter type for unmapped pages
Date: Wed, 19 Feb 2025 14:01:45 -0800
Message-Id: <20250219220146.133650-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219220146.133650-1-sj@kernel.org>
References: <20250219220146.133650-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement yet another DAMOS filter type for unmapped pages on DAMON
kernel API, and add support of it from the physical address space DAMON
operations set (paddr).  Since it is for only unmapped pages, support
from the virtual address spaces DAMON operations set (vaddr) is not
required.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 2 ++
 mm/damon/paddr.c         | 3 +++
 mm/damon/sysfs-schemes.c | 1 +
 3 files changed, 6 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0ed84b3656fc..795ca09b1107 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -337,6 +337,7 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
  * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
  * @DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
+ * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -357,6 +358,7 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_MEMCG,
 	DAMOS_FILTER_TYPE_YOUNG,
 	DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
+	DAMOS_FILTER_TYPE_UNMAPPED,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 9f03e1980b8d..25090230da17 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -236,6 +236,9 @@ static bool damos_pa_filter_match(struct damos_filter *filter,
 		matched = filter->sz_range.min <= folio_sz &&
 			  folio_sz <= filter->sz_range.max;
 		break;
+	case DAMOS_FILTER_TYPE_UNMAPPED:
+		matched = !folio_mapped(folio) || !folio_raw_mapping(folio);
+		break;
 	default:
 		break;
 	}
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 881d00bb3a34..66a1c46cee84 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -331,6 +331,7 @@ static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"memcg",
 	"young",
 	"hugepage_size",
+	"unmapped",
 	"addr",
 	"target",
 };
-- 
2.39.5
