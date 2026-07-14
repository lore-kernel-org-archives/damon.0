Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAFF1C6FF5;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003684; cv=none; b=oWHVfYhncstvIGGa20uliPZuFz2gvWtOug+0djjzIAi0dnXp6JMT5nUXfEj580Og9hTvoOExfZrJx86GH6K5rDdjC0mozoIU9ftmDEOlVzmFaWWeqPEWnl+al5tuAkdORiVBie2vvI0tjFGFHdbOgyj37dyqgdltiyAOVbur/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003684; c=relaxed/simple;
	bh=3PoFXRZE5p8gFw6SuUdvsbrJKOuvciCgPsJD1haajhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdFC0Z0+gUK1s6Igq8o2Q33yvRnGDwamD5ldA62sXhN4uwsFHf37Max/d9lZXNITBju53czsLPN4JaJ/ksLvsuuhHsjCu3IJSLw44GRvPJFVfkn1QXs9uZgpfJRzluZpkcTUGiqyl3qJPXwCDv7nrjlX8NKUFvwpnlWZy0ib+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nP6v27zd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nP6v27zd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A951F00A3D;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003683;
	bh=3wUP+A3V/Raa3GTzyt1oBi5Pi6+PUzbHoN/8enGeFJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nP6v27zd4aZIjybbP2COmXtRqP64OzGCediBE5NcFQI8GuA0zz1gNkaynT70/+zZk
	 yM+YIwnMmbkXKyTYLa0jGcOWwSzO6VuBYhrE3QZ/lHkw/w8SkMOme1mrQG4WpPLEEZ
	 Ad4GcPivWRMb3xXEXLWv5ahPmUJEBpH5ttpSp9s/LLZMW5HyqGzYkOcU2/jem0emEC
	 Hm9+poQXtUCUeZkviaPqjtr9ZHdHqc0GFWwu44Qdc9aqZOxpkkvgepa64ezz8nHjsF
	 4cv8fzPDSCneTLC+RaCJLT9e2tqMg4o3r0+BWRbNsxavDweTgBtn0dYb6ro2E6GufB
	 8EPNdi2OXrOzA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 02/10] mm/damon/core: hide private damon_target fields
Date: Mon, 13 Jul 2026 21:34:28 -0700
Message-ID: <20260714043437.95811-3-sj@kernel.org>
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

'nr_regions', 'regions_list' and 'list' fields of damon_target are
intended to be used by only the DAMON core layer.  Those are mistakenly
not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index d32377e7e535e..6e160557a0014 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -79,9 +79,6 @@ struct damon_region {
 /**
  * struct damon_target - Represents a monitoring target.
  * @pid:		The PID of the virtual address space to monitor.
- * @nr_regions:		Number of monitoring target regions of this target.
- * @regions_list:	Head of the monitoring target regions of this target.
- * @list:		List head for siblings.
  * @obsolete:		Whether the commit destination target is obsolete.
  *
  * Each monitoring context could have multiple targets.  For example, a context
@@ -95,10 +92,14 @@ struct damon_region {
  */
 struct damon_target {
 	struct pid *pid;
+	bool obsolete;
+/* private: */
+	/* Number of monitoring target regions of this target. */
 	unsigned int nr_regions;
+	/* Head of the monitoring target regions of this target. */
 	struct list_head regions_list;
+	/* List head for siblings. */
 	struct list_head list;
-	bool obsolete;
 };
 
 /**
-- 
2.47.3
