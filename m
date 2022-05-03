Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567C7F
	for <damon@lists.linux.dev>; Tue,  3 May 2022 18:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3243C385A4;
	Tue,  3 May 2022 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1651601264;
	bh=SCWU4RSKd7GJX8RI04zMEXi1tqeXseu+CufxWRBwHqo=;
	h=From:To:Cc:Subject:Date:From;
	b=oZ0k9l6ya1qO1ghGjCHYuqQuSZIaN0Kr8sjbw0JmBVN3WvvBCIh1AvxiuEZbd6S2P
	 aeCHisDrsOgb7Nn4zgvum54KRt7i0KxrBaunp9ZvJQmSS1C6X1esCfGlBE+S66LXJQ
	 PS5Jb7afdukemUQjiWM1xEHzda2ua2VAMIuv0eIgBqi+/QoM5XHF1DgAJR2XlCf8cw
	 52W55OAmER/leA+JpOfJ6h38XMqK6nteyWzCEzPMGJNUesJTgMAHX+FC5VfrKQndxc
	 ObO2nMnd/IIJdsNkLcmJMmbdnvP3AX3JZdteyJhO0grArcLUlztabU0YumP+1y4TlD
	 MHDMV42xqm5ug==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-damon@amazon.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH] MAINTAINERS: Add a mailing list for DAMON development
Date: Tue,  3 May 2022 18:07:41 +0000
Message-Id: <20220503180741.137079-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an open mailing list for DAMON in MAINTAINERS file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 701504ef2902..56a751fca360 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5457,6 +5457,7 @@ F:	net/ax25/sysctl_net_ax25.c
 
 DATA ACCESS MONITOR
 M:	SeongJae Park <sj@kernel.org>
+L:	damon@lists.linux.dev
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-kernel-mm-damon
-- 
2.25.1

