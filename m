Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4D27AC57;
	Sat, 19 Sep 2026 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780466; cv=none; b=JIL5SYgC0XJpcXTgF23lyqZzjdIXGUdTlzvSOWYdRWXpSWmD69tpt6Fm/liInIB+oqg2gywMo+zjuzumoRnsgWLt28uEAFZmG+6xlROv0cqAqtMoeDoY4+fU232RK9HBLtYzcIclrkRcV+BNVu4CMnJdROZHX5K7zjVLKpl1O2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780466; c=relaxed/simple;
	bh=plGbdbehTitQph8PfjL4EU6xReU3ILvw6sBrO0FSP4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dqrej0iSEuEW3pi8BPlIIHkioCZlismiIWNayPoYB0/X58MXcuo3Gca/Ox+35IveQfZ5ZxExLo050mjfpzYnoNny3O/gHFjpAyD1SeUOMkzmprug6WZ49Gnac6z5GinTz/gFLmfJ/r/ELmDyac0e9ULh9c8QXrwdYo+3b8Oi3YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxDGZTwE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxDGZTwE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FD81F0089C;
	Sat, 19 Sep 2026 01:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780450;
	bh=tnIaLQ3JqTQKlYGtXSLMaRVuIin07S/F5Nx3QIjWklQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxDGZTwEGf9tZXHKoo33HR25OFplfNJzLDIV3rhFyXGYcY3iRNIlODbu9vrVZvDjN
	 Q8IBGdAUFqEaQTxABojuEBUmjZVVWzJgiV+x3QyA+2RVzwz4NVUOMB5Cx2zo4kX/In
	 tT+IMIVdJB8UWLj+W0mleq+jT9OqQMnF5A6f13V1NaHDKjfh2KSqXe6T5BJZAoJAeJ
	 PyjKaIjQKTFMGfzM5CLK3NBcBNzCgHCeneZsvnN78vtpv+WxQVoSsj0vVq+0kW0l4X
	 s58LWScaOZtQeXvuGT/gtaEe4Q+zCW12zczo+lDYq4k3Q8mlWzta3gCPk6qhxaWJW5
	 4uLCvu2X6p1ZA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 5/7] Docs/mm/damon/design: document damos quota goal complement flag
Date: Fri, 18 Sep 2026 18:13:54 -0700
Message-ID: <20260919011359.88921-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919011359.88921-1-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added damos quota goal metric
value complement flag.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index e82390e77a70a..c82be80738c45 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -702,10 +702,10 @@ There are two such tuning algorithms that users can select as they need.
   that the zero quota is a valid quota, and therefore ``qt_exceeds`` :ref:`stat
   <damon_design_damos_stat>` will keep increasing in this case.
 
-The goal can be specified with five parameters, namely ``target_metric``,
-``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
-mechanism tries to make ``current_value`` of ``target_metric`` be same to
-``target_value``.
+The goal can be specified with six parameters, namely ``target_metric``,
+``complement``, ``target_value``, ``current_value``, ``nid`` and ``path``.  The
+auto-tuning mechanism tries to make ``current_value`` of ``complement``-ed
+``target_metric`` be same to ``target_value``.
 
 - ``user_input``: User-provided value.  Users could use any metric that they
   has interest in for the value.  Use space main workload's latency or
@@ -733,6 +733,11 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
 - ``hugepage_mem_bp``: Total huge page to total used memory ratio in bp
   (1/10,000).
 
+``complement`` is a boolean parameter that determines whether to use
+complemented value of the target metric.  For example, if ``complement`` is set
+and target metric is ``active_mem_bp``, it is effectively same to
+``inactive_mem_bp``.
+
 ``nid`` is optionally required for ``node_mem_used_bp``, ``node_mem_free_bp``,
 ``node_memcg_used_bp``, ``node_memcg_free_bp`` and ``node_eligible_mem_bp`` to
 point the specific NUMA node.
-- 
2.47.3
