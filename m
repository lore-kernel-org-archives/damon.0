Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED9439E178;
	Thu, 10 Sep 2026 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013011; cv=none; b=EU8asOD+mIDwM0WKhwpIxSrAymwZXh7ranFEl3O+i1yF6VfbaRW7YsTDVhL09JZ2VMixJaLlLRYJeIjULJJPWM1u/o4n/a1PKzz9wg8OceMQY08hRTwsW7mVU231J9vqiZp5j6g/rNPGDZaU5wZypsyWWnCBwGMd1ifeZRvEcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013011; c=relaxed/simple;
	bh=+pwt7ytLNv7N/tXD0TT/aWOG89chC7GSwPZ5TDexaSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MhZhILlaxFGU0HwUH0oTLrp7hu9yqrDc1M6eG1ytMJyI3IsTdPz0gJyBFA8DoeOXxElG5WrzIb4hYSU4dQdWvzRy0n06dywYaBXGqtpu/bPEznxOnTAMccNB3emGU//yxx4VtXqwsZdt7wUN2KAlv0HSlyUpUmyRRi9ACvmUVgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxWnZPHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxWnZPHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D63F1F00898;
	Thu, 10 Sep 2026 04:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013009;
	bh=3QelAmhdJ8KPxvwLkmNC9X/53BNSeYX//IkIfked+Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxWnZPHz98zrgKc4YjL39GC2Q1AzUgVaEEb6WcElQtEcSOng6LOWvo891VglfeOq/
	 cC33bMtlq4BkVFWmD8zbQJNkR2nEADt5myV7g4JM70bNIdaHRitgT66G9RDDgrlXAM
	 vnYVaQKKSrk4O+/wCrgLUIQLL8cUx6TgJMhH0PfcT3/gTvLhatWwymrumZwuzkdCku
	 P+PTU2fHBGXUkrC7j4h3Gz02I5SqzOkCjA7NDqeQ7fVyY6aLPZfZuhDjwtfD+ZgaUr
	 oC413ZfSCKKJJYrivDOrbap4mhasdHJDOwR2ZQMupSNPSx7s/AJmGZ5C0VZyLg6h4I
	 YgTmkS8ffYfKg==
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
Subject: [RFC PATCH v2.1 6/7] Docs/mm/damon/design: update for probe_hits_wsum DAMOS core filter
Date: Wed,  9 Sep 2026 21:03:17 -0700
Message-ID: <20260910040319.147037-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040319.147037-1-sj@kernel.org>
References: <20260910040319.147037-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added probe hits weighted sum
based DAMOS core filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index aac84de261aa8..8e980dde362de 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -822,6 +822,9 @@ Below ``type`` of filters are currently supported.
         - Applied to pages that belonging to a given address range.
     - target
         - Applied to pages that belonging to a given DAMON monitoring target.
+    - probe_hits_wsum
+        - Matches to monitoring regions having a given range of :ref:`probe
+          hits weighted sum <damon_design_attrs_only_monitoring>` value.
 - Operations layer handled, supported by only ``paddr`` operations set.
     - anon
         - Applied to pages that containing data that not stored in files.
-- 
2.47.3
