Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D21474266;
	Tue,  1 Sep 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269116; cv=none; b=tsDPug99lRGF1QvW68OfyPEPhLlbOuOvylysPCLXVD++6znGA22L9J5ch5l+G+nQJTMW7tnnFtniJB1M2e3M6UYaOx34BVmFGn+wiciRLDmQ63XWlR2H5XOkdlMJTmUveWSA152yXOOgZuGLsi1GkENvV9I3nxPQnQmEyb2MLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269116; c=relaxed/simple;
	bh=ieT/ne0vOY5EYTrH52WVPjFrGyxfjporIuBqWV3GlGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTSHX7qu4zh+otqJwMVdOeVkYiEuv56VOyTqXxGcfMpNQhABvtfyfrf67luXurOXHv/og1n+axAwCxBjv86UEXW+kgu0CgPGFGFcPYnAcqCQty2qZ9MtZ6OjdXhjhxteDTLRhcQeXqHbgzq7n1CnIc3YliHV6ZT+aQ24K+tTXSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3rU3NCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3rU3NCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475D61F01558;
	Tue,  1 Sep 2026 13:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269115;
	bh=atWhsqWAE5VXdJdWplOPI8OSXhIZpjioTpYT4VKG/08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X3rU3NCLujv+rUY/N1F1HlANXOcMs774/erA6prJGwJ1zfysPI1f0g9nbt3IPyMjc
	 J/uqB/DMeZ8pZPNJjwj6fEsu53i4GhFBuEV7iVvYqaVlVWCFeHNnx0BbaazdgF9JfE
	 h88ogDbPp90id2S4klQpHGA8QUdhy/aA5cOOl1zPP5HyRQcbUBs/SowAgNo4dvPClR
	 z67tmt5xdgeRi3SYMsf/8H7bi+wLLDKIfbjBfrWo2qPwMqcnGzEi2rZObTJfs4H0M4
	 ozqFRyZzYLWl2EaI4iV3NSfVmOYP326pIMpWrOdtGr6oaZ6/ThTXV++u7d3zfO227b
	 C1XIK48dXmpsg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Tue,  1 Sep 2026 06:24:49 -0700
Message-ID: <20260901132506.99243-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
address space DAMON operations set.  It reuses damon_folio_young(),
which was being used for access monitoring.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 9ddd1ec8202b7..6f756f8493894 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
+		if (!folio)
+			matched = false;
+		else
+			matched = damon_folio_young(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
