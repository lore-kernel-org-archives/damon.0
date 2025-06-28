Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9001725BF14;
	Sat, 28 Jun 2025 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129515; cv=none; b=ZEv4ZwCeFKqiIwSEQ0p6wF5ztgE0yrG+f+NVQAX05VF3XfBgc5yKftlYgw3O1PDJYyjXVNK+8nIW6eEfIvNF/L6Rpsm/sqSnxGJiNM3D7l+CBURjGlLpK8KBHE6wiNmdKMt0bku9wT5WCt4llh3J/+3aHZpm1biF1u7g4JYQOKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129515; c=relaxed/simple;
	bh=7i7qunrK1xhj1u0yXR2LnSzmGQuChUp0Hbjbv8uMugI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=us0rD48n9O7xgK9/Xqre5VZRx8lBpwjkV2Pq4coACeNjPzq2yn5Lvy+T07aIFnF4FKVjAAJa6PvChmM393gZNSeQDFh0rxtI4lKc6S+n8zE2ZgMfysGbc0YBd/aPwZtb78kBOFWhOufmuNinZO/JeCtVTatQ/q3y8K6fvbjVaOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7XpEwch; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7XpEwch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028CDC4CEF0;
	Sat, 28 Jun 2025 16:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129515;
	bh=7i7qunrK1xhj1u0yXR2LnSzmGQuChUp0Hbjbv8uMugI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7XpEwchMN6ffUybiDQQo9Ptpx34FwBKUK4NhGPfrPgqZgkGjNqcRmTojYe4V7Eh1
	 M61WuKMVdKSSL/YChU5k8PRBGrekTlwN7CVP/5ftSfYYCoqLnywDS6QDOjZfbF7Ncl
	 uOFVS8WqtF3Qq2zWuc8czfLKvCpHVBzd8G+FRG3k8V2dOWHEP2fB/EcESsJX7Vuwd9
	 m+LDeZhqpVrbrvg43PZlTuH9PgHWsMFYoc+Oir3yMm/kOpmL/md6UWvrwDTqTMLT0n
	 HFUzREO0hPt+QC6gBxsUoWlci42jIllR/1vzt1/KJOw5QHSfkdyJ1lgACE5sSlysPg
	 VzyAa5rsFk0IA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 07/11] Docs/admin-guide/mm/damon/lru_sort: document filter_young_pages
Date: Sat, 28 Jun 2025 09:51:40 -0700
Message-Id: <20250628165144.55528-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DAMON_LRU_SORT parameter, filter_young_pages.  It can
be used to use page level access re-check for the LRU sorting.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 7b0775d281b4..18fa73a59f62 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -79,6 +79,20 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
+filter_young_pages
+------------------
+
+Filter [none-]young pages accordingly for LRU [de]prioritizations.
+
+If this is set, check page level access (youngness) once again before each
+LRU [de]prioritization operation.  LRU prioritization operation is skipped
+if the page has not accessed since the last check (not young).  LRU
+deprioritization operation is skipped if the page has accessed since the
+last check (young).  The feature is enabled or disabled if this parameter is
+set as ``Y`` or ``N``, respectively.
+
+Disabled by default.
+
 hot_thres_access_freq
 ---------------------
 
-- 
2.39.5
