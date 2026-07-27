Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE63F231C91;
	Mon, 27 Jul 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163114; cv=none; b=GB7lI08UkRNvBfEnaogCCEoftvVXkIIxw7uQYGcqk41xBTULdwO9J/gxXi+Ec4+aOkVjU9VddyfhpPvkkrDrMh60h0Nq5Bjq6ZlnQgMZMi8aCm0TeHBumEin36Fl15I1U1AEb/0V2bDz0MkQIvPgUs5zlmBa9tsBsy1lORmgyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163114; c=relaxed/simple;
	bh=o3hI53B8za+nhkok//HqpRTOEsjaqqLqJHmMQj9SDvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kILqH11J8K8BqxpQVql51eIcR+op+N/31EUSgKsrFwWQ6XmBq3vaL0S88hWeGD6rrzDPpCEVqgEn3aIcrboxw606r3OCG0CB4Z1zTUl/frsbExNNslTugwiJzZfOmhG3fTuSMSKSWm7l1YWQNRtKcHiKr6p4lX8grKVjeuZFtbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsy8hw1D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsy8hw1D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DA01F00A3F;
	Mon, 27 Jul 2026 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163113;
	bh=cAfIlLPcU4sckuDrbS7eOEg3BQtpmGkcQ7Y936FLtiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tsy8hw1DgDSNspr/lcSPF7lu2IsPLyJViuxRiMuF7F2IGrO9X4AuZQG7Z1iAs3x9t
	 Jgx6tzvfT3XemjNww+5whkyC63EG7Wwfep7e3uVEdF+y3wpqwFzoT0rsCwqe8e2sWG
	 gSDwVZbg4w4z5bSd5fm5xkjb15EUyKSIrTPnazmCKnEinNyLk30trRcz9cl0OyXEzJ
	 ugVtr1binJO60JzkdPMier+r2rvHZk1pwKMS2C/qfOCDqu8PIgIK3TS4UL6rsZV1Mm
	 jMJWpd+lbTbNS1XlgHllEfF907q3BLKcuyxR9x4OaKR9AtGg3wqhtjXgzekQApcnXF
	 HsFUXjSPt374A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 03/17] mm/damon/sysfs: support pgidle_unset probe filter type
Date: Mon, 27 Jul 2026 07:38:12 -0700
Message-ID: <20260727143829.86236-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to allow users to set
DAMON_FILTER_TYPE_PGIDLE_UNSET by writing 'pgidle_unset' to the probe
filter type file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 053ba2e53b969..376c6ecbd4bf3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -782,6 +782,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_MEMCG,
 		.name = "memcg",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
+		.name = "pgidle_unset",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
