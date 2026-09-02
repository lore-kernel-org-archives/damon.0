Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9365438D686;
	Wed,  2 Sep 2026 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328077; cv=none; b=q0raR0GYEixYHRKjjlArWCpO+rbJVyO0WYDKrqyxYFKJUGu6ODYeFQ/y/Qv37KyCpzJ/qfQZRvUNFWn6B2ZAqa9t7Yb20Fyb3VD3XYYAe1E8TY7ak09F1mWlWW+NOuF/u5bNB3/dNnnZlcX5usX12D5SP/D6i7ORlYOKGh1ZhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328077; c=relaxed/simple;
	bh=tJ81LqCDpl5fr1uSBf5Rbm+l9ZSvjIXeCAoHO1HKka8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e02XSbbOes4VeSIT2AD5uNMHL1EdNrWc60PakUejN9tNFwr1etNlH2uqR7jU5clCdRqXCsnZv462ftTF7lLt1ob5YZ2yl4Va+wtX1ectrBYldNX3/hoL4Xn2EJI6Qe36zUpukT7iHbW1zZhrkwWqlMlH5kIO8ZvDbVLOJm5NdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksz/ymtj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksz/ymtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002AC1F00AC4;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328076;
	bh=I/Y67EhQFpjjEgQEnOWoPesL4POG7PDn7LCUxcCtOmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksz/ymtj5L/wmFgbbD7o9+SQyVMFyN5nQR5ZsxvxeJob4b+EGZptDEPduaWnIEzyc
	 WYT72MsN0hIT3tGnKr/6CAkqNznbELWLOtwcuxAyFPup8ue3Rj5Lx2ZvL2+fijuJI+
	 7O1PfMR/ie3XYAqefRFvh5pD74qymBvFIk15w9Z9mNXW5GpeWPlUWZQQvI9+0If4EI
	 2dZYE2M1w8whcZbsmry1LawYvHlhH86KhBwCWEIVii9zW5veuaKCd39MuqaaMYb1Tu
	 igTFv7QyGRQS2rn276w9JJncAG9thvSuo72jglCO2/KYbkm0cEPLrbRkzQpM+n/XY8
	 EpAmuqmhw5qzA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/12] mm/damon/sysfs: remove probes number validation
Date: Tue,  1 Sep 2026 22:47:38 -0700
Message-ID: <20260902054747.99370-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is disallowing >DAMON_MAX_PROBES nr_probes input,
since DAMON_MAX_PROBES is the upper limit of probes per DAMON context.
The core layer is validating the upper limit again, though.  It is
preferred to let DAMON API callers such as sysfs interface to set
parameters in flexible ways, and do parameters validation in the core
layer.  Drop the duplicated validation in the sysfs interface.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7ec14f48d157a..b576e97cbfdb8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1479,7 +1479,7 @@ static ssize_t nr_probes_store(struct kobject *kobj,
 
 	if (err)
 		return err;
-	if (nr < 0 || nr > DAMON_MAX_PROBES)
+	if (nr < 0)
 		return -EINVAL;
 
 	probes = container_of(kobj, struct damon_sysfs_probes, kobj);
-- 
2.47.3
