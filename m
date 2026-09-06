Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863C1EB1AA;
	Sun,  6 Sep 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717019; cv=none; b=qCKlkPm5HtZdHZcdCD4pqmUjgB0eIAk4eB6YfrYlliRbz/DNxPmAs/oFfj6Mq15e7SDnqnTBEZSFK3I1U40EXDxVg7cl/X2NSJf6FjCgAS0uIo28cZ8xwsbT7nv9RVlnPs9prYZLuJYwJzq1l91l37PpeK8HXvfO0ppapxjDnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717019; c=relaxed/simple;
	bh=UYNii2J9N5IeNLw0Yeo1sxB3yu/PmjdINz6uaBoZpFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUVjtAFZGAFCcZdkM36lBzeY67F/5KD/E2Pg2ZPAu36Nl9fr4yZuHlJHZicfg6yjgS0ayrcEi1x1HW5emWsopbv3e7y0lEliTA0L0hb+3caHt9OLVZfc6IlzeBqUYyzXrhG8xy+9WeyfnO7wVZG4X/I0Lj4PK/OpUylDmygtRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLwmxA+0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLwmxA+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C231F00ACA;
	Sun,  6 Sep 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717018;
	bh=2EEU3ekWc3qyXmh8drgRUKtX2xzp7GdjGEtLM6CGh4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLwmxA+04ye3YGz0VBhemPW2m3i7srO/e5FLayoCNgdSE4uwwsDDD8JzkXkOGMoeO
	 8TkOYEqfSR0i9WcU4+Ec7NplPEQ9Wd4V4hfGzOra9ktb3/aGza9tGfOCGfI9OiTLUs
	 qTqwbHejvllNfb/fSbqG2zT2sYmyqZtmoBS1DGRb8sTFPlpoOyhjwOGehMOogvqjYk
	 mXIkOQkzy4oJFrCSTjvkkMDck24d0iEkmhX4FSzYrakSXFtz3FSFjBGVGf9qXAjW1v
	 EOxPe3WVikiUT65txO7SKZNxgrnfJ7oPTxhWFrTvjbH8SumATtFZrKtsw1JUSJ2y9z
	 m/xjoB9qRk+9g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] mm/damon/sysfs: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Sun,  6 Sep 2026 10:50:06 -0700
Message-ID: <20260906175009.93471-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906175009.93471-1-sj@kernel.org>
References: <20260906175009.93471-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to let users setup
DAMON_FILTER_TYPE_PGIDLE_SET probe filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b576e97cbfdb8..51fa506c879b0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1001,6 +1001,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_PGIDLE_UNSET,
 		.name = "pgidle_unset",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_PGIDLE_SET,
+		.name = "pgidle_set",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
-- 
2.47.3
