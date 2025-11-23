Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031B2DC79D;
	Sun, 23 Nov 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763923426; cv=none; b=LyZfEzbnha67yCNWwFxL7UuiZWrxCH9vNS+hdxQFDzUHHBWPwgSP8blSrVvEa71TKZcJvR3Mlx7fxDNKK5NN+fqx+IKadyK72sQopAgNXdeKaVSa3V5wm4L/+EkiFEiVUgTkuc7KJg8m2HZmlmIgGnk6lpM2VOvG80hpOUzb25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763923426; c=relaxed/simple;
	bh=MfosQBkwjx3KXwTbjhH363GcqS+Z5CKxnOYfPNTR2Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHeIDdom5g3znqh/Ivj4dnzY3UjW6KpIiRtTWxIXDyvSwsmAJY870MLsi8nXk2UClrKb0ZtR5sdcgY6zELQBrpThj3v7AWh33dwQE+JrPR+WJ3mZkCERsQzwF4C9PrqkNHPv6Vmu0rBD7tetasarD6sG9WqupmfDCgKggi/sv94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzf43v1m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzf43v1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4F3C19421;
	Sun, 23 Nov 2025 18:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763923425;
	bh=MfosQBkwjx3KXwTbjhH363GcqS+Z5CKxnOYfPNTR2Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vzf43v1mBUX0UuIUB6lejQV22KhuCioTa+XZkyrKmUxCAN3RZshlIJT9eO2uUeQMA
	 XqbsH7XvIM4FDKqiQb8EmZU4/45WF/aDNo50DOt39X1JwG0bVqy35aXDseaEjByKPT
	 EjUhpd5bJl550PaXpzGmv1eEflrLI30GID4TjFRkYGYF18EfnJs+o1GjflLK9dTqM0
	 qHdu7ZRZK70H+XkAdAd1j/eT0nvTAWujdJsMb1vJjl1DzQ+hX+lVdN/+Q6XihPPlro
	 n50GfeGpiSUyBZcm7oK65jo1DcyKxBxM/c2pLurqJg6uLeqseqavg04wNlOKBjy3O+
	 AU94l7kBCINvg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
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
Subject: [RFC PATCH 04/12] Docs/admin-guide/mm/damon/usage: update for nr_snapshots damos stat
Date: Sun, 23 Nov 2025 10:43:18 -0800
Message-ID: <20251123184329.85287-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123184329.85287-1-sj@kernel.org>
References: <20251123184329.85287-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added damos stat,
nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9991dad60fcf..d0944bd78964 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -87,7 +87,7 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
@@ -543,9 +543,9 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
-``sz_ops_filter_passed``, and ``qt_exceeds``), respectively.  The files are not
-updated in real time, so you should ask DAMON sysfs interface to update the
-content of the files for the stats by writing a special keyword,
+``sz_ops_filter_passed``, ``qt_exceeds`` and ``nr_snapshots``), respectively.
+The files are not updated in real time, so you should ask DAMON sysfs interface
+to update the content of the files for the stats by writing a special keyword,
 ``update_schemes_stats`` to the relevant ``kdamonds/<N>/state`` file.
 
 .. _sysfs_schemes_tried_regions:
-- 
2.47.3
