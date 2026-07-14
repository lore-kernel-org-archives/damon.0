Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234E424113D;
	Tue, 14 Jul 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037689; cv=none; b=E8lC2N/nFFJChQre2VjYQuZsp+oGPVVkoSdLaGrakRES6opVRZYgtvhbjmqA2tk37tzEkQtCeWst6S+hOLrEJNjr7Q8DCdo1edng33QT+qDs8l0c/qM2UzOG3UypgBW5uMjl8Rx69sHVgNsRY1aL9ZqRNpTneSkOfutYJkFl0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037689; c=relaxed/simple;
	bh=e25KUFZxnwJTifqgSwNm3OJV6KI9eGLUGCzsbe02gpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIViT2SUtCZDQbCtwW7YElPLD2Vkxn/5YN7ymAPQbV1RI1iS8IFz0zNCZRcoNzQfxoXot+8LzXZRygwOn/CfGnaoXz2r6gqaebd4Kbh5J93l3fNYGnDD7YJ57VXw2WhPiIF3yijflhWyVQc3nVF7Yjlij6QIo2oKYtb1Ry+Wdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1Qmz8zG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1Qmz8zG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBFE1F00A3E;
	Tue, 14 Jul 2026 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037687;
	bh=n7qOC1hPo3tbMkwq7x1pZdPtxpK7hMGOrFhAtGtd6Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1Qmz8zGykgyGp/UmXb6jvDz//HiCwngfJhcRAVSo6F+0K2Yse7uQ8rN0D/zWAeLN
	 UIhEPHf6VHF/kyu5riwI/jdnOvtl6ah/qyqfYYzA+CjoNdhAu+NsHBfKGrg40wb2R6
	 xLcc+iUBq0dIgQAGimgBsjRbN/E1SgKJ1op2pfIHw/vgNcXB/MeDC/QUjihvp4yqpb
	 CededniINVzEJF485er1ojMgOnu0Yj6hwAGwdticwZp4ZN6qWs6mYuvduIWdl3lhLW
	 9HPGi9aGxRhcAvqSTx8aae55vmljLkZRWzyX0A0vZRlIvEVpMUZd1M9lQO+wbYs547
	 wPSLJNFxWX85A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Song Hu <husong@kylinos.cn>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	SJ Park <sj@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 2/4] Docs/ABI/damon: fix typos
Date: Tue, 14 Jul 2026 07:01:14 -0700
Message-ID: <20260714140117.94147-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714140117.94147-1-sj@kernel.org>
References: <20260714140117.94147-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Hu <husong@kylinos.cn>

Fix two typos in the DAMON sysfs ABI document:

  - "WDate:" -> "Date:" on the nr_regions/min entry
  - "manimum" -> "minimum" in the nr_accesses/min description

Signed-off-by: Song Hu <husong@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index a8269123b4231..f3c99c79b0f57 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -144,7 +144,7 @@ Description:	Writing a value to this file sets the maximum value of
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/nr_regions/min
 
-WDate:		Mar 2022
+Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
 Description:	Writing a value to this file sets the minimum number of
 		monitoring regions of the DAMON context as the value.  Reading
@@ -287,7 +287,7 @@ Description:	Writing to and reading from this file sets and gets the maximum
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/min
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
-Description:	Writing to and reading from this file sets and gets the manimum
+Description:	Writing to and reading from this file sets and gets the minimum
 		'nr_accesses' of the scheme's target regions.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/nr_accesses/max
-- 
2.47.3
