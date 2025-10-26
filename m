Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F82EF65C;
	Sun, 26 Oct 2025 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502945; cv=none; b=Q9BpqUipz2BjI3jU0vXHFYED/whav1gEFfSd2a/z/mWBkcW5f7UCfPwUfJ7Bpmg5Z+MTiQGxdZ0Mz5VGPgr1vj4gVtqy+nKgpjkI0CtqrdLpLekOFIQHx2Zf1FiXKxwEz5jRoNhk7GmePeIh6AvjiZTvhfRKwGtmmMczCH11HnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502945; c=relaxed/simple;
	bh=6KFGqHMIsMqbpZ/3NGUtXQIvFV13533Rw2CJqlg7hEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE0WWVkcJOtQTQfz/6HIyY717LGdQyixy/8JFVt9YTF9apuwmBaG1q/+2ko/N9uAj/+ULWOXFdTldAw6MeQR8noKjzVlTdhocObtTmt/NNBUAv1YaXWfpU6oXxMCgsxAiZaw1Z7zrkYbnns/PNYaaMM+9Ch6+K7dcR/J4wrHaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTAlIaFC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTAlIaFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F52AC113D0;
	Sun, 26 Oct 2025 18:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502944;
	bh=6KFGqHMIsMqbpZ/3NGUtXQIvFV13533Rw2CJqlg7hEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTAlIaFCfytgwXs9ORvXAod3Fz7oB58hyIdfeAIeJu5EwMeMSDUqlhKhIkn5ODmpD
	 qp7P/wbYITc5L5MWvAoJnSeUPat0zM69YQPvRvVJHIh3iRW1gO8iM1jdMybEKeUtUF
	 uaPhIU4SK+a2NMrYjjOml5gi38w+Rh3Mo5J67ZjMuwAp3STSGZdIGW96vhjbVADBKu
	 29sb9E46HBaFw7M9kUd+hByxhqalpWUuBNk/w85RVclxBwSAxyMml/gIWSt8AaflKf
	 JtMnsBeUFq9z0L5nNLX7vgz0fJRbkdv6hu4qgskZXaUHt1GmXtTGBQn6NLEiUVumBt
	 M1F+k6de/VBew==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/8] Docs/admin-guide/mm/damon/usage: document empty target regions commit behavior
Date: Sun, 26 Oct 2025 11:22:09 -0700
Message-ID: <20251026182216.118200-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026182216.118200-1-sj@kernel.org>
References: <20251026182216.118200-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Committing a monitoring target with empty target regions is for keeping
the current monitoring results.  This behavior was introduced by commit
973233600676 ("mm/damon/sysfs: update monitoring target regions for
online input commit").  The behavior is not documented, though.  Update
the usage document for clarifying this behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d8a3d6e740b3..9991dad60fcf 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -134,7 +134,8 @@ Users can write below commands for the kdamond to the ``state`` file.
 - ``on``: Start running.
 - ``off``: Stop running.
 - ``commit``: Read the user inputs in the sysfs files except ``state`` file
-  again.
+  again.  Monitoring :ref:`target region <sysfs_regions>` inputs are also be
+  ignored if no target region is specified.
 - ``update_tuned_intervals``: Update the contents of ``sample_us`` and
   ``aggr_us`` files of the kdamond with the auto-tuning applied ``sampling
   interval`` and ``aggregation interval`` for the files.  Please refer to
@@ -296,6 +297,11 @@ In the beginning, this directory has only one file, ``nr_regions``.  Writing a
 number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each initial monitoring target region.
 
+If ``nr_regions`` is zero when committing new DAMON parameters online (writing
+``commit`` to ``state`` file of :ref:`kdamond <sysfs_kdamond>`), the commit
+logic ignores the target regions.  In other words, the current monitoring
+results for the target are preserved.
+
 .. _sysfs_region:
 
 regions/<N>/
-- 
2.47.3
