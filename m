Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEB2641CA
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024568; cv=pass; b=GlZsESEl2Jrae5BSL1BsY65B33/WPx03fkTGDJHNl5DCifmstwaXEY/4tRQc0Bj0MKkEOLgONG0Uu+P7F3sWvNU8s0APLAUuX8bMO2RZt7lbfi5OoNXoeMSi7SRRL5RQFIRiuXhD/ifks5O0P6H9alsgvfOyl7W1cC0QPCDdIeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024568; c=relaxed/simple;
	bh=rXBnjOpdM4Zz9KkgGNRIZmxPV6JW3HhGTuomv2aKen8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSD71WuMd7nnklPEjGW0dnaDC+i9d+SEhvodjHVa2AkNHrv/9nySWkCfZ4wm7CY/cqgXC4uIugDMNhApwIuRUXeeE9hCVgI9YhA7rFLmvgFHqPs6jtSnFC/iH4v5rZ46hig7QZmlhEImxj2lanW6jYhLuF5U6pPK56Z2gA3e2As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=I+rSrwmd; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="I+rSrwmd"
ARC-Seal: i=1; a=rsa-sha256; t=1774024563; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ff8X3tljHjklyFzeIFOMCAdNbLmebNvpYED9ZqvO5oAD7NDG1a45ss15UN6rHaeUpEF87bR6hsw4wmrIsW2j4KmhzuOc7YqAQmp49YiORUQdPIhzYlGKnYBxHdBY6IvtkY15H0jjAhxHRjbrnZfAMb0ojGsK1vvlG2ydZXgLss0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024563; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xBhz+FP718xfFTo+Jqt21ir9B4N+Sz9WG+S91iYYSqU=; 
	b=Et+EfbnAdIfTOdfn2PjpJQeP4ypoP4uxvfKy9C1+AVGQSrKOzpFxuK7BPala0qvsStG2h0MF5C9Vz0ZZBbUMHrev2ZelqjEqefje9uXmFIr7pMwMhYnilH65aFwi3j1ZEFivFfdGiaZRrG4H54WJnbRnJm0P6hbq1y5HQZiyQUg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024563;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=xBhz+FP718xfFTo+Jqt21ir9B4N+Sz9WG+S91iYYSqU=;
	b=I+rSrwmdO5diJIt0LdFNl3Yk3dlXhjTt0x0zyF30VEYe6opl27xXPDSUJJ3tXuYj
	1CMYjf3lBkYeKUDR3YP7NTyVHGex8JG3e8me/ea7fJzJV7H4XsLbLeKHaO5n+mTseGj
	7/xRFtAU2A4eivvzCxi6s6B3sCWpX/vEWTlm4eh0=
Received: by mx.zoho.eu with SMTPS id 1774024562167191.42267947695075;
	Fri, 20 Mar 2026 17:36:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Fri, 20 Mar 2026 16:35:58 +0000
Message-Id: <20260320163559.178101-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320163559.178101-1-objecting@objecting.org>
References: <20260320163559.178101-1-objecting@objecting.org>
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

