Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A971F2780E6;
	Tue,  4 Mar 2025 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123159; cv=none; b=BfAc5k1SzDoO3gRm8fRJLBlgPawv9jeEJvHn5o2SgVrmvR0QG2InyGrPyF1p06xHB2PkkE8coN94tSvZIh/CePjXrxqPfInLXM+lS/AvUpCaKxWS4yK0D1X/2bes38h+K3O0USnthFNvKUkm2OiQeQ0/z+tcU5dpIeFKCOhW6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123159; c=relaxed/simple;
	bh=npc/D62/iA9M79tii02t66kR94TtHspqQy52dl64bMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYZC/ClfKahoND1FAo6Ny8fYGEphXVppf8WcGc4ITAGd+hRKqjwQ+dnQTESfFNTT8b/PONkIbbIcqYhm2QdfBFsMjjpwV7lVOVJY5E6P99lswemMCsss9k0kATGLU5aRO4gLD1LDOZa/+WpHcdzu3cv/0sL3a/jvzzy7I9iBfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCRgqwvI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCRgqwvI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55E1C4CEE9;
	Tue,  4 Mar 2025 21:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741123159;
	bh=npc/D62/iA9M79tii02t66kR94TtHspqQy52dl64bMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCRgqwvIepxKyJkApXpQpFtf9uNM7OzhQLJgmaj98xMr1qkhcgYsDa+nnCpkbHJiL
	 J3wxit9ZLErX8nYSh8Wwjfvs4E+Z9S6eu63CgACgOSlaKeoYIopwExJN/2j8EKQP9v
	 Ur3T/foL5tPNO8J6X5Q725XhMzg1/PBGUrQLeRkpf0VT8LVQCKG+6R648hFubunCOG
	 SDXTaTCGm1Rg9CK8GFoM6PC8L6vXsQY8DKtLOrh88On4GYwkHfpObVbelT7w0REU6i
	 N1XXUaEQ/FdPBpUY3GU1NOuYyKZ0XB+PXtROZKtWEQEhSEI1yG+oSI4Csceux57neB
	 bqjkubU1JzYSg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/9] mm/damon/paddr: support ops_filters
Date: Tue,  4 Mar 2025 13:19:06 -0800
Message-Id: <20250304211913.53574-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304211913.53574-1-sj@kernel.org>
References: <20250304211913.53574-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON keeps all DAMOS filters in damos->filters.  Upcoming changes will
make it to use damos->ops_filters for all operations layer handled DAMOS
filters, though.  DAMON physical address space operations set
implementation (paddr) is not ready for the changes, since it handles
only damos->filters.  To avoid any breakage during the upcoming changes,
make paddr to handle both lists.  After the change is made, ->filters
support on paddr can be safely removed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d5db313ca717..2b1ea568a431 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -260,6 +260,10 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
 	}
+	damos_for_each_ops_filter(filter, scheme) {
+		if (damos_pa_filter_match(filter, folio))
+			return !filter->allow;
+	}
 	return false;
 }
 
@@ -290,6 +294,12 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 			break;
 		}
 	}
+	damos_for_each_ops_filter(filter, s) {
+		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
+			install_young_filter = false;
+			break;
+		}
+	}
 	if (install_young_filter) {
 		filter = damos_new_filter(
 				DAMOS_FILTER_TYPE_YOUNG, true, false);
@@ -538,6 +548,8 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 
 	damos_for_each_filter(f, s)
 		return true;
+	damos_for_each_ops_filter(f, s)
+		return true;
 	return false;
 }
 
-- 
2.39.5
