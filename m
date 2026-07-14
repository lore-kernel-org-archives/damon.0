Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070A370D65;
	Tue, 14 Jul 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039757; cv=none; b=LFjBHqJnMlQWhHj9Hb6a8dhTmeWQQO7KqBFSSEsIEVxtoiuY2bRM8YyoVxdgyQJrA9qTo1A9LJ9HYI92HkzxwMInzJEyYDzTf8zJfm5cjr+KeAvm9CacpCrMCPuEv3er1PxZMtmFQJjPf1BnsGfvHabJQdNdkKnga/5kl2T3oFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039757; c=relaxed/simple;
	bh=3PoFXRZE5p8gFw6SuUdvsbrJKOuvciCgPsJD1haajhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSmJVZT/D6EaaueZyQhMuRN9CJRRXwJ5zhc1L1JM9wApE/wyxg+3GQ7mKxYMXmXcYI+U5IpydU3yG1VvoE8nr6y7VdZD/zhvEbU7idq4Hjn7Oox2OS1jFPQvZbaKAvy7Wr27vngLdcqbBHbGlGQJfY2qC/okPFFtKwjrY55+o+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5Rf4pxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5Rf4pxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE371F00A3A;
	Tue, 14 Jul 2026 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039755;
	bh=3wUP+A3V/Raa3GTzyt1oBi5Pi6+PUzbHoN/8enGeFJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l5Rf4pxgD2IqkG6wezOZ27v3qi0J9YlVZMPXvUIKQStRrG5i7Ol79FfGQs0PXllkX
	 /U99kUO56V7z4iF+6RPR2hIpPnyweTw83kEMrmiSLpt7sB5S+eqdP2nd+304yU0q+o
	 OitdBloS4IHWRFIADoI5NOjjy7Pw673U6KdrrBEdw57NbyU/aUxpGCIUuid9A0qQcL
	 kjlUbWkJMLuS1Nfp+t5gl4JWk7ii301Bq7ALbhPhKiA8aFswJC59sodNe1q4ocBXym
	 G++xPcuYIA/7bm4aAe17CIv9tofBE0RqnzPu7hzss9VKis0N36mM99aM7pfTVwmHMR
	 Zk3Hfz1nz2bkA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/10] mm/damon/core: hide private damon_target fields
Date: Tue, 14 Jul 2026 07:35:35 -0700
Message-ID: <20260714143544.101305-3-sj@kernel.org>
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
