Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17D47DD50;
	Tue, 14 Jul 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039759; cv=none; b=BvdnXlwQ3HPVB2DbbRuE0gcQdqW1WbgWYSaR9YVh+xIqEcAWvtQOFFr2Ef4hR0dwR6oSnv8w9pmXE0adqf3PLACIjFBu6a+DmsMqAo6KTOCtxW2IHDozoxutCVPXCRCgrbV9nKzRzNpZrrOYmp3bdCiLxnhyj7AxxtXeyPueVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039759; c=relaxed/simple;
	bh=IOUFa3Rr5sUKqiSQ4949uWNUB9wvdhUOW3P60EqLuM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlpdGfEJVj8MORgA15Q3m+uXkSIlSfHxUCBZekAcW2B3dkpuj+p9aSeUEQuUCcQDU4NDD5BEiU3/zwYKMuDHNl5tIYu4WdbQRWlrfucoR3kHlSyOZJ+wUh27nuqKdY/41zbYe8LC80hpiCLXSRz65giPw43QHXzSeHqLbyls1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHVsmuS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHVsmuS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7291F00A3A;
	Tue, 14 Jul 2026 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039757;
	bh=VsJ4wwCCUmuJy3/ZXQ2uE1d89EPU2Gxwaw+AywiLsUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BHVsmuS9moeWjE4tXVfnnYQuqO+Hokd4h4sU2eeIZX7PWSuvAPLdNNEfqMIw7orJK
	 RQ+CUztOvWnC0IL13lSQaGTmdo4FIqueuiE0pcva7klegfFkWM+Vh9BZWMJ+24CikT
	 iNoTjKGfEFWXgfQBE0W0YOIj7WaUdTgAJfyfkIVbb3pU7xfVq+ezJrSnVVyKjToFYE
	 8gOzsB1ZwPaDrsHc8XHxT6yYf0icrdmAEeN0C7CJYA93YjCrD4bxQ8ZS9617AGKbvl
	 UojG2hXrMdm9XKw/GGql/hO32oCCRZzTjdP11hxMnpFGuo4N6/sBE1PosYjWHfJkqg
	 Ic2egsfroHcTg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/10] mm/damon/core: hide private damon_probe fields
Date: Tue, 14 Jul 2026 07:35:41 -0700
Message-ID: <20260714143544.101305-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
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
