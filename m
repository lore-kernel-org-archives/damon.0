Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70D369219;
	Mon, 31 Aug 2026 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187664; cv=none; b=LY7/RVQgheJkDARuTQg8gFu3ZbgylhGhr9woQr/Yjgodxc2HQWrhYz4SjrX1BVtpPbNVDTRAkZj7Az9fP0Zq6JoHxvoYCbHWGl8UqR7WM1YfcwggOWh3eEzb1fYmHhdlFA4Oj6KuZ6sZ1NaJDNUcfm5h85YleGnmARBN9OGjr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187664; c=relaxed/simple;
	bh=DDAM8kLS6YFUm07t0FP+1YwHfuBY8U7Ht/eFKbSjt4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJ4y5ng0VZPsf1i41iN0QXZ+mLdXeRQcajn0EbaejfmFwZQlvDzRDjjnqkltshPLFzdQiqwnpdY5soYM47QQNKwOJOP9BYUkxmQ5Nrp/Bcx28bQSJmkFqsvu475iki9FAI5VHuPJq5lTUG3dVXndnadOqg56tNaTChUD0pluLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtR08xk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtR08xk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD291F00ACA;
	Mon, 31 Aug 2026 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788187662;
	bh=ZJ2cDi7p2lGLgMdSGSLvUGByJ6pdyguDUdt1C3jVMEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TtR08xk34nMJJUbAO9GFJQWzH6EBM0rs1JV8zJGXVoBJ7JlWOPOPDO+D7DFfrcJsj
	 Qwgo01bhJEofWm0Vp2J2P8X3bFTo+h9ELtdcZDVtNCiteD2K5tq8q8Bl3Va2BAXDoc
	 H+XHOqfhDZ4j0Cn8HErbg8II7h0R6/DaUGDy/x9fgNZq5EloVHyf2BDaD8zxoUCQPw
	 M5bD3ScFXTawCiWXVFJhjFxaUwBW5ed1MWycPCfOr1M/evZPGdwiVyMXaMMPpvj/sD
	 Of+R2tWn2YPmF+2VVgCCe3eKKylQf04gSioaHVVx9auUDPFs5Wv+r/RiSOC41141qv
	 TplFkYOjSEIEA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp target metric
Date: Mon, 31 Aug 2026 07:47:30 -0700
Message-ID: <20260831144732.80910-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831144732.80910-1-sj@kernel.org>
References: <20260831144732.80910-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Document hugepage_mem_bp metric exposed by sysfs.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aed6cb1cf4831..a8c163475ef2b 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -713,6 +713,8 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
   bp (1/10,000).
 - ``node_eligible_mem_bp``: Scheme target access pattern-eligible memory ratio
   of a node in bp (1/10,000).
+- ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
+  (1/10,000).
 
 ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
 ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
-- 
2.47.3
