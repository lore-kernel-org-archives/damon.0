Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442A423148;
	Thu, 14 May 2026 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767769; cv=none; b=CpaO3LaBa5JAodGvZaJ8JvZqM0cSIhqVeRIzMqsBNzJucTCAQjrfrly3Cqs+dL9dXLK5aBgZWBLJ2hl2KXvM/G1++rBNDXfTfUvSiBDa8a/27cNupSVM3JW5BAhK9lVGLymnBQiwlF74T66i7pONfCWyVbe7cG13sRp0bqLoDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767769; c=relaxed/simple;
	bh=QiZyClLpM+jtGeAv4uUzZ2zYrmnjLH6QxsmmjjG7o5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrM6ZTW05Hl6cn8xmBKMpbkkI9qZA3c3q4GZDmBjnaJ0KSeFHjM7lrsZonr5gj8HKBU8U67UrQxVFWSODqkqk/iEJBFS/S+M4Y56RfZtWfTBtqd11hoO5UbXY3ZiiUjGCLn+7aUWggA/mDGQQtnzS05ouxLTlS7wC3BZG0mQ3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDBNJdUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDBNJdUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A461BC2BCC7;
	Thu, 14 May 2026 14:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778767769;
	bh=QiZyClLpM+jtGeAv4uUzZ2zYrmnjLH6QxsmmjjG7o5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDBNJdUJQvuDbJbFCDy15+8/UKoJbIsU7vPDhbY3Fan+17yfUQNE3SkOIxk38e9J1
	 0kxRuOXNwUuyXoHJFmVxzw/zDQXVT1d3oESt1vgWRRIpyn9Y3/3byNxcIDwyKM2x+b
	 hgHAtDk6fY6uJceFx0Bob5PC9ltFeYH6wyXMff+dX0OyuNC4Igq8IvtyNcE827V+n2
	 dvPi9uGHpKfW48z49oaOdccZ3kgtMCbod7LsEfpJ4UKHJK2pkR+YDzRzZ2GApTV/Xp
	 ZWsyvWKBkpOTarFi6qF3TEyvJp0KS6qo2hACH4t59BqpBo4WYQo2Fw0pMs294Fj2hF
	 W4Gr2ZuuJzAPw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 28/28] Docs/admin-guide/mm/damon/usage: update for memcg damon filter
Date: Thu, 14 May 2026 07:09:01 -0700
Message-ID: <20260514140904.119781-29-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514140904.119781-1-sj@kernel.org>
References: <20260514140904.119781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added belonging memory cgroup
attribute monitoring feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 465bcdf89b182..84741b4cd1877 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -74,7 +74,7 @@ comma (",").
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ │ :ref:`probes <damon_usage_sysfs_probes>`/nr_probes
     │ │ │ │ │ │ │ 0/filters/nr_filters
-    │ │ │ │ │ │ │ │ │ 0/type,matching,allow
+    │ │ │ │ │ │ │ │ │ 0/type,matching,allow,path
     │ │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ :ref:`targets <sysfs_targets>`/nr_targets
@@ -289,7 +289,9 @@ the data attribute for the probe.
 In the beginning, ``filters`` directory has only one file, ``nr_filters``.
 Writing a number (``N``) to the file creates the number of child directories
 named ``0`` to ``N-1``.  Each directory represents each filter and work in a
-way similar to that for :ref:`DAMOS filter <sysfs_filters>`.
+way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the filter
+``type`` is ``memcg``, ``path`` file works the role of ``memcg_path`` for
+:ref:`DAMOS filter <sysfs_filters>`.
 
 .. _sysfs_targets:
 
-- 
2.47.3
