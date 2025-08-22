Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885682F7457
	for <damon@lists.linux.dev>; Fri, 22 Aug 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856099; cv=none; b=TWXNi28S7ikya089GL7SH7dDMoiV0SApEi7M6tMMf0ZZB4JabL1/WvwQidfIN2VqZ8HBstupP1mgLdmQURmUEH0wDtGSex3SvD2j/XmzkiLQVFZ7LSOSOhpf9qYJfDOXxXvyBRKBm9C56aJqoVgYPHdhxj04dyLIXLv9YtmioB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856099; c=relaxed/simple;
	bh=TcIoYhVEN2MsnPWOdHUGQFFGryKD1imr36MDA4Fif0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHmKjME0GlWAncDMdyehROlA1g8eONkYpWxGV99deQGFcBZVjL59IUnp3GGD7mXJnCSt3we1ogSci0wGWLj1QrTRbulrRvFP6SHg6kAwXtL7zP8gbLZNH204Q47RKnHcM+aP7m23NUO7+dB5Sktlofc2YRpHRMgEW5UrXmUQB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c7b006GKqz24hrS;
	Fri, 22 Aug 2025 17:45:20 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 16E80140109;
	Fri, 22 Aug 2025 17:48:12 +0800 (CST)
Received: from huawei.com (10.50.85.135) by dggpemf200018.china.huawei.com
 (7.185.36.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 22 Aug
 2025 17:48:11 +0800
From: Quanmin Yan <yanquanmin1@huawei.com>
To: <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<yanquanmin1@huawei.com>, <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: [PATCH v2 10/11] Docs/ABI/damon: document addr_unit file
Date: Fri, 22 Aug 2025 17:34:18 +0800
Message-ID: <20250822093420.2103803-11-yanquanmin1@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822093420.2103803-1-yanquanmin1@huawei.com>
References: <20250822093420.2103803-1-yanquanmin1@huawei.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf200018.china.huawei.com (7.185.36.31)

From: SeongJae Park <sj@kernel.org>

Document addr_unit DAMON sysfs file on DAMON ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 6791d879759e..b6b71db36ca7 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -77,6 +77,13 @@ Description:	Writing a keyword for a monitoring operations set ('vaddr' for
 		Note that only the operations sets that listed in
 		'avail_operations' file are valid inputs.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/addr_unit
+Date:		Aug 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing an integer to this file sets the 'address unit'
+		parameter of the given operations set of the context.  Reading
+		the file returns the last-written 'address unit' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.43.0

