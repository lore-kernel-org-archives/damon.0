Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B3288C9D;
	Sun,  6 Jul 2025 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751827676; cv=none; b=awwEszYIeOCFyMCbVY2FFrUKdglHh5tpS5TIFX4Z8eEDYQF3zV8Gn6xrQi+6A52ZcOhPb1unAqRpt+HDdE1rwgTMWzO9m3ksu4h4DyAPXBFGqVbFAFr5/MkBSeAHvU9tFjhbngGjq36XfrvXwV8yr9wDPosr+qjc9mPD/DbH7xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751827676; c=relaxed/simple;
	bh=cLVy1mKDbWXN4aNjEWgP3z3+agHOP3HLGlEBVSPzMo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyOBkCPnF37PZqQituL0qPbCIYoDQyQwRWih9FCEXTfnRztZyPdWZsQI4EeRBPguPgXmIEMoQ6f2VqMOr3xnCYTK7tacQl7PpvQ4HnXncD5taYqUBI7vDWI2bthuoYjSUxYfO1Uk6jcJkijoOw3M9OSfJeDczSRkokLFyON3Jjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi5aF+Bk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi5aF+Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380C5C4CEED;
	Sun,  6 Jul 2025 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751827673;
	bh=cLVy1mKDbWXN4aNjEWgP3z3+agHOP3HLGlEBVSPzMo0=;
	h=From:To:Cc:Subject:Date:From;
	b=Gi5aF+BkOP3T/VA9JQHYB6C/56PWFLJUd7wtGFlkFdhxYtiem2dv0IfpbK6tJ9AlN
	 HcO8pguoHXH+bsEumkufysd1LM5Uq4WG+9uEYAVyElcohocskWgmym3zAgAR4cV39U
	 60V3lW6edNbBz5lljCvfgbMVseQt8/EkJZVI6mN9vhVuK7CduwBi5PkMvKW06h5eKQ
	 mglxOOqt9mPhZnUSQWppILgD1eBShf/dOq2p+OswraXym/990tDJu7wV6/M3Lq5r19
	 LrzAdCV0fdgXZSuoJj8aQCkKcL8wdn7D41d6rlfWg6RQaAzSQZS0wSiwqE2/zdFhIp
	 QqjFsXn+c8Zcw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-unstable] mm/damon/stat: reset enabled when DAMON start failed
Date: Sun,  6 Jul 2025 11:47:50 -0700
Message-Id: <20250706184750.36588-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When damon_stat_start() fails, 'enabled' parameter is not reset.  As a
result, users show the parameter 'Y' while it is not really working.
Fix it by resetting 'enabled' to 'false' when damon_stat_start() failed.

Fixes: 00e74895aba3 ("mm/damon: introduce DAMON_STAT module") # mm-unstable
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index c35bd1852f0b..b75af871627e 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -225,8 +225,12 @@ static int damon_stat_enabled_store(
 		 */
 		return 0;
 
-	if (enabled)
-		return damon_stat_start();
+	if (enabled) {
+		err = damon_stat_start();
+		if (err)
+			enabled = false;
+		return err;
+	}
 	damon_stat_stop();
 	return 0;
 }
@@ -240,6 +244,9 @@ static int __init damon_stat_init(void)
 	/* probably set via command line */
 	if (enabled)
 		err = damon_stat_start();
+
+	if (err && enabled)
+		enabled = false;
 	return err;
 }
 

base-commit: 93a51997eb1dda993197a9f82602b96d56056ce4
-- 
2.39.5
