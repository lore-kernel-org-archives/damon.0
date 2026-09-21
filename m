Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040224BE433;
	Mon, 21 Sep 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003764; cv=none; b=NAYs6Enh1UPhuWpzNr/4vT4EIKqRidyg89e7lrTNG//pkAKFA5bA210o7VgRKUo+DC8FnFTJF5OPR7TP8YTdSljnBU0fFsl08DZ6yu9uRDpFz9CrWJM9ZE6SWyDA/LufvymSO64iYx/SDsgE8cqYI0AtAs8XKSgE8JNvjOlt2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003764; c=relaxed/simple;
	bh=DHEQNVH304dFHicWq52GyticC8lXMEruY2thjkBwJ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXTlqb3855spkYnOa1nwLhiU3onFebtL4IIWri9lJfz2YmD7/0MxYWCNl/e0uV//qwt3KDPNwtFQauhXRAL0g3JO6jhWOxrwVozZte6f7D5ZcjW2t8WIaMpdBOT4IkB5Sd/OFbzPntYPTd4s/1Mqf8F6NCA06HQex4oTJT+wbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNF9xyVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNF9xyVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C537A1F00893;
	Mon, 21 Sep 2026 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003762;
	bh=hOvG/uo1bcbPermo8brtuzKlqeWj0xatwdIh6bjgz5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lNF9xyVLj41JefydyGx3JzxqT5j0YaN32U2Of7wQEspNIopu0YEFYUyAkCkfCw8cr
	 FCtVPu3/wHKKG2DsljiMyt/yZuL+/Fa9aui+A+uBZg+Vc0ti+qEroNjZSkvpNgGKJU
	 pNsGpvuSAVaY6jQI3hobjXB9oLvLsEGHwMZ6jiRwnfRGbvr5e6UFh59vJP+irwm4ql
	 5pEk4jcRocgT27DGtPS0DzBuT4nx/PKL6n0cuBn/SgbBl5RdKteVS5VasCmucA3UpD
	 B3YJoRf5mzIC/TkyG4Hv9YEJP8wXB8hq0DYs2IninuqjATB0FNKhXm9VimeZ42JP0u
	 xCn1LrwjvY1tA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karthikeyan KS <karthiproffesional@gmail.com>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	Xuewen Wang <wangxuewen@kylinos.cn>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/4] mm/damon: document that a zero sample_interval is accepted
Date: Mon, 21 Sep 2026 08:15:46 -0700
Message-ID: <20260921151547.78472-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921151547.78472-1-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan KS <karthiproffesional@gmail.com>

damon_set_attrs() accepts sample_interval == 0.  This was reported as a
bug in v1 of this patch (rejecting it in damon_set_attrs()).  A similar
patch was already declined for the same reason: a zero interval is
intentionally supported [1].

Document the behavior instead of changing it.

[1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.com/

Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v2
- v2: https://lore.kernel.org/20260918131301.75879-1-karthiproffesional@gmail.com
- Collect R-b: from SJ.
- Rebas to the latest mm-new.
Changes from v1:
- Dropped the damon_set_attrs() rejection and the KUnit cases that
  tested it.
- Added a kernel-doc note on struct damon_attrs's @sample_interval
  instead.

 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 836353c4ab9a..844b175120f0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -836,7 +836,8 @@ struct damon_probe {
 /**
  * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
- * @sample_interval:		The time between access samplings.
+ * @sample_interval:		The time between access samplings.  Zero is
+ *				accepted.
  * @aggr_interval:		The time between monitor results aggregations.
  * @ops_update_interval:	The time between monitoring operations updates.
  * @intervals_goal:		Intervals auto-tuning goal.
-- 
2.47.3
