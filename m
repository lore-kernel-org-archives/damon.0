Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C973C3BFE;
	Tue, 15 Sep 2026 14:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482850; cv=none; b=uznFB2GTvu/O6v1W6QLa7CZpnt05uZfMgHQi60RabMLYFiqz9lSA+qF2SRHZTxDFu0aMM38kGbS/vISjJNZTA9f1UCg0F602msFkcQBh05Yi/exYKcfL+K7zDx/8bvBM/Texkp1IK1mmvuLwIQY2rBN23eyRs7neeblQuFjvpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482850; c=relaxed/simple;
	bh=hGYrlp8BUYEplerJ3NeTyfTllMHPJtU0fdxbw3cZ6Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEqcIFES8R+FxtKGnITvgyMf8PapDhQf+DnvbdcNAbAVxDZO/Fd2ZrwyKsUaQ+HcgeUxLdFnR8TjTVJeFxmChwd59s6S7OBy/k0BJtMmoRVGEx2Q+zMDBnxtwW/6S76aXWNhZQB/nmRf7HXB1XS5jXNtrwxL/vo+eVZnaRNV9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKTfjrvb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKTfjrvb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C02F1F0089C;
	Tue, 15 Sep 2026 14:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482848;
	bh=Gmq/rX+sVM9Hs+BxObGYka5NbSCER5H2QYTBCAxyvwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IKTfjrvblH1XAFUn2DjPAqJOUKpweJegz/oaoeuPnAb1YEh/1NPFZV+zp8yF7an9v
	 upCA7m6JMQQSaY0IyOiGHkKeAmVmp/illE1BkjKz5QkNGofmZdbdNcN5ythcp43cLQ
	 eUk0zpBFHAiFtnNwS+kmJ4AD5sZTpb6lQLqPmSOLDic1MYof6fLjIhQGVnUnno9E46
	 /rhr6AzaKVFx4oRc3o5rVBkPm1w+8fMdLO1p4Ruw0m/IAi8ztHUJMtGgE+/UILgj6F
	 YEGbY372kdAxW75yeVzVD5U/SO7diUak6zDkMiNu3mAliSybM/f/mP9Fkm3E8FHa9N
	 OYxmEhPjvDOcQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/8] mm/damon/sysfs: support hugepage_size probe filter
Date: Tue, 15 Sep 2026 07:33:54 -0700
Message-ID: <20260915143359.91472-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to support hugepage_size probe filter.
Allows hugepage_size user string input to the filter type file.  Pass
the size range argument that users set via min/max files under the probe
filter directory to the DAMON core.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 8e8d89b8ed981..43519afb9eb7f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1007,6 +1007,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_PGIDLE_SET,
 		.name = "pgidle_set",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
+		.name = "hugepage_size",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
 				damon_destroy_filter(filter);
 				return err;
 			}
+		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
+			filter->range_min = sys_filter->range_min;
+			filter->range_max = sys_filter->range_max;
 		}
 		damon_add_filter(probe, filter);
 	}
-- 
2.47.3
