Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF52E739C;
	Tue, 14 Jul 2026 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003686; cv=none; b=KBWPgr9r5oax6gNRKo9cC+/uT4/t7BnzANysV/GH2+4ZVxR83ovtIApzevoa+SQZInMFDw00DMCl+tLFJVXLplAEjSriJzGFUSo9GNSUUVlj9VY0E05fi+S3KwhuU7YGYi6yZyLKxGbbkTODIpavGI3fCwj4+nsfieoekgP7KnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003686; c=relaxed/simple;
	bh=IOUFa3Rr5sUKqiSQ4949uWNUB9wvdhUOW3P60EqLuM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddq7X4UBby7jjy00CQvbncKWJgQ/EcKBMyE7WOHnt31C9ebO/x45ArvNsRScin20UyIkgYHVmdH/RqMwHq8iCeQb9c+ydJOZevMPQ0QXczPetvRspsq9mKjjztZNv2c/Dg5NMb2tbOQEjiuYE7rB8J1TLrHWFgGfN5AtRMdS3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o17T4qOh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o17T4qOh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88CC1F00A3D;
	Tue, 14 Jul 2026 04:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003684;
	bh=VsJ4wwCCUmuJy3/ZXQ2uE1d89EPU2Gxwaw+AywiLsUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o17T4qOhIETSz8POalLLjC1zKtxmiS27JkUXNPf8ba0nExsmyGUyAHpfooPZGMjRj
	 RRCOs9tYtBIoYJemdeqsLsuAsQheONHisBDQV+WbKZO6TqmjZU/2kHbY7XwUJ+N+VM
	 8wblpwJkK5qYJ1rG4qq+SMX1JksMSz43AZ/bbnNcf6Lx8HNFg+pQTT9Js7lMysSuRW
	 +N1zbH+PzTAFj7xi1y+NjCYkG/r2b1oRJTM54fQaAq2iZ5C0e1KpnKK0zgfqpbog2I
	 uAhXpHy7KMQUn5aXMmbgHBcnhNA5X2rIMxCzg6LexDYb+yY/mptiZV0R2hGy7wisBq
	 N2TocSceqTWPw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/10] mm/damon/core: hide private damon_probe fields
Date: Mon, 13 Jul 2026 21:34:34 -0700
Message-ID: <20260714043437.95811-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714043437.95811-1-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'filters' and 'list' fields of damon_probe are intended to be used by
only the DAMON core layer.  However, those are mistakenly not marked as
private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6c3c7c75b6ca3..537e59bfd7072 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -775,12 +775,13 @@ struct damon_filter {
  * struct damon_probe - Data region attribute probe.
  *
  * @weight:	Relative priority of the attribute for this probe.
- * @filters:	Filters for assessing if a given region is for this probe.
- * @list:	Siblings list.
  */
 struct damon_probe {
 	unsigned int weight;
+/* private: */
+	/* Filters for assessing if a given region is for this probe. */
 	struct list_head filters;
+	/* Siblings list. */
 	struct list_head list;
 };
 
-- 
2.47.3
