Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55966FA
	for <damon@lists.linux.dev>; Fri,  2 Sep 2022 12:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B5BC433C1;
	Fri,  2 Sep 2022 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1662123405;
	bh=HGl9Pb/xwY2wEwqJGiEKgOcUViCJqmT47gVsSgc8WXA=;
	h=From:To:Cc:Subject:Date:From;
	b=nsvDjFmOlgGYDfmS3pJhN5oHEGDJHFBDEfjiU9rM0rwL9WhCHWyXpsohTna4AnIHX
	 OVsvYJTHZYWnO+dqUZ+UioiveqF0OTqmEBJeRNCfpwCeRE/VnSkHYYR3TNpNB1zicb
	 OLoOoVw/8yXI5qbgYmWz/yVfQBT9n0HMmFrkMy6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	stable <stable@kernel.org>
Subject: [PATCH] mm/damon/dbgfs: fix memory leak when using debugfs_lookup()
Date: Fri,  2 Sep 2022 14:56:31 +0200
Message-Id: <20220902125631.128329-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=gregkh@linuxfoundation.org; h=from:subject; bh=HGl9Pb/xwY2wEwqJGiEKgOcUViCJqmT47gVsSgc8WXA=; b=owGbwMvMwCRo6H6F97bub03G02pJDMmCf2uuON1Zwc1X3R7CsCxz7eJ1cyTj560+/KuG8eUeCc8o D/2AjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZhIshbDbJbDjyybpHnPOFx+7cl/q/ mbpPWdSoZ5FheXHOx//unz9s8cjbJS5uedbwVsBwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  Fix this up by properly
calling dput().

Cc: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev
Cc: linux-mm@kvack.org
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/dbgfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index cb8a7e9926a4..dfb6ef8c83e0 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -915,6 +915,7 @@ static int dbgfs_rm_context(char *name)
 		new_ctxs[j++] = dbgfs_ctxs[i];
 	}
 
+	dput(dir);
 	kfree(dbgfs_dirs);
 	kfree(dbgfs_ctxs);
 
-- 
2.37.3

