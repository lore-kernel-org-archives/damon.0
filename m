Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0E3C343A;
	Tue, 15 Sep 2026 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482852; cv=none; b=CMPcOzbTwrZIdatwASqvjLUXRqLm6Smm8IAFQpQqw35l9lJFisBt9tpi5lhK/H2YwM1ZW2tQ+XQL0zdpDKDg5RPR+4GYumiCqqfh40MZutNp15Vab0DJk4SgAl+AduZLhYcarDbMYJmr6P75co317k7R8v3wh9kkOAqiaD9+XKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482852; c=relaxed/simple;
	bh=5Ih8qSxrx+1FoiQrZrDyi0m7BSRP8d4efVZQoDuXGTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2cKBNR011EK22nqrZ0BHbiOeHUw6ZswjUy2ydo3vVtbh2KYiSxhb3lZX7k+XkMJ2r0JuH0vZLqGVYCn1QpWJNwsyP6ae3Bx+lETgzwzKa77PvHuii2afgSNqhiuw/j2j7uVrC9iql5t8hL6jUm7LFJTXBK9A6NDBNUwB4Ugn3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgUT09d5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgUT09d5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949BC1F0089A;
	Tue, 15 Sep 2026 14:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482850;
	bh=9PbkWTjWrdG2mF2OjLqwQA4JbmDDau4Exk+WU0SHNwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HgUT09d5ds6pCIoWo2JOBAnd3tlvDqG/n0pWkNgSbNxYbSis7mFqOPRrGiZu2UEDM
	 inijRcU+3TOX2jwVNzZIJ6tn9vp3ldP4lgtMiW0QYRrKY36hfP3vsfpPVUFgcM3Lbs
	 oVhf57TvQ+jVFTriGybHMkr68tQ5bkYaH0EhGdCLOjqGuRPOgYYMDXcOI5JsL44PRX
	 7j/9KIz+xSXCVb77UtSQw2BeR31cUmVXDYv19kVJFh0s2Edt4yrk7glfBymvU4SJjB
	 oVLbS4SwReREByD1KNgehWo67kB7Qf8tEZWFO6Z1cPEMUWRaFMdT4KJJdxQcxZowKw
	 uJEpLCUUNq6lA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for hugepage_size
Date: Tue, 15 Sep 2026 07:33:56 -0700
Message-ID: <20260915143359.91472-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
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
