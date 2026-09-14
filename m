Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E9479887;
	Mon, 14 Sep 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397103; cv=none; b=rmECNF8NdQUILDABeVoi7nSyIEjoGaUSkYzdRG0AnRotj/ff17atGIJBLTiZ4KPVx0trpFpZ9XZ1OGPz6j0iWaO3pMd+SM3Cv+mpE0eelFXylAgqS9ZimCnF0DSxaUrhlPdukLAH3gfkz0FP1RIflTnhJ372vvO2BIoi8BotK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397103; c=relaxed/simple;
	bh=5Ih8qSxrx+1FoiQrZrDyi0m7BSRP8d4efVZQoDuXGTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/m25JzU3SThMqK7dHRYqg15E4HFZZr+MrZQiLL+0/oksQ7hWbb34Dk0jEKRKYQLedJzaw8tE0oqPrlsPpdQJey8FhYE1A9Le5yUu//ddlFvVUARW5R3kLjUUoysWJ7GhM4OBNCMM9tyzjBs103N19rDNbqRxl6vnU8v0DDUhMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUU/cTdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUU/cTdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5B11F0089D;
	Mon, 14 Sep 2026 14:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397099;
	bh=9PbkWTjWrdG2mF2OjLqwQA4JbmDDau4Exk+WU0SHNwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mUU/cTdwIIy730r278s4lWSS6qbNi1K8bB9KK0f5NPJoQ9iL7zvpAUIzkFHv9IUx3
	 hvJKrtBA75lQorwGhuchbrnL32aQSBbjSgBfuVeqRDGPaqBSwJX7AAvM8M3zQS1lqY
	 3FqImho3NtekOubwDwGuOK2vNVveE5v6KgiCEhnAz5T0ZZIWXS+Hbb3fRCU7HWcbB7
	 +eL6ymZzYNaSrNdX0SC+TuSQ+myHwvDvkOSzntGgYEWlibdAQpEAxjLHfTrRr4SUp4
	 6SP1J6Bmo1GJChdJy02AlKRK8cc49rz+5aXxnGX2piMiK8QzcVsre3uSGXGGzIE+Pq
	 752a7o36cLlOA==
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
Subject: [RFC PATCH v2 7/8] Docs/admin-guide/mm/damon/usage: update for hugepage_size
Date: Mon, 14 Sep 2026 07:44:44 -0700
Message-ID: <20260914144448.93732-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914144448.93732-1-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added hugepage_size data
attribute filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d3e37400367bd..6b80bce5d678d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -78,7 +78,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/prep_action
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ filters/nr_filters
-    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
+    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path,min,max
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -308,6 +308,8 @@ Writing a number (``N``) to the file creates the number of child directories
 named ``0`` to ``N-1``.  Each directory represents each filter and works in a
 way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
 ``type`` is ``memcg``, ``path`` file acts as ``memcg_path`` for :ref:`DAMOS
+filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
+``min`` and ``max`` files acts as files of the same names for :ref:`DAMOS
 filter <sysfs_filters>`.
 
 .. _sysfs_targets:
-- 
2.47.3
