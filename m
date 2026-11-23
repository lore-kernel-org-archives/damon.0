Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446801;
	b=yJmq2nlnvGfih3dKdnqgkTPHmZefw6UUHAt0U79QF/NBzo9y6qPXVOqbY+rjtKZUd+kE
	 GkjkLjmKxD9I3e05/ys0yA4T91qbBxc5WHvX463PoofWy6UrP0L4iMoCKe87qMpCxk2qm
	 It5bu13yrm8cjE8RfIvDtX1q/dqt3NF2olov/oWk7kykuCwhVczJ5VAhbmmI4XiKEMsLN
	 vC9+rGgOkd3insoiTz/L4rYiPOQ9Y9FmmpyVWRpUey01YxkyiVj6fkBS0++kwy1AwD+Bz
	 SAaqxg+I8Hcqd+td22Ce6oiyFM0Y8uv/fHRr1lvjtvzg29wT++Hh+jU7oED20tu2rmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446801;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1mpej1tSUVKVbZbXvgjSwlFMXCUxn0nEZS2E76PYIAw=;
	b=ElrBrKf9Je8yzp/LXM/C9XP+ULbdTyY/4CGSnrElI6YDJphbGVRN9WffSScVeEBN9iB1
	 QqDlMorMvvhhV5QoxEPovgVrTbUGEVj+5hSQoY3wjtj3R4Fd+vVT7fOKBXGwrVigQ2520
	 piBaciW+o7doenO1ig0CFwH5AZ9jZmNJvW/bVzBdZWFqlwp0Csam95Zrqe4kn/HXMHlgV
	 pRvJfedwsckd67wO/uctZh5gh9SfFB+psOqlZ3WkvDNSJIWlBn6AH5iWc27CsxdjUkLS7
	 iFEUou7W0aTqk76ewmCnTViO1jHb4mfjbmB5eGbRdlzpKDjqrqUjUF8TEJgngMERNcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5dj3Mb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9373606A31A;
	Mon, 23 Nov 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5dj3Mb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F811F000D8;
	Mon, 23 Nov 2026 15:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446801;
	bh=1mpej1tSUVKVbZbXvgjSwlFMXCUxn0nEZS2E76PYIAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5dj3Mb9YWClwC82+rDqHgCQ33jNWa7Vvlfns1t1x+yApnSZEe8Cn+sbz9CcuPPEL
	 dog5VHj2S7+aI/2KdHDBLpIjfCF75PK/pW++N9nAEFePFQiVtZbN6ZuDJ+rtMb11XA
	 WtvkcRp2Hk6Nq4xceQbrlwpqgvVo+I5VYoV7Nj9rqgkGEArzxYcyn9KlBEeLiqpaGC
	 Q9A1KJ2D5YupU3sr+pr5iEnxGdkLIkI+tYkxKOjk+7/SYVSJ8wx/Zg6fSp6doT2jC4
	 sNe9jeulUe6KvHjsq3nBDjyTFHRQk9qTC95drVPZWV400b8OXqNNfGbyeoYLEn5Eyt
	 oj0kz4TyjjXrA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mattathias Pinchover <mattathias.pinchover@uber.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 5/6] Docs/admin-guide/mm/damon/usage: update for sz_ops_filter_passed_last
Date: Mon, 23 Nov 2026 07:13:06 -0800
Message-ID: <20261123151309.82675-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123151309.82675-1-sj@kernel.org>
References: <20261123151309.82675-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON usage document for the newly added DAMOS stat file,
sz_ops_filter_passed_last.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 6093b1c8fbfd9..51c4909f1a8b2 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -105,7 +105,10 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,
+    │ │ │ │ │ │ │     nr_applied,sz_applied,sz_ops_filter_passed,
+    │ │ │ │ │ │ │     sz_ops_filter_passed_last,qt_exceeds,nr_snapshots,
+    │ │ │ │ │ │ │     max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ │ probes
@@ -631,8 +634,8 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
-``sz_ops_filter_passed``, ``qt_exceeds``, ``nr_snapshots`` and
-``max_nr_snapshots``), respectively.
+``sz_ops_filter_passed``, ``sz_ops_filter_passed_last``,
+``qt_exceeds``, ``nr_snapshots`` and ``max_nr_snapshots``), respectively.
 
 The files are not updated in real time by default.  Users should ask DAMON
 sysfs interface to periodically update those using ``refresh_ms``, or do a one
-- 
2.47.3
