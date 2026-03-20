Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649936EAB7
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024507; cv=pass; b=MW33lxcNO75tEPQdtPbg1tlybyiKAoyh2/akTHAAz+7kUoKFwFa7NsfxVHl/oA99RABTCXNGybEbPUIVoXCc2PbCMKFLXAPs36tLAeQEGk6wglsuaX6ynJfPLi/ZBj1A+Sbqz4hMTrANZb9T8JSkFYTouYyJJQ35EzgJ+9kkmJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024507; c=relaxed/simple;
	bh=rXBnjOpdM4Zz9KkgGNRIZmxPV6JW3HhGTuomv2aKen8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lFBy4OuzPlZJLTEUMSFtyp95HY+ZCACu94QAMvPrpQlABVp6twFTE4fUEJWFxVCQQhcGZt9gS9rAFZxp75Ws0ghTvd6LCKevs7yztvFKj6BF2SVtD1rcXwm8PltEej8Wm9UOP8onWVNAq2esTdANOOCtbp3CceElFYwPlMp1p94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=IQcW4itx; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="IQcW4itx"
ARC-Seal: i=1; a=rsa-sha256; t=1774024502; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AM95RR5uphhvbypB5zZcKQyuhQk7YMVitMyutExXVXZ+078ZMhENcqQ4t4t5bYAAnhKUTNlitxmlXxvKYgIB6SIw69NG0mqK8yRCcXu2EbwUaklxT/oGNdGSsr/9QkTVkt2nMxB8kIlDvWiH+y9aY3txUm6wzT+UBXkO9syUsf0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024502; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xBhz+FP718xfFTo+Jqt21ir9B4N+Sz9WG+S91iYYSqU=; 
	b=cuDy398xA/BZzFaZTgMof76ZrElybYuGUf8hItLNkdOBCv9YkNMptn2/xf8hQUQLPBdyMXpX8TflzaI+5oa34xe0ezAruNWVe5dzhLWarbJzsMAm/gEhxxoLd5lWDVZgWAZ36h5Xjw8jl3prxuduCTIQ7IUbOzPGKVZ3X+rSmmg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024502;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=xBhz+FP718xfFTo+Jqt21ir9B4N+Sz9WG+S91iYYSqU=;
	b=IQcW4itxhvSjAeWAkGS291o2DHx7pM5CdohtNSGbnTqxs+WUqdeJwdjvurN/QrpW
	04Lvw8t/1GQZclHqSlX7vM6OJANpq4L5JYkNSah0AKN4XpDYA11S3h1UFaRbcil6cVS
	WprZNJxRuvTKTHqmGgHi+sYFNzb2Kztm4LtMQm+M=
Received: by mx.zoho.eu with SMTPS id 1774024498762636.5600957673564;
	Fri, 20 Mar 2026 17:34:58 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Fri, 20 Mar 2026 16:34:55 +0000
Message-Id: <20260320163456.177750-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320163456.177750-1-objecting@objecting.org>
References: <20260320163456.177750-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Multiple sysfs command paths dereference contexts_arr[0] without first
verifying that nr_contexts >= 1.  A user can set nr_contexts to 0 via
sysfs while DAMON is running, causing NULL pointer dereferences.

Guard all commands (except OFF) at the entry point of
damon_sysfs_handle_cmd().

Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
Cc: <stable@vger.kernel.org>	# 5.18.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b573b9d60784..ddc30586c0e6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1749,6 +1749,9 @@ static int damon_sysfs_update_schemes_tried_regions(
 static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		struct damon_sysfs_kdamond *kdamond)
 {
+	if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
+		return -EINVAL;
+
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);
-- 
2.34.1

